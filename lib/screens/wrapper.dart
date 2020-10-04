import 'package:flutter/material.dart';
import 'package:shopping_list/screens/load_userSettings.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/user.dart';
import 'package:shopping_list/screens/authenticate/authenticate.dart';
import 'package:shopping_list/shared/loading.dart';

class Wrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final user = Provider.of<MyUser>(context);

    if (user != null) {
      if (user.tryLogin == false) {
        return Loading();
      }
    }

    if (user == null) {
      return Authenticate();
    } else {
      return LoadUserSettings();
    }
  }
}
