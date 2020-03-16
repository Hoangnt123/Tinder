import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:swipe_stack/swipe_stack.dart';
import 'package:testpycoflutter/data/user_data.dart';
import 'package:testpycoflutter/model/user.dart';
import 'package:testpycoflutter/tinder/favorite.dart';

class ViewPage extends StatefulWidget {
  @override
  _ViewPageState createState() => _ViewPageState();
}

class _ViewPageState extends State<ViewPage> {
  bool _isLoading;
  User _currentUser;

  final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();

  @override
  void initState() {
    super.initState();

    _fetchUserFromNetwork();
  }

  _fetchUserFromNetwork() async {
    setState(() {
      _isLoading = true;
    });

    User user;
    bool isLoading;
    try {
      final response =
          await http.get('https://randomuser.me/api/0.4/?randomapi');

      if (response.statusCode == 200) {
        ApiResponse apiResponse =
            ApiResponse.fromJson(json.decode(response.body));

        isLoading = false;
        user = apiResponse.userList.first;
      } else {
        _showError("Fail to load user");

        isLoading = false;
        user = null;
      }
    } catch (exception) {
      _showError(exception.toString());

      isLoading = false;
      user = null;
    }

    setState(() {
      _isLoading = isLoading;
      _currentUser = user;
    });
  }

  void _showError(String error) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        content: Text(error),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.pink,
        title: Text("                         Tinder"),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.star),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FavoriteView()),
              );
            },
          ),
        ],
      ),
      body: SafeArea(
        child: Stack(
          children: <Widget>[
            Container(
              height: 200.0,
              color: Colors.grey,
            ),
            Center(
              child: _isLoading == true
                  ? CircularProgressIndicator()
                  : Container(
                      height: 500.0,
                      padding: const EdgeInsets.symmetric(horizontal: 24.0),
                      child: _currentUser == null
                          ? SizedBox()
                          : SwipeStack(
                              children: [
                                SwiperItem(
                                  builder: (SwiperPosition position,
                                      double progress) {
                                    return _UserCard(_currentUser);
                                  },
                                ),
                              ],
                              visibleCount: 3,
                              stackFrom: StackFrom.Top,
                              translationInterval: 6,
                              scaleInterval: 0.03,
                              onSwipe: (int index, SwiperPosition position) {
                                if (position != SwiperPosition.None) {
                                  _fetchUserFromNetwork();
                                  if (position == SwiperPosition.Right) {
                                    User user = _currentUser;
                                    userData.insertFavoriteUser(user);
                                  }
                                }
                              },
                            ),
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _UserCard extends StatefulWidget {
  final User user;

  _UserCard(this.user);

  @override
  _UserCardState createState() => _UserCardState();
}

class UserDetail {
  final IconData iconData;
  final String text;
  final String value;

  UserDetail({this.iconData, this.text, this.value});
}

class _UserCardState extends State<_UserCard> {
  int _currentDetailIndex = 0;
  List<UserDetail> userDetails;

  @override
  void initState() {
    super.initState();

    userDetails = [
      UserDetail(
        iconData: Icons.email,
        text: "email",
        value: widget.user.email,
      ),
      UserDetail(
        iconData: Icons.assignment,
        text: "gender",
        value: widget.user.gender,
      ),
      UserDetail(
        iconData: Icons.location_on,
        text: "location",
        value: widget.user.location,
      ),
      UserDetail(
        iconData: Icons.phone,
        text: "phone",
        value: widget.user.phone,
      ),
      UserDetail(
        iconData: Icons.lock,
        text: "password",
        value: widget.user.password,
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2.0,
      child: Stack(
        children: <Widget>[
          _buildBackground(),
          _buildContent(),
        ],
      ),
    );
  }

  Widget _buildBackground() {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Container(
          height: 150.0,
          color: Colors.white,
        ),
        Container(
          height: 1.0,
          color: Colors.grey,
        ),
        Expanded(
          child: SizedBox(),
        ),
      ],
    );
  }

  Widget _buildContent() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: <Widget>[
          SizedBox(height: 24.0),
          Container(
            width: 180.0,
            height: 180.0,
            padding: const EdgeInsets.all(6.0),
            decoration: BoxDecoration(
              color: Colors.white,
              shape: BoxShape.circle,
              border: Border.all(
                color: Colors.grey,
                width: 1.5,
              ),
            ),
            child: CircleAvatar(
              radius: 90.0,
              backgroundImage: NetworkImage(
                widget.user.avatarUrl,
              ),
              backgroundColor: Colors.grey,
            ),
          ),
          SizedBox(height: 32.0),
          Text(
            "My ${userDetails[_currentDetailIndex].text} is",
            style: TextStyle(
              fontSize: 18.0,
              color: Colors.grey,
            ),
          ),
          SizedBox(height: 8.0),
          Expanded(
            child: Text(
              userDetails[_currentDetailIndex].value,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 24.0,
                color: Colors.black,
              ),
            ),
          ),
          SizedBox(height: 24.0),
          _buildUserDetailIconList(),
          SizedBox(height: 16.0)
        ],
      ),
    );
  }

  Widget _buildUserDetailIconList() {
    List<Widget> detailIconWidgets = [];

    for (int index = 0; index < userDetails.length; index++) {
      UserDetail userDetail = userDetails[index];
      detailIconWidgets.add(_UserDetailIcon(
        iconData: userDetail.iconData,
        isSelected: index == _currentDetailIndex,
        onTap: () {
          setState(() {
            _currentDetailIndex = index;
          });
        },
      ));
    }

    return Row(
      children: detailIconWidgets,
    );
  }
}

class _UserDetailIcon extends StatelessWidget {
  final IconData iconData;
  final bool isSelected;
  final VoidCallback onTap;

  _UserDetailIcon({this.iconData, this.isSelected = false, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: InkWell(
        onTap: onTap,
        child: Column(
          children: <Widget>[
            SizedBox(
              width: double.infinity,
              height: 12.0,
              child: CustomPaint(
                painter: _SelectIndicatorPainter(
                  isSelected ? Colors.green : Colors.transparent,
                ),
              ),
            ),
            SizedBox(height: 16.0),
            Icon(
              iconData,
              color: isSelected ? Colors.green : Colors.grey,
            ),
            SizedBox(height: 8.0),
          ],
        ),
      ),
    );
  }
}

class _SelectIndicatorPainter extends CustomPainter {
  final Color color;
  Paint _paint;

  _SelectIndicatorPainter(this.color) {
    _paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final triangleSize = 5;
    final bottomSize = size.height - 3;

    Path path = new Path();
    path.moveTo(0, bottomSize);
    path.lineTo(size.width / 2.0 - triangleSize, bottomSize);
    path.lineTo(size.width / 2.0, 0);
    path.lineTo(size.width / 2.0 + triangleSize, bottomSize);
    path.lineTo(size.width, bottomSize);
    path.lineTo(size.width, size.height);
    path.lineTo(0, size.height);
    path.close();

    canvas.drawPath(path, _paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return true;
  }
}
