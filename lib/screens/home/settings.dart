import 'package:flutter/material.dart';
import 'package:shopping_list/models/user.dart';
import 'package:shopping_list/models/user_settings.dart';
import 'package:shopping_list/services/auth.dart';
import 'package:shopping_list/services/database.dart';
import 'package:shopping_list/shared/constants.dart';
import 'package:provider/provider.dart';

class Settings extends StatefulWidget {
  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  final AuthService _auth = AuthService();

  UserSettings userSettings;
  MyUser myUser;
  bool loaded = false;
  TextEditingController nameTextController = TextEditingController();

  void load() async {
    if (!loaded) {
      myUser = _auth.getCurrentUser();
      userSettings = await DatabaseService(uid: myUser.uid).readUserSettings();
      loaded = true;
      setState(() {
             nameTextController.text = userSettings.name;
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    load();

    return Scaffold(
      appBar: AppBar(
        title: Text('Einstellungen'),
        backgroundColor: Colors.brown[400],
      ),
      body: Container(
        padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 50.0),
        child: Form(
          child: Column(
            children: [
              TextFormField(
                controller: nameTextController,
                  onChanged: (val) {
                    setState(() => userSettings.name = val);
                  },
                  decoration: textInputDecoration.copyWith(
                      hintText: 'Name',
                      labelText: 'Name',
                      labelStyle: TextStyle(color: Colors.black))),
              SizedBox(height: 25.0),
              RaisedButton(
                onPressed: () async {
                  await DatabaseService(uid: myUser.uid)
                      .updateUserSettings(userSettings);
                  Navigator.pop(context);
                },
                child: Text('speichern'),
                color: Colors.brown[100],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
