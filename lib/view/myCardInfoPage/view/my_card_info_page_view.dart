import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:qr_bar_code/code/code.dart';
import 'package:share_plus/share_plus.dart';

import '../../../core/base/view/base_widget.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/theme/light/color_scheme_light.dart';
import '../../../core/theme/light/text_theme_light.dart';
import '../../cardsPage/model/my_card_model/my_card_model.dart';
import '../model/update_my_card_model.dart';
import '../viewmodel/my_card_info_page_viewmodel.dart';

class MyCardInfoPageView extends StatefulWidget {
  final MyCardModel myCardModel;
  const MyCardInfoPageView({super.key, required this.myCardModel});

  @override
  State<MyCardInfoPageView> createState() => _MyCardInfoPageViewState();
}

class _MyCardInfoPageViewState extends State<MyCardInfoPageView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<MyCardInfoPageViewmodel>(
      viewModel: MyCardInfoPageViewmodel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init(widget.myCardModel.barcode);
      },
      onPageBuilder: (BuildContext context, MyCardInfoPageViewmodel viewmodel) {
        return ScaffoldMessenger(
          key: viewmodel.scaffoldMessengerKey,
          child: Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.cards_page_my_card_info_loyalty_card.locale,
              ),
              centerTitle: true,
              leading: IconButton(
                icon: const Icon(
                  Icons.close,
                  size: 24.0,
                  color: Colors.black,
                ),
                onPressed: () => Navigator.of(context).pop(),
              ),
              actions: [
                TextButton(
                  onPressed: () {
                    alertDialog(widget.myCardModel, viewmodel, context);
                  },
                  child: Text(
                    LocaleKeys.cards_page_my_card_info_delete.locale,
                    style: TextThemeLight.instance!.bodyLarge
                        .copyWith(color: CupertinoColors.systemRed),
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.symmetric(
                    horizontal: context.paddingMedium.left),
                child: Column(
                  children: [
                    context.normalSizedBoxVertical,
                    context.normalSizedBoxVertical,
                    context.normalSizedBoxVertical,
                    Container(
                      width: MediaQuery.of(context).size.width,
                      padding: context.paddingNormal * 1.5,
                      decoration: BoxDecoration(
                        color: ColorSchemeLight.instance!.blue,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Text(
                            widget.myCardModel.card!.name!,
                            style: TextThemeLight.instance!.button.copyWith(
                              color: Colors.white,
                            ),
                          ),
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
                                      child: Observer(builder: (_) {
                                        return Code(
                                            drawText: false,
                                            data: viewmodel.newBarcodeNo ??
                                                widget.myCardModel.barcode!,
                                            codeType: CodeType.gs128());
                                      }),
                                    ),
                                  ),
                                ),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Padding(
                                    padding: const EdgeInsets.only(bottom: 8),
                                    child: Observer(builder: (_) {
                                      return viewmodel.isLoadingDelete
                                          ? const CircularProgressIndicator()
                                          : Text(
                                              viewmodel.newBarcodeNo ??
                                                  widget.myCardModel.barcode!,
                                            );
                                    }),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    context.lowSizedBoxVertical,
                    context.lowSizedBoxVertical,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          "${LocaleKeys.cards_page_my_card_info_creation_date.locale}${DateTime.parse(widget.myCardModel.updatedAt!).toLocal().day}/${DateTime.parse(widget.myCardModel.updatedAt!).toLocal().month}/${DateTime.parse(widget.myCardModel.updatedAt!).toLocal().year}, ${DateTime.parse(widget.myCardModel.updatedAt!).toLocal().hour}:${DateTime.parse(widget.myCardModel.updatedAt!).toLocal().minute}",
                        ),
                        IconButton(
                          onPressed: () {
                            shareApp(widget.myCardModel);
                          },
                          icon: Icon(
                            Icons.share,
                            color: ColorSchemeLight.instance!.blue,
                          ),
                        ),
                      ],
                    ),
                    context.lowSizedBoxVertical,
                    context.lowSizedBoxVertical,
                    Form(
                      key: viewmodel.formKey,
                      child: SizedBox(
                        height: context.mediumValue * 2.2,
                        child: TextFormField(
                          controller: viewmodel.barcodeController,
                          decoration: InputDecoration(
                            labelText: "Barcode",
                            fillColor: Colors.white,
                            enabledBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(),
                            ),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(20.0),
                              borderSide: const BorderSide(),
                            ),
                            //fillColor: Colors.green
                          ),
                          validator: (value) {
                            return value!.isEmpty
                                ? LocaleKeys
                                    .cards_page_add_card_enter_number_printed
                                    .locale
                                : null;
                          },
                        ),
                      ),
                    ),
                    context.normalSizedBoxVertical,
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: ColorSchemeLight.instance!.blue,
                        side: BorderSide.none,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        fixedSize: Size(
                          double.maxFinite,
                          context.mediumValue * 1.42,
                        ),
                      ),
                      onPressed: () {
                        FocusManager.instance.primaryFocus?.unfocus();
                        if (viewmodel.formKey.currentState!.validate()) {
                          //EVET validate o yüzden istek atabiliriz
                          viewmodel.updateMyCard(
                            UpdateMyCardModel(
                              myCardId: widget.myCardModel.id,
                              barcode: viewmodel.barcodeController.text.trim(),
                            ),
                          );
                        }
                      },
                      child: Observer(
                        builder: (_) {
                          return viewmodel.isLoadingUpdate
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
                                  LocaleKeys
                                      .cards_page_my_card_info_update.locale,
                                  style:
                                      TextThemeLight.instance!.button.copyWith(
                                    color: Colors.white,
                                  ),
                                );
                        },
                      ),
                    ),
                    context.normalSizedBoxVertical,
                    Observer(builder: (_) {
                      return viewmodel.newBarcodeNo != null
                          ? Text(LocaleKeys
                              .cards_page_my_card_info_card_updated_successfully
                              .locale)
                          : const SizedBox();
                    })
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

