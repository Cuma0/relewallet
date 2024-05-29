// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_card_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyCardModel _$MyCardModelFromJson(Map<String, dynamic> json) => MyCardModel(
      id: json['_id'] as String?,
      barcode: json['barcode'] as String?,
      card: json['card'] == null
          ? null
          : CardModel.fromJson(json['card'] as Map<String, dynamic>),
      updatedAt: json['updatedAt'] as String?,
    );

Map<String, dynamic> _$MyCardModelToJson(MyCardModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'barcode': instance.barcode,
      'card': instance.card,
      'updatedAt': instance.updatedAt,
    };
