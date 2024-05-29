import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:qr_bar_code/code/src/code_generate.dart';
import 'package:qr_bar_code/code/src/code_type.dart';

import '../../../../core/extension/context_extension.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/theme/light/color_scheme_light.dart';
import '../../../../core/theme/light/text_theme_light.dart';
import '../../viewmodel/cards_page_viewmodel.dart';

Widget addCardCreatedScreen(
    BuildContext context, CardsPageViewmodel viewmodel) {
  return SingleChildScrollView(
    child: Column(
      children: [
        context.lowSizedBoxVertical,
        Row(
          children: [
            IconButton(
              onPressed: () async {
                viewmodel.pageController.jumpTo(0);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
            ),
            Expanded(
              child: Align(
                  alignment: Alignment.center,
                  child: Text(
                    LocaleKeys.cards_page_add_card_created_page_new_loyalty_card
                        .locale,
                    style: Theme.of(context).textTheme.displayMedium,
                  )),
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
        context.normalSizedBoxVertical,
        Padding(
          padding: EdgeInsets.symmetric(horizontal: context.paddingMedium.left),
          child: Column(
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                padding: context.paddingNormal * 1.5,
                decoration: BoxDecoration(
                  color: ColorSchemeLight.instance!.blue,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Column(
                  children: [
                    Observer(builder: (_) {
                      return Text(
                        viewmodel.selectedCard?.name ?? "null",
                        style: TextThemeLight.instance!.button.copyWith(
                          color: Colors.white,
                        ),
                      );
                    }),
                    context.normalSizedBoxVertical,
                  
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: context.highValue,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Expanded(
                            child: Center(
                              child: Padding(
                                padding: context.paddingNormal,
                                child: Code(
                                    drawText: false,
                                    data: viewmodel.addedCardModel?.barcode ??
                                        "null",
                                    codeType: CodeType.gs128()),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.bottomCenter,
                            child: Padding(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                viewmodel.addedCardModel?.barcode ?? "null",
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
               
                  ],
                ),
              ),
              context.normalSizedBoxVertical,
              Align(
                alignment: Alignment.centerLeft,
                child: Text(LocaleKeys
                    .cards_page_add_card_created_page_created_loyalty_card
                    .locale),
              ),
              context.highSizedBoxVertical,
              context.highSizedBoxVertical,
              context.highSizedBoxVertical,
              context.highSizedBoxVertical,
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(MediaQuery.of(context).size.width,
                      context.mediumValue * 1.5),
                  backgroundColor: ColorSchemeLight.instance!.blue,
                  side: const BorderSide(width: 0),
                ),
                onPressed: () {
                  viewmodel.pageController.jumpTo(0);
                },
                child: Text(
                  LocaleKeys
                      .cards_page_add_card_created_page_add_new_card.locale,
                  style: TextThemeLight.instance!.buttonSmall
                      .copyWith(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  LocaleKeys
                      .cards_page_add_card_created_page_go_back_cards.locale,
                  style: context.textTheme.labelLarge!.copyWith(
                    color: ColorSchemeLight.instance!.blue,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
