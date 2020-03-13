import 'package:flutter/material.dart';
import 'package:testpycoflutter/data/model/user_data.dart';
import 'package:testpycoflutter/tinder/favorite_presenter.dart';
import 'package:testpycoflutter/utils/hex_color.dart';

class FavoritePage extends StatefulWidget {
  @override
  _FavoritePageState createState() => _FavoritePageState();
}

class _FavoritePageState extends State<FavoritePage>
    implements FavoritePageContract {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  FavoritePagePresenter _presenter;
  List<User> peoples;
  bool _isLoading;

  _FavoritePageState() {
    _presenter = new FavoritePagePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isLoading = true;
    _presenter.loadFavoritePeople();
  }

  void _showSnackBar(String text) {
    _globalKey.currentState.showSnackBar(new SnackBar(
        content: Text(text),
        duration: Duration(seconds: 5),
        backgroundColor: Colors.grey));
  }

  @override
  Widget build(BuildContext context) {
    Widget result;
    if (_isLoading) {
      result = Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (peoples.length <= 0) {
        result = MaterialApp(
          title: 'Tinder',
          home: Scaffold(
            key: _globalKey,
            appBar: AppBar(
              title: Text("Favorite People"),
              centerTitle: true,
              backgroundColor: HexColor("#FE3C72"),
            ),
            body: Center(
              child: Text("Không có danh sách yêu thích"),
            ),
          ),
        );
      } else {
        result = MaterialApp(
          title: 'Tinder',
          home: Scaffold(
            key: _globalKey,
            appBar: AppBar(
              title: Text("Favorite People"),
              centerTitle: true,
              backgroundColor: HexColor("#FE3C72"),
            ),
            body: ListView.builder(
                itemCount: peoples.length - 1,
                itemBuilder: (context, index) {
                  final widgetItem = Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: ListTile(
                            title: Text(
                                "${peoples[index].name.title} ${peoples[index].name.first} ${peoples[index].name.last}"),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Phone : ${peoples[index].phone} "),
                                Text("Cell : ${peoples[index].cell}"),
                                Text("Email : ${peoples[index].email}")
                              ],
                            ),
                            leading: new CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                    '${peoples[index].name.first.substring(0, 1)}'))),
                      ),
                      Divider(
                        color: Colors.grey,
                      )
                    ],
                  );
                  return widgetItem;
                }),
          ),
        );
      }
    }
    return result;
  }

  @override
  void unFavorite(User user) {}

  @override
  void showError(String error) {
    _showSnackBar(error);
  }

  @override
  void showFavorires(List<User> users) {
    setState(() {
      _isLoading = false;
      peoples = users;
    });
  }
}
