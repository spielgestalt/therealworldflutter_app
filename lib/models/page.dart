class Page {
  final String id;
  final String title;
  final String parentId;

  Page(this.id, this.title, this.parentId);
  Page.fromJson(Map<String,dynamic> json): id = json["id"], title = json["title"], parentId = json["parentId"];

}