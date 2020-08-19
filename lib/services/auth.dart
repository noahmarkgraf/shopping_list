import 'package:firebase_auth/firebase_auth.dart';



class AuthService {

  final FirebaseAuth _auth = FirebaseAuth.instance;

  //sign in anon
  
  Future signInAnon() async {
    try {
      //AuthResult == UnserCredential
      UserCredential result = await _auth.signInAnonymously();
      //UserCredential result = await _auth.createUserWithEmailAndPassword(email: null, password: null);
      //FirebaseUser == User
      User user = result.user;
      return user;
    } catch(e) {
      print('Fehlermerldung${e.toString()}');
      return null;
    }
  }
  
  //sign in with email and password

  //register with email and password

  //sign out

}