import 'package:json_annotation/json_annotation.dart';
part 'page.g.dart';

@JsonSerializable()
class Page {
  final String id;
  final String title;
  final String parentId;

  Page({this.id, this.title, this.parentId});
  factory Page.fromJson(Map<String,dynamic> json) => _$PageFromJson(json);
  Map<String,dynamic> toJson() => _$PageToJson(this);
  //Page.fromJson(Map<String,dynamic> json): id = json["id"], title = json["title"], parentId = json["parentId"];

}