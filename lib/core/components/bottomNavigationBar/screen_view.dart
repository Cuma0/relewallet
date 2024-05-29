// ignore_for_file: deprecated_member_use

import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';

import '../../constants/app/icon_constants.dart';
import '../../extension/context_extension.dart';
import '../../extension/string_extension.dart';
import '../../init/lang/locale_keys.g.dart';
import '../../init/navigation/navigation_provider.dart';
import '../../theme/light/color_scheme_light.dart';

class ScreenView extends StatefulWidget {
  const ScreenView({super.key});

  @override
  State<ScreenView> createState() => _ScreenViewState();
}

class _ScreenViewState extends State<ScreenView> {
  late PageController _pageController;

  GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _pageController = PageController(keepPage: true);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<NavigationProvider>(
      builder: (context, provider, child) {
        final bottomNavigationBarItems = provider.screens
            .map(
              (screen) => BottomNavigationBarItem(
                icon: Platform.isAndroid
                    ? Center(
                        child: screen.icon,
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: context.paddingLow.top),
                        child: screen.icon,
                      ),
                activeIcon: Platform.isAndroid
                    ? Center(
                        child: screen.activeIcon,
                      )
                    : Padding(
                        padding: EdgeInsets.only(top: context.paddingLow.top),
                        child: screen.activeIcon,
                      ),
                label: screen.title,
              ),
            )
            .toList();

        final screens = provider.screens
            .map(
              (screen) => Navigator(
                key: screen.navigatorState,
                onGenerateRoute: screen.onGenerateRoute,
              ),
            )
            .toList();

        return WillPopScope(
          onWillPop: () async => provider.onWillPop(context),
          child: ScaffoldMessenger(
            key: scaffoldMessengerKey,
            child: Scaffold(
              body: IndexedStack(
                index: provider.currentTabIndex,
                children: screens,
              ),
              bottomNavigationBar: _bottomNavigationBar(
                  context, bottomNavigationBarItems, provider),
            ),
          ),
        );
      },
    );
  }

  Widget _bottomNavigationBar(
      BuildContext context,
      List<BottomNavigationBarItem> bottomNavigationBarItems,
      NavigationProvider provider) {
    return Container(
      color: Colors.white,
      height: context.mediumValue * 2.3,
      alignment: Alignment.topCenter,
      padding: EdgeInsets.only(
          left: context.paddingNormalHorizontal.horizontal / 2,
          right: context.paddingNormalHorizontal.horizontal / 2,
          top: Platform.isAndroid
              ? 0
              : context.paddingNormalHorizontal.horizontal / 8
          // vertical: context.paddingLowVertical.vertical,
          ),
      child: GNav(
        backgroundColor: Colors.white,
        activeColor: ColorSchemeLight.instance!.white,
        color: ColorSchemeLight.instance!.blue,
        tabBackgroundColor: ColorSchemeLight.instance!.blue,
        gap: 8,
        padding: const EdgeInsets.all(10),
        tabs: [
          GButton(
            icon: IconConstants.cards,
            text: LocaleKeys.cards_page_cards.locale,
            iconSize: 20,
          ),
          GButton(
            icon: IconConstants.offer,
            text: LocaleKeys.offers_page_offers.locale,
            iconSize: 24,
          ),
          GButton(
            icon: IconConstants.account,
            text: LocaleKeys.account_page_account.locale,
            iconSize: 24,
          )
        ],
        selectedIndex: provider.currentTabIndex,
        onTabChange: (index) {
          provider.setTab(index);
        },
      ),
    );
  }
}
