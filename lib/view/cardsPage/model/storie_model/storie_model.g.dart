// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'storie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

StorieModel _$StorieModelFromJson(Map<String, dynamic> json) => StorieModel(
      id: json['_id'] as String?,
      picture: json['picture'] as String?,
      coverPicture: json['coverPicture'] as String?,
      link: json['link'] as String?,
    );

Map<String, dynamic> _$StorieModelToJson(StorieModel instance) =>
    <String, dynamic>{
      '_id': instance.id,
      'picture': instance.picture,
      'coverPicture': instance.coverPicture,
      'link': instance.link,
    };
