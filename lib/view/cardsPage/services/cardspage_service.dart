import 'package:vexana/vexana.dart';

import '../../../../core/base/state/service_helper.dart';
import '../../../core/constants/enums/locale_keys_enum.dart';
import '../../../core/init/cache/locale_manager.dart';
import '../model/card_model/card_model.dart';
import '../model/my_card_model/my_card_model.dart';
import '../model/storie_model/storie_model.dart';
import 'ICardspageService.dart';

class CardspageService extends ICardspageService with ServiceHelper {
  CardspageService(super.manager,
      super.scaffoldMessengerKey);

  @override
  Future<List<StorieModel>?> getStories() async {
    final response = await manager.send<StorieModel, List<StorieModel>>(
        "/storie",
        parseModel: StorieModel(),
        method: RequestType.GET);

    if (response.data is List<StorieModel>) {
      return response.data;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<List<MyCardModel>?> getMyCards() async {
    String token = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);
    final response = await manager.send<MyCardModel, List<MyCardModel>>(
      "/myCard",
      parseModel: MyCardModel(),
      method: RequestType.GET,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      ),
    );

    if (response.data is List<MyCardModel>) {
      return response.data;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<MyCardModel?> createMyCard(
      {required String barcode, required String cardId}) async {
    String token = LocaleManager.instance.getStringValue(PreferencesKeys.TOKEN);
    final response = await manager.send<MyCardModel, MyCardModel>(
      "/myCard",
      parseModel: MyCardModel(),
      method: RequestType.POST,
      options: Options(
        headers: {
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
      ),
      data: {
        "barcode": barcode,
        "cardId": cardId,
      },
    );

    if (response.data is MyCardModel) {
      return response.data;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return null;
    } else {
      return null;
    }
  }

  @override
  Future<List<CardModel>?> getCards() async {
    final response = await manager.send<CardModel, List<CardModel>>("/card",
        parseModel: CardModel(), method: RequestType.GET);

    if (response.data is List<CardModel>) {
      return response.data;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return null;
    } else {
      return null;
    }
  }
}
