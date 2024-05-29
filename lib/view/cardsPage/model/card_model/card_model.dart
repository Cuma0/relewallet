import 'package:azlistview/azlistview.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'card_model.g.dart';

@JsonSerializable()
class CardModel extends INetworkModel<CardModel> {
  @JsonKey(name: "_id")
  String? id;
  String? name;
  String? picture;

  CardModel({this.id, this.name, this.picture});

  @override
  CardModel fromJson(Map<String, dynamic> json) {
    return _$CardModelFromJson(json);
  }

  factory CardModel.fromJson(Map<String, dynamic> json) {
    return _$CardModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$CardModelToJson(this);
  }
}

class CardItemAZ extends ISuspensionBean {
  CardModel cardModel;
  String tag;

  CardItemAZ({required this.cardModel, required this.tag});

  @override
  String getSuspensionTag() => tag;
}
