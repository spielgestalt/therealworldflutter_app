import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:rxdart/rxdart.dart';
import 'package:therealworldflutter_app/services/page_api_provider.dart';

class LoginScreen extends StatelessWidget {
  final _login = PublishSubject<LoginCredentials>();
  final _username = TextField(controller: TextEditingController(text: "fregin@me.com"),);
  final _password = TextField(controller: TextEditingController(text: "12345"),);
  Future<LoginCredentials> doLogin() {
    return _login.first;
  }
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: _loginForm(context),
    );
  }

  Widget _loginForm(BuildContext context) {
    return Center(
      child: Column(
        children: <Widget>[
          _username,
          _password,
          RaisedButton(
            onPressed: () {
              _login.add(LoginCredentials(_username.controller.text, _password.controller.text));
              Navigator.pop(context);
            },
            child: Text("Login"),
          )
        ],
      ),
      /*child: RaisedButton(onPressed: () {
        _login.add("asdfasdf");
        Navigator.pop(context);
      }),*/
    );
  }
}