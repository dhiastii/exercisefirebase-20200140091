import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:materi3pam/model/contact_model.dart';
import 'package:materi3pam/view/update_contact.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  Future<void> addContact(ContactModel ctmodel) async {
    final contact = ctmodel.toMap();

    final DocumentReference docRef = await contactCollection.add(contact);

    final String docId = docRef.id;

    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        email: ctmodel.email,
        phone: ctmodel.phone,
        address: ctmodel.address);

    await docRef.update(contactModel.toMap());
  }

  Future<void> updateContact(ContactModel ctmodel) async {
    final ContactModel contactModel = ContactModel(
        id: ctmodel.id,
        name: ctmodel.name,
        email: ctmodel.email,
        phone: ctmodel.phone,
        address: ctmodel.address);

    await contactCollection.doc(ctmodel.id).update(contactModel.toMap());
  }

  // Future<void> updateContact(String docId, ContactModel ctmodel) async {
  //   final ContactModel contactModel = ContactModel(
  //     name: ctmodel.name,
  //     email: ctmodel.email,
  //     phone: ctmodel.phone,
  //     address: ctmodel.address,
  //     id: docId,
  //   );

  //await contactCollection.doc(ctmodel.id).update(contactModel.toMap());

  //   final DocumentSnapshot documentSnapshot =
  //       await contactCollection.doc(docId).get();
  //   if (!documentSnapshot.exists) {
  //     print('Contact with ID $docId does not exist');
  //     return;
  //   }
  //   final updatedContact = contactModel.toMap();
  //   await contactCollection.doc(docId).update(updatedContact);
  //   await getContact();
  //   print('Updated contact with ID $docId');
  // }

  Future<void> removeContact(String id) async {
    await contactCollection.doc(id).delete();
    await getContact();
  }

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.add(contact.docs);
    return contact.docs;
  }
}
