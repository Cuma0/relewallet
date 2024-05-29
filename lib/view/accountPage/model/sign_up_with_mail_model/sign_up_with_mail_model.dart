import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'sign_up_with_mail_model.g.dart';

@JsonSerializable()
class SignUpWithMailModel extends INetworkModel<SignUpWithMailModel> {
  String? email;
  String? password;
  bool? isPassword;
  String? fcmToken;

  SignUpWithMailModel({this.email, this.password, this.isPassword,this.fcmToken});

  @override
  SignUpWithMailModel fromJson(Map<String, dynamic> json) {
    return _$SignUpWithMailModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$SignUpWithMailModelToJson(this);
  }
}
