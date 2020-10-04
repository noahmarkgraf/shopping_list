import 'package:flutter/material.dart';
import 'package:shopping_list/models/purchase.dart';
import 'package:shopping_list/models/user_settings.dart';
import 'package:shopping_list/services/database.dart';
import 'package:shopping_list/shared/datetime.dart';

class PurchaseTab extends StatefulWidget {

  final Stream purchaseListStream;
  final UserSettings userSettings;
  final String listId;
  PurchaseTab({ this.purchaseListStream, this.userSettings, this.listId });

  @override
  _PurchaseTabState createState() => _PurchaseTabState();
}

class _PurchaseTabState extends State<PurchaseTab> {

  

  @override
  Widget build(BuildContext context) {


    final _formKey = GlobalKey<FormState>();

    String inputName;


    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: widget.purchaseListStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.separated(
            separatorBuilder: (context, index) => Divider(color: Colors.black, indent: 50, endIndent: 50, height: 1,),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              Purchase purchase = Purchase();
              purchase.name = snapshot.data.docs[index].data()["name"];
              purchase.userName = snapshot.data.docs[index].data()["userName"];
              purchase.date = snapshot.data.docs[index].data()["date"];
              purchase.id = snapshot.data.docs[index].id;
              return PurchaseListTile(purchase: purchase, listId: widget.listId, userSettings: widget.userSettings);
            }
          ) : Container();
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                // title: Text('neuer Eintrag'),
                content: Form(
                  key: _formKey,
                  child: TextFormField(
                    validator: (val) => val.isEmpty ? '???' : null,
                    textCapitalization: TextCapitalization.sentences,
                    autofocus: true,
                    onChanged: (String value) {
                      inputName = value;
                    },
                  ),
                ),
                actions: [
                  IconButton(
                    padding: EdgeInsets.fromLTRB(0, 0, 30, 30),
                    onPressed: () async {
                      if(_formKey.currentState.validate()) {
                        Purchase purchase = Purchase();
                        purchase.userName = widget.userSettings.name;
                        purchase.name = inputName;
                        purchase.date = MyDateTime().convertString(DateTime.now());
                        await DatabaseServicesWOuid().addPurchasetoList(widget.listId, purchase);
                        Navigator.pop(context);
                      }
                    },
                    icon: Icon(Icons.add_circle, size: 40, color: Colors.teal[200],),
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



class PurchaseDoneTab extends StatefulWidget {

  final Stream purchaseDoneListStream;
  final String listId;
  final UserSettings userSettings;
  PurchaseDoneTab({ this.purchaseDoneListStream, this.listId, this.userSettings });

  @override
  _PurchaseDoneTabState createState() => _PurchaseDoneTabState();
}

class _PurchaseDoneTabState extends State<PurchaseDoneTab> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: widget.purchaseDoneListStream,
        builder: (context, snapshot){
          return snapshot.hasData ? ListView.separated(
            separatorBuilder: (context, index) => Divider(color: Colors.black, indent: 50, endIndent: 50, height: 1,),
            itemCount: snapshot.data.docs.length,
            itemBuilder: (context, index){
              Purchase purchase = Purchase();
              purchase.name = snapshot.data.docs[index].data()["name"];
              purchase.userName = snapshot.data.docs[index].data()["userName"];
              purchase.date = snapshot.data.docs[index].data()["date"];
              purchase.id = snapshot.data.docs[index].id;
              return PurchaseDoneListTile(purchase: purchase, listId: widget.listId, userSettings: widget.userSettings);
            }
          ) : Container();
        },
      ),
    );
  }
}


class PurchaseListTile extends StatelessWidget {

  final Purchase purchase;
  final String listId;
  final UserSettings userSettings;
  PurchaseListTile({ this.purchase, this.listId, this.userSettings });


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 0),
        child: ListTile(
          leading: IconButton(
            onPressed: () async {
              await DatabaseServicesWOuid().closePurchase(listId, purchase, userSettings.name);
            },
            icon: Icon(Icons.check_box_outline_blank),
          ),
          title: Text(purchase.name, style: TextStyle(fontSize: 17),),
          subtitle: Text('von ${purchase.userName}\n${purchase.date}'),
          isThreeLine: true,
          trailing: IconButton(
            onPressed: () {
              DatabaseServicesWOuid().deletePurchase(listId, purchase.id);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ),
    );
  }
}



class PurchaseDoneListTile extends StatelessWidget {

  final Purchase purchase;
  final String listId;
  final UserSettings userSettings;
  PurchaseDoneListTile({ this.purchase, this.listId, this.userSettings });


  @override
  Widget build(BuildContext context) {

    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Card(
        elevation: 0,
        margin: EdgeInsets.fromLTRB(20.0, 6.0, 20.0, 0),
        child: ListTile(
          leading: IconButton(
            onPressed: () async {
              await DatabaseServicesWOuid().closePurchaseDone(listId, purchase, userSettings.name);
            },
            icon: Icon(Icons.check_box),
          ),
          title: Text(purchase.name, style: TextStyle(fontSize: 17),),
          subtitle: Text('von ${purchase.userName}\n${purchase.date}'),
          isThreeLine: true,
          trailing: IconButton(
            onPressed: () {
              DatabaseServicesWOuid().deletePurchaseDone(listId, purchase.id);
            },
            icon: Icon(Icons.delete, color: Colors.red),
          ),
        ),
      ),
    );
  }
}