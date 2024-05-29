import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'offer_model.g.dart';

@JsonSerializable()
class OfferModel extends INetworkModel<OfferModel> {
  @JsonKey(name: "_id")
  String? id;
  String? picture;
  String? title;
  String? subtitle;
  String? validityPeriod;

  OfferModel(
      {this.id, this.picture, this.title, this.subtitle, this.validityPeriod});

  @override
  OfferModel fromJson(Map<String, dynamic> json) {
    return _$OfferModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$OfferModelToJson(this);
  }
}
