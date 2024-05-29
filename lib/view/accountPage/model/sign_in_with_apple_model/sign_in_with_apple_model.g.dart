// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_with_apple_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInWithAppleModel _$SignInWithAppleModelFromJson(
        Map<String, dynamic> json) =>
    SignInWithAppleModel(
      authorizationCode: json['authorizationCode'] as String?,
      identityToken: json['identityToken'] as String?,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$SignInWithAppleModelToJson(
        SignInWithAppleModel instance) =>
    <String, dynamic>{
      'authorizationCode': instance.authorizationCode,
      'identityToken': instance.identityToken,
      'fcmToken': instance.fcmToken,
    };
