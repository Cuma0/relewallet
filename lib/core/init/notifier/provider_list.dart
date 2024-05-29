import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../../../view/accountPage/provider/account_provider.dart';
import '../../../view/cardsPage/provider/card_provider.dart';
import '../../../view/cardsPage/provider/my_card_provider.dart';
import '../../../view/cardsPage/provider/storie_provider.dart';
import '../../../view/offersPage/provider/offer_provider.dart';
import '../navigation/navigation_provider.dart';
import 'theme_notifier.dart';

class ApplicationProvider {
  static ApplicationProvider? _instance;
  static ApplicationProvider get instance {
    _instance ??= ApplicationProvider._init();
    return _instance!;
  }

  ApplicationProvider._init();

  List<SingleChildWidget> singleItems = [];
  List<SingleChildWidget> dependItems = [
    ChangeNotifierProvider(create: (context) => ThemeNotifier()),
    ChangeNotifierProvider(create: (_) => NavigationProvider()),
    ChangeNotifierProvider(create: (_) => OfferProvider()),
    ChangeNotifierProvider(create: (_) => MyCardProvider()),
    ChangeNotifierProvider(create: (_) => StorieProvider()),
    ChangeNotifierProvider(create: (_) => CardProvider()),
    ChangeNotifierProvider(create: (_) => AccountProvider()),
  ];
  List<SingleChildWidget> uiChangesItems = [];
}
