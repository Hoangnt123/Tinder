import 'package:flutter/material.dart';
import 'package:testpycoflutter/data/model/user_data.dart';
import 'package:testpycoflutter/tinder/favorite_presenter.dart';
import 'package:testpycoflutter/utils/hex_color.dart';


class FavoriteList extends StatefulWidget {
  @override
  _FavoriteListState createState() => _FavoriteListState();
}

class _FavoriteListState extends State<FavoriteList>
    implements FavoriteListViewContract {
  GlobalKey<ScaffoldState> _globalKey = new GlobalKey<ScaffoldState>();
  FavoritePresenter _presenter;
  List<User> people;
  bool _isSearching;

  _FavoriteListState() {
    _presenter = new FavoritePresenter(this);
  }

  @override
  void initState() {
    super.initState();
    _isSearching = true;
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
    if (_isSearching) {
      result = Center(
        child: Padding(
          padding: EdgeInsets.only(left: 16.0, right: 16.0),
          child: CircularProgressIndicator(),
        ),
      );
    } else {
      if (people.length <= 0) {
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
                itemCount: people.length - 1,
                itemBuilder: (context, index) {


                  final widgetItem = Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        padding: EdgeInsets.all(5.0),
                        child: ListTile(
                            title: Text(
                                "${people[index].name.title} ${people[index].name.first} ${people[index].name.last}"),
                            subtitle: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                Text("Phone : ${people[index].phone} "),
                                Text("Cell : ${people[index].cell}"),
                                Text("Email : ${people[index].email}")
                              ],
                            ),
                            leading: new CircleAvatar(
                                backgroundColor: Colors.blue,
                                child: Text(
                                    '${people[index].name.first.substring(0, 1)}'))),
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
      _isSearching = false;
      people = users;
    });
  }
  @override
  void onLoadContactsError() {

  }

  @override
  void onLoadFavorireComplete(List<User> users) {
  }

  @override
  void onLoadUserError(String message) {
  }




}
