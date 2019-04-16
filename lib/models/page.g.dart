// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'page.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Page _$PageFromJson(Map<String, dynamic> json) {
  return Page(
      id: json['id'] as String,
      title: json['title'] as String,
      parentId: json['parentId'] as String);
}

Map<String, dynamic> _$PageToJson(Page instance) => <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'parentId': instance.parentId
    };
