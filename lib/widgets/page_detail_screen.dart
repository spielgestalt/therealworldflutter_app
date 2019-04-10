import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:therealworldflutter_app/models/page.dart';
import 'package:therealworldflutter_app/blocs/content_bloc.dart';
import 'package:therealworldflutter_app/models/content_response.dart';
class PageDetailScreen extends StatefulWidget {
  final Page page;

  PageDetailScreen({Key key, @required this.page} ): super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _PageDetailScreen(page);

  }

}
class _PageDetailScreen extends State<PageDetailScreen> {
  final Page page;

  _PageDetailScreen(this.page) : super();
  
  @override
  void initState() {
    super.initState();
    contentBloc.getContent(page.id);
  }
  
  Widget _buildDetailScreen(BuildContext context) {
    return StreamBuilder<ContentResponse>(
      stream: contentBloc.subject.stream,
      builder: (context, AsyncSnapshot<ContentResponse> snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data.error != null && snapshot.data.error.length > 0) {
            return _buildErrorWidget(snapshot.data.error);
          }
          return _buildContentWidget(snapshot.data);
        } else if (snapshot.hasError) {
          return _buildErrorWidget(snapshot.error);
        } else {
          return _buildLoadingWidget();
        }
      },
    );
  }
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page.title),
      ),
      body: Container(
        child: _buildDetailScreen(context),
      ),
    );
    
  }
  Widget _buildContentWidget(ContentResponse data) {
    return ListView.builder(
      itemCount: data.results.length,
      itemBuilder: (context, index) {
        return ListTile(
          title: Text("${data.results[index].textContent}", style: TextStyle(color: Colors.blue),),
        );
      });
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
}
/*class PageDetailScreen extends StatelessWidget{

  final Page page;

  PageDetailScreen({Key key, @required this.page} ): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(page.title),
      ),
      body: Container(
        decoration: BoxDecoration(color: Colors.blue),
        padding: EdgeInsets.all(8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                Icon(Icons.pages)
              ],
            ),
            Column(
              children: <Widget>[
                Text(page.title),
                Text(page.parentId ?? "--")
              ],
            )

          ],
        )
      )

    );
  }
}*/