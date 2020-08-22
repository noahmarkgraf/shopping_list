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
        flexibleSpace: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [Colors.tealAccent[100], Colors.pink[100]]),
          ),
        ),
        title: Text('Einkaufsliste', style: TextStyle(color: Colors.black),),
        backgroundColor: Colors.brown[400],
        elevation: 0.0,
        actions: <Widget>[
          RotatedBox(
            quarterTurns: 2,
            child: IconButton(
              color: Colors.black,
              iconSize: 32.0,
              icon: Icon(Icons.exit_to_app),
              onPressed: () async {
                await _auth.signOut();
              },
              tooltip: 'abmelden',
            ),
          ),
          // FlatButton.icon(
          //   label: Text(''),
          //   icon: Icon(Icons.settings),
          //   onPressed: (){
          //     Navigator.push(context, MaterialPageRoute(
          //       builder: (context) => Settings()
          //     ));
          //   },
          // ),
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: IconButton(
              tooltip: 'Einstellungen',
              color: Colors.black,
              iconSize: 32.0,
              icon: Icon(Icons.settings),
              onPressed: (){
                Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Settings()
                ));
              },
            ),
          ),
        ],
      ),
    );
  }
}