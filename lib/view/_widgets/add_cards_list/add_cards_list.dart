// import 'package:flutter/material.dart';

// import '../../../core/extension/context_extension.dart';
// import '../../../core/theme/light/color_scheme_light.dart';
// import '../../../core/theme/light/text_theme_light.dart';

// Widget addCardsList({
//   required BuildContext context,
//   required List<CardModel> cardsList,
// }) {
//   return Column(
//     crossAxisAlignment: CrossAxisAlignment.start,
//     children: [
//       Padding(
//         padding: context.paddingNormalHorizontal,
//         child: Text(
//           settingsModel.title,
//           style: TextThemeLight.instance!.titleSmall,
//         ),
//       ),
//       context.normalSizedBoxVertical,
//       Container(
//         height: settingsModel.settingsItems.length * context.mediumValue * 1.8,
//         decoration: BoxDecoration(
//           color: ColorSchemeLight.instance!.white,
//           borderRadius: BorderRadius.circular(10),
//           border: Border.all(
//             width: 0.6,
//             color: ColorSchemeLight.instance!.darkGrey,
//           ),
//         ),
//         child: ListView.separated(
//           itemCount: settingsModel.settingsItems.length,
//           physics: const NeverScrollableScrollPhysics(),
//           itemBuilder: (context, index) {
//             return itemWidget(context, settingsModel.settingsItems[index],
//                 settingsModel.settingsItems.length > 1 ? true : false);
//           },
//           separatorBuilder: (context, index) {
//             return Padding(
//               padding: EdgeInsets.symmetric(
//                   horizontal: context.paddingLow.horizontal * 1.2),
//               child: const Divider(
//                 height: 0,
//               ),
//             );
//           },
//         ),
//       ),
//     ],
//   );
// }

// Widget itemWidget(
//     BuildContext context, SettingsItems settingsItems, bool isList) {
//   return InkWell(
//     onTap: settingsItems.onPressed,
//     child: Padding(
//       padding: isList ? context.paddingLow * 1.7 : context.paddingLow * 1.5,
//       child: Row(
//         children: [
//           Icon(
//             settingsItems.icon,
//             size: 24,
//           ),
//           context.normalSizedBoxHorizontal,
//           Expanded(
//             child: Text(
//               settingsItems.settingTitle,
//               style: TextThemeLight.instance!.buttonSmall,
//             ),
//           ),
//           const Icon(
//             Icons.keyboard_arrow_right_rounded,
//             size: 24,
//           )
//         ],
//       ),
//     ),
//   );
// }

// class CardModel {
//   String id;
//   String image;
//   String name;
//   CardModel({
//     required this.id,
//     required this.image,
//     required this.name,
//   });
// }
