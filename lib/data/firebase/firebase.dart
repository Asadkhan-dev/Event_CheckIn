import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:event_manager/data/model/event_model.dart';
import 'package:get/get.dart';

class FirebaseHelper {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Create a new document in Firestore
  Future<bool> createDocument(String collection, String id, EventModel data) async {
      // Check if the document already exists
      DocumentSnapshot docSnapshot = await _firestore.collection(collection).doc(id).get();
      if (docSnapshot.exists) {
       return true;
      } else {
        // If the document does not exist, create it
        await _firestore.collection(collection).doc(id).set(data.toMap());
        return false;
          }
  }

  // Read a document from Firestore
  Future<DocumentSnapshot?> readDocument(String collection, String docId) async {
    try {
      return await _firestore.collection(collection).doc(docId).get();
    } catch (e) {
      Get.snackbar('Error', 'Failed to read document: $e');
      return null;
    }
  }

  // Update a document in Firestore
  Future<void> updateDocument(String collection, String docId, Map<String, dynamic> data) async {
    try {
      await _firestore.collection(collection).doc(docId).update(data);
    } catch (e) {
      Get.snackbar('Error', 'Failed to update document: $e');
    }
  }

  // Delete a document from Firestore
  Future<void> deleteDocument(String collection, String docId) async {
    try {
      await _firestore.collection(collection).doc(docId).delete();
    } catch (e) {
      Get.snackbar('Error', 'Failed to delete document: $e');
    }
  }

  // Check if a document exists in Firestore
  Future<bool> checkDocumentExists(String collection, String docId) async {
    try {
      final doc = await _firestore.collection(collection).doc(docId).get();
      return doc.exists;
    } catch (e) {
      Get.snackbar('Error', 'Failed to check document existence: $e');
      return false;
    }
  }

  // Get a list of documents from Firestore
  Future<QuerySnapshot?> getDocuments(String collection) async {
    try {
      return await _firestore.collection(collection).get();
    } catch (e) {
      Get.snackbar('Error', 'Failed to get documents: $e');
      return null;
    }
  }

  // Get a list of documents from Firestore with a specific condition
  Future<QuerySnapshot?> getDocumentsWithCondition(
      String collection,
      String field,
      dynamic value,
      ) async {
    try {
      return await _firestore
          .collection(collection)
          .where(field, isEqualTo: value)
          .get();
    } catch (e) {
      Get.snackbar('Error', 'Failed to get documents with condition: $e');
      return null;
    }
  }
}