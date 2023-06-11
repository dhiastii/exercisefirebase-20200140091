import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:materi3pam/model/contact_model.dart';
import 'package:materi3pam/view/update_contact.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contacts');

  final StreamController<List<DocumentSnapshot>> streamController =
      StreamController<List<DocumentSnapshot>>.broadcast();

  Stream<List<DocumentSnapshot>> get stream => streamController.stream;

  //add contact
  Future addContact(ContactModel ctmodel) async {
    //convert ContactModel ke map buat dihandle firestore sebagai json type
    final contact = ctmodel.toMap();
    //add contact ke collection dan get document reference
    final DocumentReference docRef = await contactCollection.add(contact);
    //get document id buat contact yang baru ditambah
    final String docId = docRef.id;
    //create new ContactModel pakai document id
    final ContactModel contactModel = ContactModel(
        id: docId,
        name: ctmodel.name,
        phone: ctmodel.phone,
        email: ctmodel.email,
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
