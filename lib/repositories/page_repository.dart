import 'package:therealworldflutter_app/services/page_api_provider.dart';
import 'package:therealworldflutter_app/models/page_response.dart';
import 'package:therealworldflutter_app/models/content_response.dart';
class PageRepository {
  PageApiProvider _apiProvider = PageApiProvider();

  Future<PageResponse> getPage() {
    return _apiProvider.getPage();
  }

  Future<ContentResponse> getContent(String pageId) {
    return _apiProvider.getContent(pageId);
  }
}