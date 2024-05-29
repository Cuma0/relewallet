import 'package:vexana/vexana.dart';

import '../../../../core/base/state/service_helper.dart';
import '../model/offer_model.dart';
import 'IOfferspageService.dart';

class OfferspageService extends IOfferspageService with ServiceHelper {
  OfferspageService(super.manager,
      super.scaffoldMessengerKey);

  @override
  Future<List<OfferModel>?> getOffers({required String lang}) async {
    final response = await manager.send<OfferModel, List<OfferModel>>(
        "/offer/$lang",
        parseModel: OfferModel(),
        method: RequestType.GET);

    if (response.data is List<OfferModel>) {
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
