import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/models/user_settings.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference
  final CollectionReference userSettingsCollection = FirebaseFirestore.instance.collection('userSettings');


  //UserSetting update
  Future updateUserSettings(UserSettings userSettings) async {
    if(userSettings == null){
      userSettings = UserSettings();
    } 
    return await userSettingsCollection.doc(uid).set({
      'name': userSettings.name,
    });
  }


  //UserSettings read
  Future readUserSettings() async {
    DocumentSnapshot result = await userSettingsCollection.doc(uid).get();
    Map<String, dynamic> data = result.data();
    UserSettings user = UserSettings();
    user.name = data['name'];
    return user;
  }

}