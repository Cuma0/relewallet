import 'dart:io';

import 'package:azlistview/azlistview.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../../core/constants/enums/locale_keys_enum.dart';
import '../../../../core/extension/context_extension.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/cache/locale_manager.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/init/navigation/navigation_provider.dart';
import '../../../../core/theme/light/color_scheme_light.dart';
import '../../../../core/theme/light/text_theme_light.dart';
import '../../../_widgets/text_form_field/text_form_field_widget.dart';
import '../../model/card_model/card_model.dart';
import '../../provider/card_provider.dart';
import '../../viewmodel/cards_page_viewmodel.dart';

Widget cardsListPage(BuildContext context, CardsPageViewmodel viewmodel) {
  final CardProvider cardProvider = context.watch<CardProvider>();
  return Column(
    children: [
      context.lowSizedBoxVertical,
      Row(
        children: [
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 32,
            ),
          ),
          Expanded(
            child: Align(
              alignment: Alignment.center,
              child: Text(
                LocaleKeys.cards_page_add_card_add_card.locale,
                style: Theme.of(context).textTheme.displayMedium,
              ),
            ),
          ),
          const IconButton(
            onPressed: null,
            icon: Icon(
              Icons.keyboard_arrow_down_rounded,
              size: 32,
              color: Colors.transparent,
            ),
          ),
        ],
      ),
      context.normalSizedBoxVertical,
      Observer(
        builder: (_) {
          return viewmodel.isLoadingCards
              ? const CircularProgressIndicator()
              : Expanded(
                  child: AzListView(
                    data: viewmodel.cardItemAZList,
                    itemCount: viewmodel.cardItemAZList.length,
                    itemBuilder: (context, index) {
                      if (index == 0) {
                        return buildCustomHeaderWidget(
                            context, viewmodel, cardProvider);
                      } else {
                        final CardItemAZ item = viewmodel.cardItemAZList[index];
                        bool before = index == 0
                            ? false
                            : viewmodel.cardItemAZList[index - 1].tag ==
                                    item.tag
                                ? true
                                : false;

                        bool after =
                            index == viewmodel.cardItemAZList.length - 1
                                ? false
                                : viewmodel.cardItemAZList[index + 1].tag ==
                                        item.tag
                                    ? true
                                    : false;
                        return buildListItem(
                            context, item, viewmodel, before, after);
                      }
                    },
                    padding: EdgeInsets.only(
                      left: context.paddingNormalHorizontal.left,
                      right: context.paddingNormalHorizontal.right * 2,
                    ),
                    indexBarData: const ['☆', ...kIndexBarData],
                    indexBarOptions: const IndexBarOptions(
                      needRebuild: true,
                      indexHintAlignment: Alignment.centerRight,
                      indexHintOffset: Offset(-5, 0),
                      selectTextStyle: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                );
        },
      ),
      context.normalSizedBoxVertical,
      context.normalSizedBoxVertical,
    ],
  );
}

Column buildCustomHeaderWidget(BuildContext context,
    CardsPageViewmodel viewmodel, CardProvider cardProvider) {
  return Column(
    children: [
      textFormFieldWidget(
        controller: viewmodel.searchCardController,
        context: context,
        hintText: LocaleKeys.cards_page_add_card_search.locale,
        isSearch: true,
        onChanged: (value) {
          if (value.isNotEmpty) {
            List<CardModel>? searchCardList = cardProvider.getCardList
                .where((cardModel) =>
                    cardModel.name!.toLowerCase().contains(value.toLowerCase()))
                .toList();
            viewmodel.setSearchCardList(searchCardList);
          } else {
            viewmodel.setSearchCardList(null);
          }
        },
      ),
      context.highSizedBoxVertical,
      Align(
        alignment: Alignment.centerLeft,
        child: Text(
          LocaleKeys.cards_page_add_card_many_times.locale,
          style: TextThemeLight.instance!.bodyLarge,
        ),
      ),
      context.normalSizedBoxVertical,
      GridView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: viewmodel.randomCards.length,
        shrinkWrap: true,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
          mainAxisSpacing: 20,
          crossAxisSpacing: 20,
          childAspectRatio: 1.4,
        ),
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              boxShadow: [
                BoxShadow(
                  color: Colors.blue.shade50,
                  blurRadius: 5,
                  offset: const Offset(1, 4),
                  spreadRadius: 1,
                )
              ],
            ),
            child: GestureDetector(
              onTap: LocaleManager.instance
                      .getStringValue(PreferencesKeys.TOKEN)
                      .isEmpty
                  ? () {
                      alertDialog(context);
                    }
                  : () async {
                      viewmodel.setSelectedCard(viewmodel.randomCards[index]);
                      await viewmodel.pageController.animateToPage(1,
                          duration: const Duration(milliseconds: 250),
                          curve: Curves.ease);
                    },
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.network(
                  viewmodel.randomCards[index].picture!,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        },
      ),

      // settingsWidget(
      //   context: context,
      //   settingsModel: SettingsModel(
      //     title: null,
      //     settingsItems: [
      //       SettingsItems(
      //         settingTitle: LocaleKeys.cards_page_add_card_other_cards.locale,
      //         pic: "assets/images/add_card.png",
      //         onPressed: LocaleManager.instance
      //                 .getStringValue(PreferencesKeys.TOKEN)
      //                 .isEmpty
      //             ? () {
      //                 alertDialog(context);
      //               }
      //             : () {},
      //       ),
      //     ],
      //   ),
      // ),
    ],
  );
}

