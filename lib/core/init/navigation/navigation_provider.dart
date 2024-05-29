// ignore_for_file: constant_identifier_names

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:relewallet/view/accountPage/view/cardAsisstantView/card_asisstant_view.dart';
import 'package:relewallet/view/accountPage/viewmodel/account_page_viewmodel.dart';
import 'package:relewallet/view/advancedSettingsPage/view/advanced_settings_page_view.dart';

import '../../../view/accountPage/view/account_page_view.dart';
import '../../../view/accountPage/view/change_lang_page.dart';
import '../../../view/auth/splashPage/view/splash_page_view.dart';
import '../../../view/cardsPage/model/my_card_model/my_card_model.dart';
import '../../../view/cardsPage/model/storie_model/storie_model.dart';
import '../../../view/cardsPage/view/barcode_scanner_view.dart';
import '../../../view/cardsPage/view/cards_page_view.dart';
import '../../../view/myCardInfoPage/view/my_card_info_page_view.dart';
import '../../../view/offersPage/view/offers_page_view.dart';
import '../../../view/storiePage/view/storie_page_view.dart';
import '../../components/bottomNavigationBar/keep_alive.dart';
import '../../components/bottomNavigationBar/screen_model.dart';
import '../../components/bottomNavigationBar/screen_view.dart';
import '../../constants/app/icon_constants.dart';
import '../../constants/navigation/navigation_constants.dart';
import '../../theme/light/color_scheme_light.dart';

const CARDS_SCREEN = 0;
const OFFERS_SCREEN = 1;
const ACCOUNT_SCREEN = 2;

class NavigationProvider extends ChangeNotifier {
  static NavigationProvider of(BuildContext context) =>
      Provider.of<NavigationProvider>(context, listen: false);

  int _currentScreenIndex = CARDS_SCREEN;

  int get currentTabIndex => _currentScreenIndex;

  Route<dynamic> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case NavigationConstants.SCREEN_VIEW:
        return navigate(widget: const ScreenView());

      case NavigationConstants.STORIE_PAGE_VIEW:
        return navigate(
          widget: StoriePageView(
            storieList: settings.arguments as List<StorieModel>,
          ),
          isFullScreen: true, // with leading cross icon.
        );

      case NavigationConstants.BARCODE_SCAN_PAGE_VIEW:
        return navigate(
          widget: const BarcodeScannerView(),
          isFullScreen: true,
        );

      case NavigationConstants.MY_CARD_INFO_PAGE_VIEW:
        return navigate(
          widget: MyCardInfoPageView(
            myCardModel: settings.arguments as MyCardModel,
          ),
          isFullScreen: true,
        );

      case NavigationConstants.LANG_CHANGE_PAGE_VIEW:
        return navigate(
          widget: const ChangeLanguagePage(),
          isFullScreen: false,
        );
      case NavigationConstants.ADVANCED_SETTINGS_PAGE_VIEW:
        return navigate(
          widget: AdvancedSettingsPageView(
            myCardList: settings.arguments as List<MyCardModel>,
          ),
          isFullScreen: false,
        );
      case NavigationConstants.ADVANCED_SETTINGS_INFO_PAGE_VIEW:
        return navigate(
          widget: MyCardInfoPageView(
              myCardModel: settings.arguments as MyCardModel),
          isFullScreen: false,
        );

      case NavigationConstants.CARD_ASISSTANT_VIEW:
        return navigate(
          widget:  CardAsisstantView(viewmodel: settings.arguments as AccountPageViewmodel,),
          isFullScreen: false,
    
        );
      default:
        return MaterialPageRoute(builder: (_) => const SplashPageView());
    }
  }

  MaterialPageRoute<dynamic> navigate(
      {required Widget widget, bool? isFullScreen}) {
    return MaterialPageRoute(
      fullscreenDialog: isFullScreen ?? false,
      builder: (context) => widget,
    );
  }

  final Map<int, Screen> _screens = {
    CARDS_SCREEN: Screen(
      title: 'Cards',
      icon: Icon(
        IconConstants.cards,
        color: ColorSchemeLight.instance!.blue,
        size: 20,
      ),
      activeIcon: Icon(
        IconConstants.cards,
        color: ColorSchemeLight.instance!.white,
        size: 20,
      ),
      child: const KeepAlivePage(child: CardsPageView()),
      initialRoute: NavigationConstants.CARDS_PAGE_VIEW,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case NavigationConstants.STORIE_PAGE_VIEW:
            return MaterialPageRoute(
                fullscreenDialog: true,
                builder: (context) => const ScreenView());

          default:
            return MaterialPageRoute(
                builder: (_) => const KeepAlivePage(child: CardsPageView()));
        }
      },
      scrollController: ScrollController(),
    ),
    OFFERS_SCREEN: Screen(
      title: 'Offers',
      icon: Icon(
        IconConstants.offer,
        color: ColorSchemeLight.instance!.blue,
        size: 20,
      ),
      activeIcon: Icon(
        IconConstants.offer,
        color: ColorSchemeLight.instance!.white,
        size: 20,
      ),
      child: const KeepAlivePage(child: OffersPageView()),
      initialRoute: NavigationConstants.OFFERS_PAGE_VIEW,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          default:
            return MaterialPageRoute(
                builder: (_) => const KeepAlivePage(child: OffersPageView()));
        }
      },
      scrollController: ScrollController(),
    ),
    ACCOUNT_SCREEN: Screen(
      title: 'Account',
      icon: Icon(
        IconConstants.account,
        color: ColorSchemeLight.instance!.blue,
        size: 20,
      ),
      activeIcon: Icon(
        IconConstants.account,
        color: ColorSchemeLight.instance!.white,
        size: 20,
      ),
      child: const AccountPageView(),
      initialRoute: NavigationConstants.ACCOUNT_PAGE_VIEW,
      navigatorState: GlobalKey<NavigatorState>(),
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case NavigationConstants.LANG_CHANGE_PAGE_VIEW:
            return MaterialPageRoute(
                builder: (context) => const ChangeLanguagePage());
          default:
            return MaterialPageRoute(
                builder: (_) => const KeepAlivePage(child: AccountPageView()));
        }
      },
      scrollController: ScrollController(),
    ),
  };

  List<Screen> get screens => _screens.values.toList();

  Screen? get currentScreen => _screens[_currentScreenIndex];

  /// Set currently visible tab.
  void setTab(int tab) {
    if (tab == currentTabIndex) {
      _scrollToStart();
    } else {
      _currentScreenIndex = tab;
      notifyListeners();
    }
  }

  /// If currently displayed screen has given [ScrollController] animate it
  /// to the start of scroll view.
  void _scrollToStart() {
    if (currentScreen?.scrollController != null &&
        currentScreen!.scrollController!.hasClients) {
      currentScreen!.scrollController!.animateTo(
        0,
        duration: const Duration(milliseconds: 200),
        curve: Curves.ease,
      );
    }
  }

  Future<bool> onWillPop(BuildContext context) async {
    return false;
    // final currentNavigatorState = currentScreen!.navigatorState.currentState;

    // if (currentNavigatorState!.canPop()) {
    //  // currentNavigatorState.pop();
    //   return false;
    // } else {
    //   /*if (currentTabIndex != LIBRARY_SCREEN) {
    //     setTab(LIBRARY_SCREEN);
    //     notifyListeners();
    //     return false;
    //   } else {
    //     return await showDialog(
    //       context: context,
    //       builder: (context) => ExitAlertDialog(),
    //     );
    //   }*/
    //   setTab(ROOMS_SCREEN);
    //   notifyListeners();
    //   return false;
    // }
  }
}
