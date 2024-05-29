import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';

import '../../../core/base/view/base_widget.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/theme/light/color_scheme_light.dart';
import '../../../core/theme/light/text_theme_light.dart';
import '../provider/offer_provider.dart';
import '../viewmodel/offers_page_viewmodel.dart';

class OffersPageView extends StatefulWidget {
  const OffersPageView({super.key});

  @override
  State<OffersPageView> createState() => _OffersPageViewState();
}

class _OffersPageViewState extends State<OffersPageView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<OffersPageViewmodel>(
        viewModel: OffersPageViewmodel(),
        onModelReady: (model) {
          model.setContext(context);
          model.init();
          model.getOfferList();
        },
        onPageBuilder: (BuildContext context, OffersPageViewmodel viewmodel) {
          final OfferProvider offerProvider = context.watch<OfferProvider>();
          return Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys.offers_page_offers.locale,
              ),
            ),
            body: RefreshIndicator(
              onRefresh: () {
                return viewmodel.getOfferList();
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: Observer(builder: (_) {
                  return viewmodel.isLoadingOffers
                      ? const SizedBox()
                      : Padding(
                          padding: context.paddingNormalHorizontal,
                          child: offerProvider.getOfferList.isEmpty
                              ? withoutOfferScreen(
                                  context: context, viewmodel: viewmodel)
                              : withOffersScreen(
                                  context: context,
                                  offerProvider: offerProvider),
                        );
                }),
              ),
            ),
          );
        });
  }

  Widget withoutOfferScreen(
      {required BuildContext context, required OffersPageViewmodel viewmodel}) {
    return Column(
      children: [
        GridView.builder(
          itemCount: 6,
          primary: false,
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 20,
              crossAxisSpacing: 20,
              childAspectRatio: 1.0),
          itemBuilder: (context, index) {
            return Container(
              padding: const EdgeInsets.all(30),
              decoration: BoxDecoration(
                color: const Color.fromARGB(60, 66, 133, 244),
                borderRadius: BorderRadius.circular(10),
                boxShadow: [
                  BoxShadow(
                    color: ColorSchemeLight.instance!.grey,
                    blurRadius: 5,
                    offset: const Offset(2, 5),
                  )
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  "assets/images/offer$index.png",
                  fit: BoxFit.cover,
                ),
              ),
            );
          },
        ),
        context.highSizedBoxVertical,
        Text(
          LocaleKeys.offers_page_no_offer_yet.locale,
          textAlign: TextAlign.center,
          style: TextThemeLight.instance!.bodyLarge.copyWith(
            fontWeight: FontWeight.w400,
          ),
        ),
        context.highSizedBoxVertical,
      ],
    );
  }

  Widget withOffersScreen(
      {required BuildContext context, required OfferProvider offerProvider}) {
    return ConstrainedBox(
      constraints:
          BoxConstraints(minHeight: MediaQuery.of(context).size.height),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            LocaleKeys.offers_page_for_you.locale,
            style: TextThemeLight.instance!.titleSmall,
          ),
          context.highSizedBoxVertical,
          GridView.builder(
            itemCount: offerProvider.getOfferList.length,
            primary: false,
            shrinkWrap: true,
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 20,
                crossAxisSpacing: 20,
                childAspectRatio: 0.9),
            itemBuilder: (context, index) {
              return Container(
                decoration: BoxDecoration(
                  color: Theme.of(context).cardTheme.color,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: ColorSchemeLight.instance!.grey,
                      blurRadius: 5,
                      offset: const Offset(2, 5),
                    )
                  ],
                ),
                child: Column(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: const BorderRadius.vertical(
                            top: Radius.circular(10)),
                        child: SizedBox(
                          width: double.infinity,
                          child: Image.network(
                            offerProvider.getOfferList[index].picture!,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(
                        vertical: context.paddingLowVertical.vertical / 2,
                        horizontal: context.paddingLowVertical.vertical / 2,
                      ),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              LocaleKeys.offers_page_validity_period.locale,
                              style: TextThemeLight.instance!.bodySmall,
                              textAlign: TextAlign.left,
                            ),
                            Text(
                              offerProvider.getOfferList[index].validityPeriod!,
                              style: TextThemeLight.instance!.bodySmall
                                  .copyWith(fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
          context.highSizedBoxVertical,
        ],
      ),
    );
  }
}
