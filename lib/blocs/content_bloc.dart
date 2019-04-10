import 'package:therealworldflutter_app/models/content_response.dart';
import 'package:therealworldflutter_app/repositories/page_repository.dart';
import 'package:rxdart/rxdart.dart';


class ContentBloc {
  final PageRepository _pageRepository = PageRepository();
  final BehaviorSubject<ContentResponse> _subject = BehaviorSubject<ContentResponse>();

  getContent(String pageId) async {
    ContentResponse response = await _pageRepository.getContent(pageId);
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<ContentResponse> get subject => _subject;
}

final contentBloc = ContentBloc();