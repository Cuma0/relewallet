import 'package:json_annotation/json_annotation.dart';
import 'package:vexana/vexana.dart';

import '../../../cardsPage/model/my_card_model/my_card_model.dart';

part 'sign_in_response_model.g.dart';

@JsonSerializable()
class SignInResponseModel extends INetworkModel<SignInResponseModel> {
  @JsonKey(name: "_id")
  String? id;
  String? token;
  String? email;
  List<MyCardModel>? myCards;

  SignInResponseModel({this.id, this.token, this.email, this.myCards});

  @override
  SignInResponseModel fromJson(Map<String, dynamic> json) {
    return _$SignInResponseModelFromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return _$SignInResponseModelToJson(this);
  }
}
