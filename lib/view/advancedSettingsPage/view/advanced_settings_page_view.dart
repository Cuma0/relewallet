import 'package:flutter/material.dart';
import 'package:flutter_mobx/flutter_mobx.dart';
import 'package:provider/provider.dart';
import '../../../core/extension/context_extension.dart';
import '../../../core/extension/string_extension.dart';
import '../../cardsPage/provider/my_card_provider.dart';

import '../../../core/base/view/base_widget.dart';
import '../../../core/constants/navigation/navigation_constants.dart';
import '../../../core/init/lang/locale_keys.g.dart';
import '../../../core/theme/light/text_theme_light.dart';
import '../../cardsPage/model/my_card_model/my_card_model.dart';
import '../viewmodel/advanced_settings_page_viewmodel.dart';

class AdvancedSettingsPageView extends StatefulWidget {
  final List<MyCardModel>? myCardList;
  const AdvancedSettingsPageView({super.key, required this.myCardList});

  @override
  State<AdvancedSettingsPageView> createState() =>
      _AdvancedSettingsPageViewState();
}

class _AdvancedSettingsPageViewState extends State<AdvancedSettingsPageView> {
  @override
  Widget build(BuildContext context) {
    return BaseView<AdvancedSettingsPageViewmodel>(
      viewModel: AdvancedSettingsPageViewmodel(),
      onModelReady: (model) {
        model.setContext(context);
        model.init();
      },
      onPageBuilder:
          (BuildContext context, AdvancedSettingsPageViewmodel viewmodel) {
        final MyCardProvider myCardProvider = context.watch<MyCardProvider>();
        return Scaffold(
            appBar: AppBar(
              title: Text(
                LocaleKeys
                    .account_page_my_account_settings_advanced_settings.locale,
              ),
              actions: [
                PopupMenuButton(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10)),
                  elevation: 10,
                  itemBuilder: (context) => [
                    _buildPopupMenuItem(() {
                      viewmodel.changeisChecked(
                          newisCheckedDate: true,
                          newisCheckedName: false,
                          list: myCardProvider.getMyCardList);
                    }, LocaleKeys.settings_page_sort_by_date.locale,
                        viewmodel.isCheckedDate),
                    _buildPopupMenuItem(() {
                      viewmodel.changeisChecked(
                          newisCheckedDate: false,
                          newisCheckedName: true,
                          list: myCardProvider.getMyCardList);
                    }, LocaleKeys.settings_page_sort_by_name.locale,
                        viewmodel.isCheckedName),
                  ],
                  initialValue: 1,
                  icon: const Icon(
                    Icons.sort,
                    size: 24,
                  ),
                )
              ],
            ),
            body: myCardProvider.getMyCardList == null ||
                    myCardProvider.getMyCardList!.isEmpty
                ? Align(
                    alignment: Alignment.center,
                    child: Padding(
                      padding: context.paddingLow,
                      child: Text(
                        LocaleKeys.cards_page_no_loyalty_card_yet.locale,
                        textAlign: TextAlign.center,
                        style: TextThemeLight.instance!.bodyLarge,
                      ),
                    ),
                  )
                : Observer(
                    builder: (_) {
                      List<MyCardModel>? myCardList = [];

                      if (viewmodel.isCheckedDate) {
                        myCardList = List.from(myCardProvider.getMyCardList!);
                      } else if (viewmodel.isCheckedName) {
                        myCardList = List.from(myCardProvider.getMyCardList!);
                        myCardList.sort((a, b) => a.card!.name
                            .toString()
                            .compareTo(b.card!.name.toString()));
                      }
                      return Padding(
                        padding: context.paddingNormalHorizontal,
                        child: GridView.builder(
                          itemCount: myCardProvider.getMyCardList!.length,
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
                                Navigator.of(context, rootNavigator: true)
                                    .pushNamed(
                                        NavigationConstants
                                            .ADVANCED_SETTINGS_INFO_PAGE_VIEW,
                                        arguments: myCardList![index]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.blue.shade50,
                                      blurRadius: 5,
                                      offset: const Offset(1, 4),
                                      spreadRadius: 1,
                                    ),
                                  ],
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(10),
                                  child: Image.network(
                                    myCardList![index].card!.picture!,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      );
                    },
                  ));
      },
    );
  }

  PopupMenuItem _buildPopupMenuItem(
      void Function()? onTap, String menuTitle, bool isSelected) {
    return PopupMenuItem(
        onTap: onTap,
        child: Row(
          children: [
            Icon(
              Icons.done,
              color: isSelected ? Colors.black : Colors.transparent,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 8.0),
              child: Text(menuTitle),
            )
          ],
        ));
  }
}
