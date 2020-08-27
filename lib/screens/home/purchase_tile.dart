import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/purchase.dart';
import 'package:shopping_list/models/user_settings.dart';
import 'package:shopping_list/services/database.dart';

class PurchaseTile extends StatelessWidget {

  final Purchase purchase;

  PurchaseTile({ this.purchase });


  @override
  Widget build(BuildContext context) {

    UserSettings userSettings = Provider.of<UserSettings>(context);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          // leading: Checkbox(),
          title: Text(purchase.name, style: TextStyle(fontSize: 17),),
          subtitle: Text('von ${purchase.userName}\n${purchase.date}'),
          isThreeLine: true,
          trailing: IconButton(
            onPressed: (){
              DatabaseService(uid: userSettings.uid).deletePurchase(purchase.id);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ),
    );
  }
}