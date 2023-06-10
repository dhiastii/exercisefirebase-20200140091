import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:materi3pam/model/contact_model.dart';
import 'package:materi3pam/view/update_contact.dart';

class ContactController {
  final contactCollection = FirebaseFirestore.instance.collection('contact');

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

  Future getContact() async {
    final contact = await contactCollection.get();
    streamController.sink.add(contact.docs);
    return contact.docs;
  }

  Future updateContact(String docId, ContactModel contactModel) async {
    final ContactModel updatedContactModel = ContactModel(
        name: contactModel.name,
        phone: contactModel.phone,
        email: contactModel.email,
        address: contactModel.address,
        id: docId);

    final DocumentSnapshot documentSnapshot =
        await contactCollection.doc(docId).get();
    if (!documentSnapshot.exists) {
      print('Contact with ID $docId does not exist');
      return;
    }
    final UpdateContact = updatedContactModel.toMap();
    await contactCollection.doc(docId).update(updatedContact);
    await getContact();
    print('Updated contact with ID : $docId');
  }

  Future deleteContact(String docId) async {
    await contactCollection.doc(docId).delete();
    await getContact();
  }
}
