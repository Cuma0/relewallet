import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/theme/light/color_scheme_light.dart';
import '../../../core/theme/light/text_theme_light.dart';
import '../../cardsPage/model/storie_model/storie_model.dart';

class StoriePageView extends StatefulWidget {
  final List<StorieModel> storieList;
  const StoriePageView({super.key, required this.storieList});

  @override
  State<StoriePageView> createState() => _StoriePageViewState();
}

class _StoriePageViewState extends State<StoriePageView>
    with SingleTickerProviderStateMixin {
  late PageController _pageController;
  late AnimationController _animController;

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _animController = AnimationController(vsync: this);

    final StorieModel firstStory = widget.storieList.first;
    _loadStory(story: firstStory, animateToPage: false);

    _animController.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _animController.stop();
        _animController.reset();
        setState(() {
          if (_currentIndex + 1 < widget.storieList.length) {
            _currentIndex += 1;
            _loadStory(story: widget.storieList[_currentIndex]);
          } else {
            // Out of bounds - loop story
            // You can also Navigator.of(context).pop() here
            _currentIndex = 0;
            _loadStory(story: widget.storieList[_currentIndex]);
          }
        });
      }
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    _animController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final StorieModel storieModel = widget.storieList[_currentIndex];
    return Scaffold(
      backgroundColor: Colors.black,
      body: GestureDetector(
        onTapDown: (details) => _onTapDown(details),
        child: Stack(
          children: [
            PageView.builder(
              controller: _pageController,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.storieList.length,
              itemBuilder: (context, index) {
                return Image.network(
                  widget.storieList[index].picture!,
                  fit: BoxFit.cover,
                );
              },
            ),
            Positioned(
              top: 60.0,
              left: 10.0,
              right: 10.0,
              child: Column(
                children: <Widget>[
                  Row(
                    children: widget.storieList
                        .asMap()
                        .map((i, e) {
                          return MapEntry(
                            i,
                            AnimatedBar(
                              animController: _animController,
                              position: i,
                              currentIndex: _currentIndex,
                            ),
                          );
                        })
                        .values
                        .toList(),
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 1.5,
                      vertical: 10.0,
                    ),
                    child: CoverProfile(
                      storieModel: storieModel,
                    ),
                  ),
                ],
              ),
            ),
          storieModel.link != null ?  Positioned(
              left: 10.0,
              right: 10.0,
              bottom: 70.0,
              child: Container(
                margin: const EdgeInsets.symmetric(horizontal: 70),
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        ColorSchemeLight.instance!.blue.withOpacity(0.7),
                    side: BorderSide.none,
                    fixedSize: Size(
                      1,
                      context.mediumValue * 1.3,
                    ),
                  ),
                  onPressed: () {
                    _urlLauncher(url:  storieModel.link!);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Link",
                        style: TextThemeLight.instance!.button
                            .copyWith(color: Colors.white, fontSize: 18),
                      ),
                      context.lowSizedBoxHorizontal,
                      const Icon(
                        Icons.link_rounded,
                        size: 26,
                        color: Colors.white,
                      )
                    ],
                  ),
                ),
              ),
            ) : const SizedBox()
          ],
        ),
      ),
    );
  }

  void _onTapDown(TapDownDetails details) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double dx = details.globalPosition.dx;
    if (dx < screenWidth / 3) {
      setState(() {
        if (_currentIndex - 1 >= 0) {
          _currentIndex -= 1;
          _loadStory(story: widget.storieList[_currentIndex]);
        }
      });
    } else if (dx > 2 * screenWidth / 3) {
      setState(() {
        if (_currentIndex + 1 < widget.storieList.length) {
          _currentIndex += 1;
          _loadStory(story: widget.storieList[_currentIndex]);
        } else {
          // Out of bounds - loop story
          // You can also Navigator.of(context).pop() here
          _currentIndex = 0;
          _loadStory(story: widget.storieList[_currentIndex]);
        }
      });
    }
    // else {
    //   if (story.media == MediaType.video) {
    //     if (_videoController.value.isPlaying) {
    //       _videoController.pause();
    //       _animController.stop();
    //     } else {
    //       _videoController.play();
    //       _animController.forward();
    //     }
    //   }
    // }
  }

  void _loadStory({required StorieModel story, bool animateToPage = true}) {
    _animController.stop();
    _animController.reset();

    _animController.duration = const Duration(seconds: 10);
    _animController.forward();

    if (animateToPage) {
      _pageController.animateToPage(
        _currentIndex,
        duration: const Duration(milliseconds: 1),
        curve: Curves.easeInOut,
      );
    }
  }
}

class AnimatedBar extends StatelessWidget {
  final AnimationController animController;
  final int position;
  final int currentIndex;

  const AnimatedBar(
      {super.key,
      required this.animController,
      required this.position,
      required this.currentIndex});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 1.5),
        child: LayoutBuilder(
          builder: (context, constraints) {
            return Stack(
              children: <Widget>[
                _buildContainer(
                  double.infinity,
                  position < currentIndex
                      ? Colors.white
                      : Colors.white.withOpacity(0.5),
                ),
                position == currentIndex
                    ? AnimatedBuilder(
                        animation: animController,
                        builder: (context, child) {
                          return _buildContainer(
                            constraints.maxWidth * animController.value,
                            Colors.white,
                          );
                        },
                      )
                    : const SizedBox.shrink(),
              ],
            );
          },
        ),
      ),
    );
  }

  Container _buildContainer(double width, Color color) {
    return Container(
      height: 5.0,
      width: width,
      decoration: BoxDecoration(
        color: color,
        border: Border.all(
          color: Colors.black26,
          width: 0.8,
        ),
        borderRadius: BorderRadius.circular(3.0),
      ),
    );
  }
}

class CoverProfile extends StatelessWidget {
  final StorieModel storieModel;

  const CoverProfile({
    super.key,
    required this.storieModel,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        CircleAvatar(
          radius: 20.0,
          backgroundColor: Colors.grey[300],
          backgroundImage: NetworkImage(storieModel.coverPicture!),
        ),
        const SizedBox(width: 10.0),
        const Expanded(
          child: Text(
            "Relewallet",
            style: TextStyle(
              color: Colors.white,
              fontSize: 14.0,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        IconButton(
          icon: const Icon(
            Icons.close,
            size: 30.0,
            color: Colors.white,
          ),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  }
}

Future<void> _urlLauncher({required String url}) async {
  if (!await launchUrl(Uri.parse(url))) {
    throw 'Could not launch $url';
  }
}
