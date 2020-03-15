import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ViewPage extends StatelessWidget {
  Widget _buildCoverImage(Size screenSize) {
    return Container(
      height: screenSize.height / 2,
      decoration: BoxDecoration(
          image: DecorationImage(
        image: AssetImage('lib/images/unnamed.jpg'),
        fit: BoxFit.cover,
      )),
    );
  }

  Widget _buildProfileImage() {
    return Center(
      child: Container(
        height: 140,
        width: 140,
        decoration: BoxDecoration(
            image: DecorationImage(
              image: AssetImage('lib/images/unnamed.jpg'),
              fit: BoxFit.cover,
            ),
            borderRadius: BorderRadius.circular(80.0),
            border: Border.all(color: Colors.white, width: 8)),
      ),
    );
  }

  Widget _buildStatus() {
    return Card(
      elevation: 7,
      margin: EdgeInsets.only(left: 20, top: 50, right: 20),
      child: Container(
        height: 250,
        width: 400,
        padding: EdgeInsets.only(top: 120, left: 5),
        child: Column(
          children: <Widget>[
            Text("My address is"),
            Text(
              "4661 Auburn Ave",
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  IconButton(
                    icon: Icon(
                      Icons.email,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.date_range,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.map,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.call,
                      size: 40,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.enhanced_encryption,
                      size: 40,
                    ),
                  ),
                ])
          ],
        ),
      ),
    );
  }

  Widget _bulidBackground(Size screenSize) {
    return Container(
      margin: new EdgeInsets.only(top: 190.0),
      height: screenSize.height,
      decoration: new BoxDecoration(
        gradient: new LinearGradient(
          colors: <Color>[new Color(0x00736AB7), new Color(0xFF736AB7)],
          stops: [0.0, 0.9],
          begin: const FractionalOffset(0.0, 0.0),
          end: const FractionalOffset(0.0, 1.0),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: <Widget>[
          _buildCoverImage(screenSize),
          _bulidBackground(screenSize),
          SafeArea(
              child: SingleChildScrollView(
            child: Column(children: <Widget>[
              SizedBox(
                height: screenSize.height / 4.6,
              ),
              Stack(children: <Widget>[
                _buildStatus(),
                _buildProfileImage(),
              ]),
            ]),
          ))
        ],
      ),
    );
  }
}
