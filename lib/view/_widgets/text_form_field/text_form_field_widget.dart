import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/theme/light/color_scheme_light.dart';
import '../../../core/theme/light/text_theme_light.dart';

Widget textFormFieldWidget({
  required BuildContext context,
  required String hintText,
  required bool isSearch,
  required TextEditingController controller,
  String? Function(String?)? validator,
  bool? isWithErrorBorder,
  void Function(String)? onChanged
  
}) {
  return SizedBox(
    height: isWithErrorBorder == true
        ? context.mediumValue * 2.2
        : context.mediumValue * 1.6,
    child: TextFormField(
      onChanged: onChanged,
      controller: controller,
      keyboardType: isSearch ? null : TextInputType.number,
      textCapitalization: TextCapitalization.words,
      textInputAction: isSearch ? TextInputAction.search : TextInputAction.done,
      style: TextThemeLight.instance!.bodyLarge,
      validator: validator,
      decoration: InputDecoration(
        prefixIcon: isSearch
            ? IconButton(
                icon: Icon(
                  Icons.search,
                  color: ColorSchemeLight.instance!.darkGrey,
                ),
                onPressed: () {},
              )
            : null,
        hintText: hintText,
        hintStyle: TextThemeLight.instance!.bodyLarge.copyWith(
          color: ColorSchemeLight.instance!.darkGrey,
        ),
        contentPadding: EdgeInsets.only(
          left: context.paddingNormal.left,
        ),
        filled: true,
        fillColor: Theme.of(context).colorScheme.onBackground,
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(
            10,
          ),
          borderSide: const BorderSide(
            width: 0,
            style: BorderStyle.none,
          ),
        ),
      ),
    ),
  );
}
