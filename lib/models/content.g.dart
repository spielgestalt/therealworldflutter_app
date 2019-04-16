// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'content.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Content _$ContentFromJson(Map<String, dynamic> json) {
  return Content(
      id: json['id'] as String,
      textContent: json['textContent'] as String,
      pageId: json['pageId'] as String);
}

Map<String, dynamic> _$ContentToJson(Content instance) => <String, dynamic>{
      'id': instance.id,
      'textContent': instance.textContent,
      'pageId': instance.pageId
    };
