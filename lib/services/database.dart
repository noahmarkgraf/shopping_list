import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:shopping_list/models/purchase.dart';
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

  

}