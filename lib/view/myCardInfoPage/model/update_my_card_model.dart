import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'update_my_card_model.g.dart';

@JsonSerializable()
class UpdateMyCardModel extends INetworkModel<UpdateMyCardModel> {
  String? myCardId;
  String? barcode;

  UpdateMyCardModel({this.myCardId, this.barcode});

  @override
  UpdateMyCardModel fromJson(Map<String, dynamic> json) {
    return _$UpdateMyCardModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$UpdateMyCardModelToJson(this);
  }
}
