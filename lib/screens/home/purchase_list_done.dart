import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shopping_list/models/purchase.dart';
import 'package:shopping_list/models/purchase_done.dart';
import 'package:shopping_list/models/user_settings.dart';
import 'package:shopping_list/screens/home/puchase_tile_done.dart';
import 'package:shopping_list/services/database.dart';

class PurchaseListDone extends StatefulWidget {
  @override
  _PurchaseListDoneState createState() => _PurchaseListDoneState();
}

class _PurchaseListDoneState extends State<PurchaseListDone> {
  @override
  Widget build(BuildContext context) {


    UserSettings userSettings = Provider.of<UserSettings>(context);
    final purchasesDone = Provider.of<List<PurchaseDone>>(context) ?? [];

    final _formKey = GlobalKey<FormState>();


    String inputName;


    return Scaffold(
      body: ListView.builder(
        itemCount: purchasesDone.length,
        itemBuilder: (context, index) {
          return PurchaseDoneTile(purchaseDone: purchasesDone[index]);
        },
      ),
    );
  }
}