import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:get/get.dart';

import '../services/services.dart';
import 'custom_response.dart' as response_dart;

MyServices myServices = Get.find();

class CRUDFirebase {
  static response_dart.CustomResponse myResponse =
      response_dart.CustomResponse();

  static var firestore = myServices.firestore;

  static Future<(response_dart.CustomResponse, String)> addData({
    required String collectionName,
    required Map<String, dynamic> data,
    String? path,
  }) async {
    CollectionReference collectionReference =
        firestore.collection(collectionName);

    DocumentReference documentReferencer = collectionReference.doc(path);
    await documentReferencer.set(data).whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";
      updateData(
          collectionName: collectionName,
          docId: documentReferencer.id,
          data: {'id': documentReferencer.id});
    }).catchError((e) {
      myResponse.code = 500;
      myResponse.message = e;
    });
    print(documentReferencer.id);
    return (myResponse, documentReferencer.id);
  }

  static Stream<QuerySnapshot> readData({required String collectionName}) {
    CollectionReference notesItemCollection =
        firestore.collection(collectionName);

    return notesItemCollection.snapshots();
  }

  static Future<
          (List<QueryDocumentSnapshot<Object?>>, response_dart.CustomResponse)>
      getData({
    required String collectionName,
  }) async {
    CollectionReference collectionReference =
        firestore.collection(collectionName);
    QuerySnapshot query = await collectionReference.get().whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";
    });
    if (query.docs.isEmpty) {
      myResponse.code = 500;
      myResponse.message = "empty";
    }
    return (query.docs, myResponse);
  }

  static Future<response_dart.CustomResponse> updateData({
    required String collectionName,
    required String docId,
    required Map<String, dynamic> data,
  }) async {
    // Response response = Response();
    CollectionReference collectionReference =
        firestore.collection(collectionName);
    DocumentReference documentReferencer = collectionReference.doc(docId);

    await documentReferencer.update(data).whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";
    });
    return myResponse;
  }

  static Future<response_dart.CustomResponse> deleteData({
    required String collectionName,
    required String docId,
  }) async {
    // Response response = Response();
    CollectionReference collectionReference =
        firestore.collection(collectionName);
    DocumentReference documentReferencer = collectionReference.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";
    }).catchError((e) {
      myResponse.code = 500;
      myResponse.message = e;
    });
    return myResponse;
  }

  static Future<(String, response_dart.CustomResponse)> uploadFile({
    required File file,
    required String childName,
  }) async {
    String downloadURL;
    Reference ref = myServices.firestorage
        .ref()
        .child(childName)
        .child(myServices.user.uid);
    await ref.putFile(file).whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";
    });
    downloadURL = await ref.getDownloadURL();

    return (downloadURL, myResponse);
  }
}
