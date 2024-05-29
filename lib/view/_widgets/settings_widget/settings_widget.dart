import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/theme/light/color_scheme_light.dart';
import '../../../core/theme/light/text_theme_light.dart';

Widget settingsWidget({
  required BuildContext context,
  required SettingsModel settingsModel,
}) {
  return Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      settingsModel.title == null
          ? const SizedBox()
          : Padding(
              padding: context.paddingNormalHorizontal,
              child: Text(
                settingsModel.title!,
                style: TextThemeLight.instance!.titleSmall,
              ),
            ),
      context.normalSizedBoxVertical,
      Container(
        height: settingsModel.settingsItems.length * context.mediumValue * 1.5,
        padding: context.paddingNormalHorizontal,
        decoration: BoxDecoration(
          color: ColorSchemeLight.instance!.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            width: 0.6,
            color: ColorSchemeLight.instance!.darkGrey,
          ),
        ),
        child: ListView.separated(
          itemCount: settingsModel.settingsItems.length,
          physics: const NeverScrollableScrollPhysics(),
          itemBuilder: (context, index) {
            return itemWidget(context, settingsModel.settingsItems[index],
                settingsModel.settingsItems.length > 1 ? true : false);
          },
          separatorBuilder: (context, index) {
            return const Divider(
              height: 0,
            );
          },
        ),
      ),
    ],
  );
}

Widget itemWidget(
    BuildContext context, SettingsItems settingsItems, bool isList) {
  return InkWell(
    onTap: settingsItems.onPressed,
    child: SizedBox(
      height: context.mediumValue * 1.5,
      child: Row(
        children: [
          Image.asset(
            settingsItems.pic,
            fit: BoxFit.fitHeight,
            width: 26,
          ),
          context.normalSizedBoxHorizontal,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.paddingLow.vertical * 0.7,
              ),
              child: Text(
                settingsItems.settingTitle,
                style: TextThemeLight.instance!.buttonSmall
                    .copyWith(fontWeight: FontWeight.w500),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.paddingLow.vertical * 0.7,
            ),
            child: const Icon(
              Icons.arrow_forward_ios_rounded,
            ),
          )
        ],
      ),
    ),
  );
}

class SettingsModel {
  String? title;
  List<SettingsItems> settingsItems;
  SettingsModel({
    required this.title,
    required this.settingsItems,
  });
}

class SettingsItems {
  String settingTitle;
  String pic;
  void Function()? onPressed;
  SettingsItems(
      {required this.settingTitle, required this.pic, required this.onPressed});
}
