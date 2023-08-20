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
  static var fireStorage = myServices.fireStorage;

  static Future<(response_dart.CustomResponse, String)> addData({
    required String collectionName,
    required Map<String, dynamic> data,
    String? path,
    String? subCollection,
  }) async {
    CollectionReference collectionReference =
        firestore.collection(collectionName);

    DocumentReference documentReferencer = subCollection == null
        ? collectionReference.doc(path)
        : collectionReference.doc(path).collection(subCollection).doc();
    await documentReferencer.set(data).whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";

      documentReferencer.update({'id': documentReferencer.id});
    }).catchError((e) {
      myResponse.code = 500;
      myResponse.message = e.toString();
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
    String? subCollection,
    String? subDocument,
    String? orderBy,
    bool? ascending,
  }) async {
    CollectionReference collectionReference = subCollection == null
        ? firestore.collection(collectionName)
        : firestore
            .collection(collectionName)
            .doc(subDocument)
            .collection(subCollection);
    QuerySnapshot query;
    if (orderBy != null) {
      query = await collectionReference
          .orderBy(orderBy, descending: ascending ?? false)
          .get()
          .whenComplete(() {
        myResponse.code = 200;
        myResponse.message = "success";
      });
    } else {
      query = await collectionReference.get().whenComplete(() {
        myResponse.code = 200;
        myResponse.message = "success";
      });
    }

    if (query.docs.isEmpty) {
      myResponse.code = 500;
      myResponse.message = "empty";
    }
    return (query.docs, myResponse);
  }

  static Future<
          (List<QueryDocumentSnapshot<Object?>>, response_dart.CustomResponse)>
      getQueryData({
    required String collectionName,
    String? orderBy,
    bool? ascending,
    required String field,
    required String condition,
  }) async {
    CollectionReference collectionReference =
        firestore.collection(collectionName);
    QuerySnapshot query;
    if (orderBy != null) {
      query = await collectionReference
          .orderBy(orderBy, descending: ascending ?? false)
          .where(field, isEqualTo: condition)
          .get()
          .whenComplete(() {
        myResponse.code = 200;
        myResponse.message = "success";
      });
    } else {
      query = await collectionReference
          .where(field, isEqualTo: condition)
          .get()
          .whenComplete(() {
        myResponse.code = 200;
        myResponse.message = "success";
      });
    }

    if (query.docs.isEmpty) {
      myResponse.code = 500;
      myResponse.message = "empty";
    }
    return (query.docs, myResponse);
  }

  static Future<response_dart.CustomResponse> updateData({
    required String collectionName,
    required String docId,
    String? subCollectionName,
    String? subCollectionId,
    required Map<String, dynamic> data,
  }) async {
    CollectionReference collectionReference =
        firestore.collection(collectionName);
    DocumentReference documentReferencer = subCollectionName == null
        ? collectionReference.doc(docId)
        : collectionReference
            .doc(docId)
            .collection(subCollectionName)
            .doc(subCollectionId);

    await documentReferencer.update(data).whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";
    }).catchError((e) {
      myResponse.code = 500;
      myResponse.message = e.toString();
    });
    return myResponse;
  }

  static Future<response_dart.CustomResponse> deleteData({
    required String collectionName,
    required String docId,
  }) async {
    CollectionReference collectionReference =
        firestore.collection(collectionName);
    DocumentReference documentReferencer = collectionReference.doc(docId);

    await documentReferencer.delete().whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";
    }).catchError((e) {
      myResponse.code = 500;
      myResponse.message = e.toString();
    });
    return myResponse;
  }

  static Future<response_dart.CustomResponse> deleteFile({
    required String collectionName,
    required String docId,
  }) async {
    Reference ref =
        fireStorage.ref().child(collectionName).child(docId).child(docId);

    await ref.delete().whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";
    }).catchError((e) {
      myResponse.code = 500;
      myResponse.message = e.toString();
    });
    return myResponse;
  }

  static Future<(String, response_dart.CustomResponse)> uploadFile({
    required File file,
    required String childName,
    required String id,
    required String nameId,
  }) async {
    String downloadURL;
    Reference ref = fireStorage.ref().child(childName).child(id).child(nameId);
    await ref.putFile(file).whenComplete(() {
      myResponse.code = 200;
      myResponse.message = "success";
    });
    downloadURL = await ref.getDownloadURL();

    return (downloadURL, myResponse);
  }
}
