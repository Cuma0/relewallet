import 'package:vexana/vexana.dart';

import '../../../../core/base/state/service_helper.dart';
import '../model/update_my_card_model.dart';
import 'IMyCardInfopageService.dart';

class MyCardInfopageService extends IMyCardInfopageService with ServiceHelper {
  MyCardInfopageService(super.manager,
      super.scaffoldMessengerKey);

  @override
  Future<bool> updateMyCard(UpdateMyCardModel updateMyCardModel) async {
    final response = await manager.send(
      "/myCard/update",
      parseModel: UpdateMyCardModel(),
      method: RequestType.POST,
      data: updateMyCardModel,
    );

    if (response.error == null) {
      return true;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return false;
    } else {
      return false;
    }
  }

  @override
  Future<bool> deleteMyCard(UpdateMyCardModel updateMyCardModel) async {
    final response = await manager.send(
      "/myCard",
      parseModel: UpdateMyCardModel(),
      method: RequestType.DELETE,
      data: updateMyCardModel,
    );

    if (response.error == null) {
      return true;
    } else if (response.error?.statusCode != 401) {
      showMessage(
        scaffoldMessengerKey: scaffoldMessengerKey,
        errorModel: response.error,
        context: scaffoldMessengerKey!.currentContext!,
      );
      return false;
    } else {
      return false;
    }
  }
}
