
import 'package:therealworldflutter_app/models/content.dart';

class ContentResponse {
  final List<Content> results;
  final String error;
  ContentResponse(this.results, this.error);

  ContentResponse.fromJson(List json): results = json
      .map((i) => new Content.fromJson(i))
      .toList(), error = "";
  ContentResponse.withError(String errorValue): results = List(), error = errorValue;
}
