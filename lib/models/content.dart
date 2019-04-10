class Content{
  final String id;
  final String textContent;
  final String pageId;
  Content(this.id, this.textContent, this.pageId);
  Content.fromJson(Map<String, dynamic> json) :
        id = json["id"], textContent = json["textContent"], pageId = json["pageId"];

}