alertDialog(
  MyCardModel myCardModel,
  MyCardInfoPageViewmodel viewmodel,
  BuildContext context,
) {
  return showDialog(
      context: context,
      builder: (_) {
        return Platform.isIOS
            ? CupertinoAlertDialog(
                title: Text(
                  LocaleKeys.cards_page_my_card_info_delete.locale,
                ),
                content: Text(
                  LocaleKeys.cards_page_my_card_info_are_you_sure_delete.locale,
                ),
                actions: <Widget>[
                  CupertinoDialogAction(
                    child: Text(
                      LocaleKeys.cards_page_my_card_info_no.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  CupertinoDialogAction(
                    child: Text(
                      LocaleKeys.cards_page_my_card_info_yes.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.systemRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      viewmodel.deleteMyCard(
                        UpdateMyCardModel(
                          myCardId: myCardModel.id,
                          barcode: myCardModel.barcode,
                        ),
                      );
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
                      LocaleKeys.cards_page_my_card_info_no.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.activeBlue,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                    },
                  ),
                  TextButton(
                    child: Text(
                      LocaleKeys.cards_page_my_card_info_yes.locale,
                      style: context.textTheme.labelLarge!.copyWith(
                        color: CupertinoColors.systemRed,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    onPressed: () async {
                      Navigator.of(context, rootNavigator: true).pop();
                      viewmodel.deleteMyCard(
                        UpdateMyCardModel(
                          myCardId: myCardModel.id,
                          barcode: myCardModel.barcode,
                        ),
                      );
                    },
                  ),
                ],
              );
      });
}

void shareApp(MyCardModel myCardModel) {
  Share.share(
    "${LocaleKeys.cards_page_my_card_info_share_value.locale} ${myCardModel.card!.name} : ${myCardModel.barcode!}",
  );
}
