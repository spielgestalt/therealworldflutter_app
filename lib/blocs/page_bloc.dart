import 'package:therealworldflutter_app/repositories/page_repository.dart';
import 'package:rxdart/rxdart.dart';
import 'package:therealworldflutter_app/models/page_response.dart';

class PageBloc {
  final PageRepository _pageRepository = PageRepository();
  final BehaviorSubject<PageResponse> _subject = BehaviorSubject<PageResponse>();

  getPage() async {
    PageResponse response = await _pageRepository.getPage();
    await
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PageResponse> get subject => _subject;
}

final pageBloc = PageBloc();