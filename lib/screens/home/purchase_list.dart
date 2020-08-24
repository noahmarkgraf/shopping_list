import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/purchase.dart';
import 'package:shopping_list/models/user_settings.dart';
import 'package:shopping_list/screens/home/purchase_tile.dart';
import 'package:shopping_list/services/database.dart';


class PurchaseList extends StatefulWidget {
  @override
  _PurchaseListState createState() => _PurchaseListState();
}

class _PurchaseListState extends State<PurchaseList> {
  @override
  Widget build(BuildContext context) {

    UserSettings userSettings = Provider.of<UserSettings>(context);
    final purchases = Provider.of<List<Purchase>>(context) ?? [];


    String inputName;
    

    return Scaffold(
      body: ListView.builder(
        itemCount: purchases.length,
        itemBuilder: (context, index) {
          return PurchaseTile(purchase: purchases[index]);
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('neuer Eintrag'),
                content: TextField(
                  onChanged: (String value) {
                    inputName = value;
                  },
                ),
                actions: [
                  FlatButton(
                    onPressed: () async {
                      Purchase purchase = Purchase();
                      purchase.userName = userSettings.name;
                      purchase.name = inputName;
                      purchase.date = DateTime.now().day.toString()+'.'+DateTime.now().month.toString()+'.'+DateTime.now().year.toString()+
                        ' - '+DateTime.now().hour.toString()+':'+DateTime.now().minute.toString();
                      await DatabaseService(uid: userSettings.uid).purchasesUpdate(purchase);
                      Navigator.pop(context);
                    },
                    child: Text('hinzufügen'),
                  )
                ],
              );     
            }
          );
        },
        child: Icon(Icons.add, size: 40, color: Colors.white),
        backgroundColor: Colors.teal[200],
      ),
    );
  }
}