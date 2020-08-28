import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/purchase_done.dart';
import 'package:shopping_list/models/user_settings.dart';
import 'package:shopping_list/services/database.dart';


class PurchaseDoneTile extends StatelessWidget {

  final PurchaseDone purchaseDone;

  PurchaseDoneTile({ this.purchaseDone });

  @override
  Widget build(BuildContext context) {

    UserSettings userSettings = Provider.of<UserSettings>(context);

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: IconButton(
            onPressed: () async {
              await DatabaseService(uid: userSettings.uid).closePurchaseDone(purchaseDone);
            },
            icon: Icon(Icons.check_box),
          ),
          title: Text(purchaseDone.name, style: TextStyle(fontSize: 17),),
          subtitle: Text('von ${purchaseDone.userName}\n${purchaseDone.date}'),
          isThreeLine: true,
          trailing: IconButton(
            onPressed: (){
              DatabaseService(uid: userSettings.uid).deletePurchaseDone(purchaseDone.id);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ),
    );
  }
}