import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:therealworldflutter_app/blocs/page_bloc.dart';
import 'package:therealworldflutter_app/models/page_response.dart';
import 'package:therealworldflutter_app/widgets/page_detail_screen.dart';
import 'package:therealworldflutter_app/services/page_api_provider.dart';
import 'login_screen.dart';
class PageWidget extends StatefulWidget {

  @override
  State<StatefulWidget> createState() {
    return _PageWidget();
  }

}

class _PageWidget extends State<PageWidget> {
  @override
  void initState() {
    super.initState();
    pageBloc.doLogin = _doLogin;
    /*
    = {
      return Future<LoginCredentials("Username", "Password");
    };*/
    pageBloc.getPage();
  }
  Future<LoginCredentials> _doLogin() async  {
    final loginScreen = LoginScreen();

    Navigator.push(context, MaterialPageRoute(builder: (context) => loginScreen));
    LoginCredentials token = await loginScreen.doLogin();
    return token;
    /*return Future<LoginCredentials>.delayed(Duration(seconds: 1), () {
      return LoginCredentials("fregin@me.com", "12345");
    });*/
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PageResponse>(
      stream: pageBloc.subject.stream,
      builder: (context, AsyncSnapshot<PageResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildPageWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }

  Widget _buildLoadingWidget() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text(
            "Loading data from API",
            style: Theme.of(context).textTheme.subtitle,
          ),
          CircularProgressIndicator()
        ],
      ),
    );
  }

  Widget _buildErrorWidget(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Text("Error occured: $error")
        ],
      ),
    );
  }

  Widget _buildPageWidget(PageResponse data) {
    return ListView.builder(
        itemCount: data.results.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text("${data.results[index].title}"),
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => PageDetailScreen(page: data.results[index]))
              );
            },
          );
        }
    );
  }
}
