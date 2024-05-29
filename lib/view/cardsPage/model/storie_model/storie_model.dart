import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'storie_model.g.dart';

@JsonSerializable()
class StorieModel extends INetworkModel<StorieModel> {
  @JsonKey(name: "_id")
  String? id;
  String? picture;
  String? coverPicture;
  String? link;

  StorieModel({this.id, this.picture, this.coverPicture, this.link});

  @override
  StorieModel fromJson(Map<String, dynamic> json) {
    return _$StorieModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$StorieModelToJson(this);
  }
}
