// import 'package:flutter/material.dart';
// import 'package:shopping_list/screens/wrapper.dart';

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Wrapper(),
//     );
//   }
// }

import 'package:flutter/material.dart';

// Import the firebase_core plugin
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:shopping_list/screens/wrapper.dart';

void main() {
  runApp(App());
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
          home: FutureBuilder(
        // Initialize FlutterFire
        future: Firebase.initializeApp(),
        //future: Future.delayed(Duration(seconds: 10)),
        builder: (context, snapshot) {
          // Check for errors
          if (snapshot.hasError) {
            return Center(
              child: Text('Fehler'),
            );
          }

          // Once complete, show your application
          if (snapshot.connectionState == ConnectionState.done) {
            return Center(
              child: Wrapper(),
            );
          }

          // Otherwise, show something whilst waiting for initialization to complete
          return Center(
            child: Container(
              color: Colors.blue[200],
              child: Center(
                child: SpinKitFadingCircle(
                  color: Colors.black,
                  size: 50.0,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

