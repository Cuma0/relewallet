// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_in_with_google_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignInWithGoogleModel _$SignInWithGoogleModelFromJson(
        Map<String, dynamic> json) =>
    SignInWithGoogleModel(
      idToken: json['idToken'] as String?,
      email: json['email'] as String?,
      fcmToken: json['fcmToken'] as String?,
      fcmTopic: json['fcmTopic'] as String?,
      isPassword: json['isPassword'] as bool?,
    );

Map<String, dynamic> _$SignInWithGoogleModelToJson(
        SignInWithGoogleModel instance) =>
    <String, dynamic>{
      'idToken': instance.idToken,
      'email': instance.email,
      'fcmToken': instance.fcmToken,
      'fcmTopic': instance.fcmTopic,
      'isPassword': instance.isPassword,
    };
