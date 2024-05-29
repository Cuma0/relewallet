import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'sign_in_with_apple_model.g.dart';

@JsonSerializable()
class SignInWithAppleModel extends INetworkModel<SignInWithAppleModel> {
  String? authorizationCode;
  String? identityToken;
  String? fcmToken;
  SignInWithAppleModel({this.authorizationCode, this.identityToken, this.fcmToken});

  @override
  SignInWithAppleModel fromJson(Map<String, dynamic> json) {
    return _$SignInWithAppleModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$SignInWithAppleModelToJson(this);
  }
}
