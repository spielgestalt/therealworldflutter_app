import 'package:json_annotation/json_annotation.dart';
part 'content.g.dart';
@JsonSerializable()
class Content{
  final String id;
  final String textContent;
  final String pageId;
  Content({this.id, this.textContent, this.pageId});
  factory Content.fromJson(Map<String, dynamic> json) => _$ContentFromJson(json);

  Map<String, dynamic> toJson() => _$ContentToJson(this);
}