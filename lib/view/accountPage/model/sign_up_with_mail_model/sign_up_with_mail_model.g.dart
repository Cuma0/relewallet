// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'sign_up_with_mail_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SignUpWithMailModel _$SignUpWithMailModelFromJson(Map<String, dynamic> json) =>
    SignUpWithMailModel(
      email: json['email'] as String?,
      password: json['password'] as String?,
      isPassword: json['isPassword'] as bool?,
      fcmToken: json['fcmToken'] as String?,
    );

Map<String, dynamic> _$SignUpWithMailModelToJson(
        SignUpWithMailModel instance) =>
    <String, dynamic>{
      'email': instance.email,
      'password': instance.password,
      'isPassword': instance.isPassword,
      'fcmToken': instance.fcmToken,
    };
