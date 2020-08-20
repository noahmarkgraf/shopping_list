import 'package:flutter/material.dart';
import 'package:shopping_list/screens/home/settings.dart';
import 'package:shopping_list/services/auth.dart';

class Home extends StatelessWidget {

  final AuthService _auth = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.brown[50],
      appBar: AppBar(
        title: Text('Einkaufsliste'),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          FlatButton.icon(
            icon: Icon(Icons.person),
            label: Text('logout'),
            onPressed: () async {
              await _auth.signOut();
            },
          ),
          FlatButton.icon(
            label: Text(''),
            icon: Icon(Icons.settings),
            onPressed: (){
              Navigator.push(context, MaterialPageRoute(
                builder: (context) => Settings()
              ));
            },
          ),
        ],
      ),
    );
  }
}