Widget buildListItem(BuildContext context, CardItemAZ item,
    CardsPageViewmodel viewmodel, bool before, bool after) {
  final tag = item.getSuspensionTag();
  final offstage = !item.isShowSuspension;
  return Column(
    children: [
      Padding(
        padding: context.paddingNormalHorizontal,
        child: Offstage(
          offstage: offstage,
          child: buildHeader(context, tag),
        ),
      ),
      Container(
        height: context.mediumValue * 1.7,
        padding: context.paddingNormalHorizontal,
        decoration: BoxDecoration(
          color: ColorSchemeLight.instance!.white,
          borderRadius: BorderRadius.vertical(
            top: Radius.circular(before == false ? 10 : 0.1),
            bottom: Radius.circular(after == false ? 10 : 0.1),
          ),
          border: Border(
            right: BorderSide(
              width: 0.6,
              color: ColorSchemeLight.instance!.darkGrey,
            ),
            left: BorderSide(
              width: 0.6,
              color: ColorSchemeLight.instance!.darkGrey,
            ),
            top: BorderSide(
              width: before == false ? 0.6 : 0.1,
              color: ColorSchemeLight.instance!.darkGrey,
            ),
            bottom: BorderSide(
              width: after == false ? 0.6 : 0.1,
              color: ColorSchemeLight.instance!.darkGrey,
            ),
          ),
        ),
        child: InkWell(
          onTap: LocaleManager.instance
                  .getStringValue(PreferencesKeys.TOKEN)
                  .isEmpty
              ? () {
                  alertDialog(context);
                }
              : () async {
                  viewmodel.setSelectedCard(item.cardModel);
                  await viewmodel.pageController.animateToPage(1,
                      duration: const Duration(milliseconds: 250),
                      curve: Curves.ease);
                },
          child: SizedBox(
            height: context.mediumValue * 1.7,
            child: Row(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.paddingLow.vertical * 0.5,
                  ),
                  child: SizedBox(
                    width: context.mediumValue * 1.5,
                    height: 70,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(6),
                      child: Image.network(
                        item.cardModel.picture!,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                context.normalSizedBoxHorizontal,
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                      vertical: context.paddingLow.vertical * 0.9,
                    ),
                    child: Text(
                      item.cardModel.name!,
                      style: TextThemeLight.instance!.buttonSmall
                          .copyWith(fontWeight: FontWeight.w500),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: context.paddingLow.vertical * 0.9,
                  ),
                  child: const Icon(
                    Icons.arrow_forward_ios_rounded,
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      after == true
          ? Padding(
              padding: context.paddingNormalHorizontal,
              child: const Divider(
                thickness: 0,
                height: 0,
              ),
            )
          : const SizedBox(),
    ],
  );
}

Widget buildHeader(BuildContext context, String tag) {
  return Container(
    height: context.mediumValue * 1.4,
    alignment: Alignment.centerLeft,
    child: Column(
      children: [
        const Expanded(child: SizedBox()),
        Text(
          tag,
          softWrap: true,
        ),
        context.lowSizedBoxVertical,
        context.lowSizedBoxVertical,
      ],
    ),
  );
}

alertDialog(
  BuildContext context,
) {
  return showDialog(
      context: context,
      builder: (_) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(LocaleKeys.cards_page_add_card_add_card.locale),
                content: Text(
                    LocaleKeys.cards_page_add_card_please_login_before.locale),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      LocaleKeys.cards_page_add_card_okay.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      Navigator.of(context, rootNavigator: true).pop();
                      final NavigationProvider navigationProvider =
                          context.read<NavigationProvider>();
                      navigationProvider.setTab(2);
                    },
                  ),
                ],
              )
            : AlertDialog(
                title: Text(LocaleKeys.cards_page_add_card_add_card.locale),
                content: Text(
                    LocaleKeys.cards_page_add_card_please_login_before.locale),
                actions: <Widget>[
                  TextButton(
                    child: Text(
                      LocaleKeys.cards_page_add_card_okay.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                ],
              );
      });
}
