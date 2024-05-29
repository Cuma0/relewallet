// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'offer_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OfferModel _$OfferModelFromJson(Map<String, dynamic> json) => OfferModel(
      id: json['_id'] as String?,
      picture: json['picture'] as String?,
      title: json['title'] as String?,
      subtitle: json['subtitle'] as String?,
      validityPeriod: json['validityPeriod'] as String?,
    );

Map<String, dynamic> _$OfferModelToJson(OfferModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'picture': instance.picture,
      'title': instance.title,
      'subtitle': instance.subtitle,
      'validityPeriod': instance.validityPeriod,
    };
