import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

part 'sign_in_with_google_model.g.dart';

@JsonSerializable()
class SignInWithGoogleModel extends INetworkModel<SignInWithGoogleModel> {
  String? idToken;
  String? email;
  String? fcmToken;
  String? fcmTopic;
  bool? isPassword;

  SignInWithGoogleModel(
      {this.idToken,
      this.email,
      this.fcmToken,
      this.fcmTopic,
      this.isPassword});

  @override
  SignInWithGoogleModel fromJson(Map<String, dynamic> json) {
    return _$SignInWithGoogleModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$SignInWithGoogleModelToJson(this);
  }
}
