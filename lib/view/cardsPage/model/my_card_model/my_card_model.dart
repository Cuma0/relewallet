import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

import '../card_model/card_model.dart';

part 'my_card_model.g.dart';

@JsonSerializable()
class MyCardModel extends INetworkModel<MyCardModel> {
  @JsonKey(name: "_id")
  String? id;
  String? barcode;
  CardModel? card;
  String? updatedAt;

  MyCardModel({this.id, this.barcode, this.card, this.updatedAt});

  @override
  MyCardModel fromJson(Map<String, dynamic> json) {
    return _$MyCardModelFromJson(json);
  }

  factory MyCardModel.fromJson(Map<String, dynamic> json) {
    return _$MyCardModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$MyCardModelToJson(this);
  }
}
