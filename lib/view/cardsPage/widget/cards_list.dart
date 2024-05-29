import 'package:flutter/material.dart';

import '../../../core/extension/context_extension.dart';
import '../../../core/theme/light/color_scheme_light.dart';
import '../../../core/theme/light/text_theme_light.dart';
import '../viewmodel/cards_page_viewmodel.dart';

Widget cardsListWidget({
  required CardsPageViewmodel viewmodel,
  required BuildContext context,
  required CardsList cardsList,
}) {
  return Padding(
    padding: context.paddingNormalHorizontal,
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: context.paddingNormalHorizontal,
          child: Text(
            cardsList.title,
            style: TextThemeLight.instance!.titleSmall,
          ),
        ),
        context.normalSizedBoxVertical,
        Container(
          height: cardsList.cardsItems.length * context.mediumValue * 1.7,
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
            itemCount: cardsList.cardsItems.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return itemWidget(context, cardsList.cardsItems[index],
                  cardsList.cardsItems.length > 1 ? true : false, viewmodel);
            },
            separatorBuilder: (context, index) {
              return const Divider(
                height: 0,
              );
            },
          ),
        ),
      ],
    ),
  );
}

Widget itemWidget(BuildContext context, CardsModel cardsModel, bool isList,
    CardsPageViewmodel viewmodel) {
  return InkWell(
    onTap: () async {
      await viewmodel.pageController
          .animateToPage(1,
              duration: const Duration(milliseconds: 500), curve: Curves.ease)
          .then((value) async {});
    },
    child: SizedBox(
      height: context.mediumValue * 1.7,
      child: Row(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(
              vertical: context.paddingLow.vertical * 0.5,
            ),
            child: Image.asset(
              cardsModel.image,
              fit: BoxFit.cover,
            ),
          ),
          context.normalSizedBoxHorizontal,
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(
                vertical: context.paddingLow.vertical * 0.9,
              ),
              child: Text(
                cardsModel.name,
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
  );
}

class CardsList {
  String title;
  List<CardsModel> cardsItems;
  CardsList({
    required this.title,
    required this.cardsItems,
  });
}

class CardsModel {
  String name;
  String image;
  CardsModel({
    required this.name,
    required this.image,
  });
}
