import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/models/purchase.dart';
import 'package:shopping_list/models/purchase_done.dart';
import 'package:shopping_list/models/user_settings.dart';

class DatabaseService {

  final String uid;
  DatabaseService({ this.uid });

  //collection reference userSettings
  final CollectionReference userSettingsCollection = FirebaseFirestore.instance.collection('userSettings');


  //UserSetting update
  Future updateUserSettings(UserSettings userSettings) async {
    if(userSettings == null){
      userSettings = UserSettings();
    } 
    return await userSettingsCollection.doc(uid).set({
      'name': userSettings.name,
      'uid': userSettings.uid,
    });
  }


  //UserSettings read
  Future readUserSettings() async {
    DocumentSnapshot result = await userSettingsCollection.doc(uid).get();
    Map<String, dynamic> data = result.data();
    UserSettings user = UserSettings();
    user.name = data['name'];
    user.uid = data['uid'];
    return user;
  }


  //colllection reference purchaseCollection
  final CollectionReference purchaseCollection = FirebaseFirestore.instance.collection('purchases');


  //purchasesUpdate
  Future purchasesUpdate(Purchase purchase) async {
    if(purchase == null){
      purchase = Purchase();
    } 
    return await purchaseCollection.doc().set({
      'name': purchase.name,
      'userName': purchase.userName,
      'date': purchase.date,
    });
  }


  //purchase list 
  List<Purchase> _purchaseListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      Map<String, dynamic> data = doc.data();
      return Purchase(
        name: data['name'],
        userName: data['userName'],
        date: data['date'],
        id: doc.id,
      );
    }).toList();
  }


  //get purchase stream
  Stream<List<Purchase>> get purchases {
    return purchaseCollection.snapshots()
      .map(_purchaseListFromSnapshot);
  }


  //delete purchase
  Future deletePurchase(docId) async {
    return await purchaseCollection.doc(docId).delete();
  }








  //colllection reference purchaseCollection
  final CollectionReference purchaseDoneCollection = FirebaseFirestore.instance.collection('purchasesDone');


  //purchasesUpdate
  Future purchasesDoneUpdate(PurchaseDone purchaseDone) async {
    if(purchaseDone == null){
      purchaseDone = PurchaseDone();
    } 
    return await purchaseDoneCollection.doc().set({
      'name': purchaseDone.name,
      'userName': purchaseDone.userName,
      'date': purchaseDone.date,
    });
  }


  //purchase list 
  List<PurchaseDone> _purchaseDoneListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc){
      Map<String, dynamic> data = doc.data();
      return PurchaseDone(
        name: data['name'],
        userName: data['userName'],
        date: data['date'],
        id: doc.id,
      );
    }).toList();
  }
  

  //get purchase stream
  Stream<List<PurchaseDone>> get purchasesDone {
    return purchaseDoneCollection.snapshots()
      .map(_purchaseDoneListFromSnapshot);
  }


  //delete purchase
  Future deletePurchaseDone(docId) async {
    return await purchaseDoneCollection.doc(docId).delete();
  }




  // push purchase to puchaseDone
  Future closePurchase(Purchase purchase) async {
    await deletePurchase(purchase.id);
    PurchaseDone purchaseDone = PurchaseDone();
    purchaseDone.name = purchase.name;
    purchaseDone.id = purchase.id;
    purchaseDone.date = purchase.date;
    purchaseDone.userName = purchase.userName;
    return await purchasesDoneUpdate(purchaseDone);
  }



  // push purchaseDone to purchase
  Future closePurchaseDone(PurchaseDone purchaseDone) async {
    await deletePurchaseDone(purchaseDone.id);
    Purchase purchase = Purchase();
    purchase.name = purchaseDone.name;
    purchase.id = purchaseDone.id;
    purchase.date = purchaseDone.date;
    purchase.userName = purchaseDone.userName;
    return await purchasesUpdate(purchase);
  }
}