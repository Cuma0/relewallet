import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/base/view/base_widget.dart';
import '../../../core/components/buttons/text_button_with_icon/text_button_with_icon.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/theme/light/text_theme_light.dart';
import '../provider/my_card_provider.dart';
import '../provider/storie_provider.dart';
import '../viewmodel/cards_page_viewmodel.dart';
import 'screens/add_card_create_screen.dart';
import 'screens/add_card_created_screen.dart';
import 'screens/cards_list_page_screen.dart';

class CardsPageView extends StatefulWidget {
  const CardsPageView({super.key});

  @override
  State<CardsPageView> createState() => _CardsPageViewState();
}

class _CardsPageViewState extends State<CardsPageView> {
  QRViewController? controller;
  @override
  Widget build(BuildContext context) {
    return BaseView<CardsPageViewmodel>(
      viewModel: CardsPageViewmodel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
        model.getMyCards();
        model.getStories();
        model.getCards();
      },
      onPageBuilder: (BuildContext context, CardsPageViewmodel viewmodel) {
        final StorieProvider storieProvider = context.watch<StorieProvider>();
        final MyCardProvider myCardProvider = context.watch<MyCardProvider>();
        return ScaffoldMessenger(
          key: viewmodel.scaffoldMessengerKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.cards_page_stories.locale,
              ),
              actions: [
                textbuttonWithPic(
                  context: context,
                  text: LocaleKeys.cards_page_add_card_add_card.locale,
                  pic: "assets/images/add_card.png",
                  isBigSize: false,
                  onPressed: () {
                    showModalBottomSheet(
                      backgroundColor: Colors.white,
                      useRootNavigator: true,
                      isScrollControlled: true,
                      context: context,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.vertical(
                          top: Radius.circular(20.0),
                        ),
                      ),
                      builder: (context) {
                        return FractionallySizedBox(
                          heightFactor: 0.92,
                          child: PageView(
                            controller: viewmodel.pageController,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (value) {
                              viewmodel.setCurrentScreen(value);
                            },
                            children: [
                              cardsListPage(context, viewmodel),
                              addCardCreateScreen(
                                context,
                                viewmodel,
                              ),
                              addCardCreatedScreen(context, viewmodel),
                            ],
                          ),
                        );
                      },
                    );
                  },
                ),
              ],
            ),
            body: RefreshIndicator(
              onRefresh: () {
                viewmodel.getMyCards();
                return viewmodel.getStories();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: ConstrainedBox(
                  constraints: BoxConstraints(
                      minHeight: MediaQuery.of(context).size.height),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      context.normalSizedBoxVertical,
                      Observer(
                        builder: (_) {
                          return viewmodel.isLoadingStories
                              ? const CircularProgressIndicator()
                              : storieProvider.getStorieList == null ||
                                      storieProvider.getStorieList!.isEmpty
                                  ? const SizedBox()
                                  : Column(
                                      children: [
                                        SizedBox(
                                          height: 70,
                                          child: ListView.separated(
                                            padding:
                                                context.paddingNormalHorizontal,
                                            scrollDirection: Axis.horizontal,
                                            itemCount: storieProvider
                                                    .getStorieList?.length ??
                                                0,
                                            itemBuilder: (context, index) {
                                              return InkWell(
                                                onTap: () {
                                                  Navigator.of(context,
                                                          rootNavigator: true)
                                                      .pushNamed(
                                                    NavigationConstants
                                                        .STORIE_PAGE_VIEW,
                                                    arguments: storieProvider
                                                        .getStorieList,
                                                  );
                                                },
                                                child: CircleAvatar(
                                                  backgroundImage: NetworkImage(
                                                    storieProvider
                                                        .getStorieList![index]
                                                        .coverPicture!,
                                                  ),
                                                  radius: 35,
                                                ),
                                              );
                                            },
                                            separatorBuilder: (context, index) {
                                              return context
                                                  .lowSizedBoxHorizontal;
                                            },
                                          ),
                                        ),
                                        context.highSizedBoxVertical,
                                      ],
                                    );
                        },
                      ),
                      Padding(
                        padding: context.paddingNormalHorizontal,
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: Text(LocaleKeys.cards_page_my_cards.locale,style: TextThemeLight.instance!.titleLarge,)

                        ),
                      ),
                      context.lowSizedBoxVertical,
                      Padding(
                        padding: context.paddingNormalHorizontal,
                        child: Observer(builder: (_) {
                          return viewmodel.isLoadingMyCards
                              ? const CircularProgressIndicator()
                              : myCardProvider.getMyCardList == null
                                  ? SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              1.7,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: Padding(
                                          padding: context.paddingLow,
                                          child: Text(
                                            LocaleKeys
                                                .cards_page_no_loyalty_card_yet
                                                .locale,
                                            textAlign: TextAlign.center,
                                            style: TextThemeLight
                                                .instance!.bodyLarge,
                                          ),
                                        ),
                                      ),
                                    )
                                  : myCardProvider.getMyCardList!.isNotEmpty
                                      ? GridView.builder(
                                          itemCount: myCardProvider
                                                  .getMyCardList?.length ??
                                              0,
                                          primary: false,
                                          shrinkWrap: true,
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 2,
                                                  mainAxisSpacing: 15,
                                                  crossAxisSpacing: 10,
                                                  childAspectRatio: 1.9),
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Navigator.of(context,
                                                        rootNavigator: true)
                                                    .pushNamed(
                                                  NavigationConstants
                                                      .MY_CARD_INFO_PAGE_VIEW,
                                                  arguments: myCardProvider
                                                      .getMyCardList![index],
                                                );
                                              },
                                              child: Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  boxShadow: [
                                                    BoxShadow(
                                                      color:
                                                          Colors.blue.shade50,
                                                      blurRadius: 5,
                                                      offset:
                                                          const Offset(1, 4),
                                                      spreadRadius: 1,
                                                    ),
                                                  ],
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(10),
                                                  child: Image.network(
                                                    myCardProvider
                                                        .getMyCardList![index]
                                                        .card!
                                                        .picture!,
                                                    fit: BoxFit.cover,
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        )
                                      : SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height /
                                              1.7,
                                          child: Align(
                                            alignment: Alignment.center,
                                            child: Padding(
                                              padding: context.paddingLow,
                                              child: Text(
                                                LocaleKeys
                                                    .cards_page_no_loyalty_card_yet
                                                    .locale,
                                                textAlign: TextAlign.center,
                                                style: TextThemeLight
                                                    .instance!.bodyLarge,
                                              ),
                                            ),
                                          ),
                                        );
                        }),
                      ),
                      context.normalSizedBoxVertical,
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
