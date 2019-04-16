import 'package:therealworldflutter_app/repositories/page_repository.dart';
import 'package:therealworldflutter_app/services/page_api_provider.dart';
import 'package:rxdart/rxdart.dart';
import 'package:therealworldflutter_app/models/page_response.dart';

class PageBloc {
  final PageRepository _pageRepository = PageRepository();
  final BehaviorSubject<PageResponse> _subject = BehaviorSubject<PageResponse>();

  set doLogin(DoLogin login){
    _pageRepository.doLogin = login;
  }

  getPage() async {
    PageResponse response = await _pageRepository.getPage();
    _subject.sink.add(response);
  }

  dispose() {
    _subject.close();
  }

  BehaviorSubject<PageResponse> get subject => _subject;
}

final pageBloc = PageBloc();