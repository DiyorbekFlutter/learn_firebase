import 'package:cloud_firestore/cloud_firestore.dart';

class CFSService{

  static final FirebaseFirestore db = FirebaseFirestore.instance;

  /// create
  static Future<DocumentReference<Map<String, dynamic>>>createCollection({required String collectionPath, required Map<String, dynamic>data})async{
    var result = await db.collection(collectionPath).add(data);
    return result;
  }

  /// read
  static Future<List<QueryDocumentSnapshot<Object?>>>read({required String collectionPath})async{
    List<QueryDocumentSnapshot> itemList = [];
    QuerySnapshot querySnapshot = await db.collection(collectionPath).get();
    for (var element in querySnapshot.docs) {
      itemList.add(element);
    }
    return itemList;
  }


  /// update
  static Future<void>update({required String collectionPath, required String id, required Map<String, dynamic>data})async{
    await db.collection(collectionPath).doc(id).update(data);
  }


  /// delete
  static Future<void>delete({required String collectionPath, required String id})async{
    await db.collection(collectionPath).doc(id).delete();
  }


}


// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// class CFSService{
//   static final CollectionReference usersCollection = FirebaseFirestore.instance.collection('users');
//   static final FirebaseFirestore db = FirebaseFirestore.instance;
//
//   static Future<bool> saveUserData(String path, Map<String, dynamic> body) async {
//     try{
//       await usersCollection.doc(FirebaseAuth.instance.currentUser?.uid.toString()).set(body);
//       return true;
//     } catch(e){
//       return false;
//     }
//   }
//
//   static Future<Map<String, dynamic>?> getUserData(String path) async {
//     try{
//       DocumentSnapshot userSnapshot = await usersCollection.doc(path).get();
//       if(userSnapshot.exists){
//         Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
//         return data;
//       }
//       return null;
//     } catch(e){
//       return null;
//     }
//   }
//
//
//   static Future<DocumentReference<Map<String, dynamic>>> createCollection(String collectionPath, Map<String, dynamic> data) async {
//     DocumentReference<Map<String, dynamic>> documentReference = await db.collection(collectionPath).add(data);
//     return documentReference;
//   }
//
//   static Future<List<QueryDocumentSnapshot<Map<String, dynamic>>>> readAllData({required String collectionPath}) async {
//     List<QueryDocumentSnapshot<Map<String, dynamic>>> documents = [];
//     await db.collection(collectionPath).get().then((value) {
//       for(var doc in value.docs){
//         documents.add(doc);
//       }
//     });
//     return documents;
//   }
//
//   static Future<void> delete({required String collectionPath, required String id}) async {
//     await db.collection(collectionPath).doc(id).delete();
//   }
//
//   static Future<void> update({required String collectionPath, required String id, required Map<String, dynamic> data}) async {
//     await db.collection(collectionPath).doc(id).update(data);
//   }
// }
