import 'package:flutter/material.dart';

import '../../../../core/base/view/base_widget.dart';
import '../viewmodel/splash_page_viewmodel.dart';

class SplashPageView extends StatefulWidget {
  const SplashPageView({super.key});

  @override
  State<SplashPageView> createState() => _SplashPageViewState();
}

class _SplashPageViewState extends State<SplashPageView>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _animation = Tween<double>(begin: 170.0, end: 0.0).animate(_controller);

    // Add a listener to the animation
    _animation.addListener(() {
      setState(() {
        // The state that has changed here is the animation value
      });
    });

    // Reverse the animation when it completes
    _animation.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _controller.reverse();
      } else if (status == AnimationStatus.dismissed) {
        _controller.forward();
      }
    });

    // Start the animation
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BaseView<SplashPageViewmodel>(
        viewModel: SplashPageViewmodel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
        },
        onPageBuilder: (BuildContext context, SplashPageViewmodel value) {
          return Scaffold(
            backgroundColor: const Color(0xff86ADCA),
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: Stack(
                alignment: Alignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: _animation.value),
                    child: Image.asset(
                      "assets/images/frame2.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width - 60,
                    ),
                  ),
                  Image.asset(
                    "assets/images/frame1.png",
                    fit: BoxFit.cover,
                    width: MediaQuery.of(context).size.width - 60,
                  ),
                  Padding(
                    padding: EdgeInsets.only(bottom: _animation.value),
                    child: Image.asset(
                      "assets/images/frame3.png",
                      fit: BoxFit.cover,
                      width: MediaQuery.of(context).size.width - 60,
                    ),
                  ),
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 70),
                      child: Text(
                        "RELEWALLET",
                        style: TextStyle(
                          fontWeight: FontWeight.w900,
                          fontSize: 26,
                          color: Color(0xffA8BFD0),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
