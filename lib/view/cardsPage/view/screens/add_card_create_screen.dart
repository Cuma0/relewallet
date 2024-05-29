import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';

import '../../../../core/extension/context_extension.dart';
import '../../../../core/extension/string_extension.dart';
import '../../../../core/init/lang/locale_keys.g.dart';
import '../../../../core/theme/light/color_scheme_light.dart';
import '../../../../core/theme/light/text_theme_light.dart';
import '../../../_widgets/text_form_field/text_form_field_widget.dart';
import '../../viewmodel/cards_page_viewmodel.dart';
import '../barcode_scanner_view.dart';

Widget addCardCreateScreen(BuildContext context, CardsPageViewmodel viewmodel) {
  return SingleChildScrollView(
    child: Column(
      children: [
        context.lowSizedBoxVertical,
        Row(
          children: [
            IconButton(
              onPressed: () async {
                FocusManager.instance.primaryFocus?.unfocus();

                await viewmodel.pageController.animateToPage(0,
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.ease);
              },
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 20,
              ),
            ),
            Expanded(
              child: Align(
                alignment: Alignment.center,
                child: Observer(builder: (_) {
                  return Text(
                    viewmodel.selectedCard!.name!,
                    style: Theme.of(context).textTheme.displayMedium,
                  );
                }),
              ),
            ),
            Padding(
              padding: context.paddingLowHorizontal,
              child: TextButton(
                onPressed: () {
                  if (viewmodel.formKey.currentState!.validate()) {
                    FocusManager.instance.primaryFocus?.unfocus();
                    viewmodel.createMyCard(
                        barcode: viewmodel.barcodeController.text.trim(),
                        cardId: viewmodel.selectedCard!.id!);
                    viewmodel.setisCardNumberError(false);
                  } else {
                    viewmodel.setisCardNumberError(true);
                  }
                },
                child: Text(
                  LocaleKeys.cards_page_add_card_save.locale,
                  style: TextThemeLight.instance!.button.copyWith(
                    color: ColorSchemeLight.instance!.blue,
                  ),
                ),
              ),
            ),
          ],
        ),
        context.normalSizedBoxVertical,
        Align(
            alignment: Alignment.centerLeft,
            child: Padding(
              padding: context.paddingNormalHorizontal,
              child: Text(
                  LocaleKeys.cards_page_add_card_enter_number_printed.locale),
            )),
        context.highSizedBoxVertical,
        context.highSizedBoxVertical,
        Padding(
          padding: context.paddingNormalHorizontal,
          child: Observer(builder: (_) {
            return Form(
              key: viewmodel.formKey,
              child: textFormFieldWidget(
                isWithErrorBorder: viewmodel.isCardNumberError,
                controller: viewmodel.barcodeController,
                context: context,
                hintText: LocaleKeys.cards_page_add_card_card_number.locale,
                isSearch: false,
                validator: (value) {
                  return value!.isEmpty
                      ? LocaleKeys
                          .cards_page_add_card_enter_number_printed.locale
                      : null;
                },
              ),
            );
          }),
        ),
        context.normalSizedBoxVertical,
        Padding(
          padding: context.paddingNormalHorizontal,
          child: Observer(builder: (_) {
            return ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: ColorSchemeLight.instance!.blue,
                side: BorderSide.none,
                fixedSize: Size(
                  double.maxFinite,
                  context.mediumValue * 1.42,
                ),
              ),
              onPressed: () {
                if (viewmodel.formKey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  viewmodel.createMyCard(
                      barcode: viewmodel.barcodeController.text.trim(),
                      cardId: viewmodel.selectedCard!.id!);
                  viewmodel.setisCardNumberError(false);
                } else {
                  viewmodel.setisCardNumberError(true);
                }
              },
              child: viewmodel.isLoadingCreateMyCards
                  ? SizedBox(
                      height: context.mediumValue / 2,
                      width: context.mediumValue / 2,
                      child: const CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                        strokeAlign: 1,
                      ),
                    )
                  : Text(
                      LocaleKeys.cards_page_add_card_save.locale,
                      style: TextThemeLight.instance!.button.copyWith(
                        color: Colors.white,
                      ),
                    ),
            );
          }),
        ),
        TextButton(
          onPressed: () async {
            String? result = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const BarcodeScannerView()));
            if (result != null) {
              viewmodel.barcodeController.text = result;
            }
          },
          child: Text(
            LocaleKeys.cards_page_add_card_scan_page_scan_bardcode.locale,
            style: TextThemeLight.instance!.buttonSmall.copyWith(
              color: ColorSchemeLight.instance!.blue,
            ),
          ),
        ),
      ],
    ),
  );
}
