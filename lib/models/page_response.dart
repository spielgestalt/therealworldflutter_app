import 'package:therealworldflutter_app/models/page.dart';

class PageResponse {
  final List<Page> results;
  final String error;
  PageResponse(this.results, this.error);

  PageResponse.fromJson(List json): results = json
      .map((i) => new Page.fromJson(i))
      .toList(), error = "";
  PageResponse.withError(String errorValue): results = List(), error = errorValue;
}