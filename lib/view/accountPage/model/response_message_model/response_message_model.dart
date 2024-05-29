import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'response_message_model.g.dart';

@JsonSerializable()
class ResponseMessageModel extends INetworkModel<ResponseMessageModel> {
  String? message;

  ResponseMessageModel({this.message});

  @override
  ResponseMessageModel fromJson(Map<String, dynamic> json) {
    return _$ResponseMessageModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$ResponseMessageModelToJson(this);
  }
}
