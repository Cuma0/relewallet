// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInResponseModel _$SignInResponseModelFromJson(Map<String, dynamic> json) =>
    SignInResponseModel(
      id: json['_id'] as String?,
      token: json['token'] as String?,
      email: json['email'] as String?,
      myCards: (json['myCards'] as List<dynamic>?)
          ?.map((e) => MyCardModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SignInResponseModelToJson(
        SignInResponseModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'token': instance.token,
      'email': instance.email,
      'myCards': instance.myCards,
    };
