import 'package:flutter/material.dart';
import 'package:materi3pam/controller/contact_controller.dart';
import 'package:materi3pam/model/contact_model.dart';
import 'package:materi3pam/view/contact.dart';

class UpdateContact extends StatefulWidget {
  const UpdateContact({
    Key? key,
    this.id,
    this.name,
    this.phone,
    this.email,
    this.address,
  }) : super(key: key);

  final String? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? address;

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var contactController = ContactController();

  final formkey = GlobalKey<FormState>();

  //final List<DocumentSnapshot> data = snapshot.data!;

  String? newname;
  String? newphone;
  String? newemail;
  String? newaddress;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(10),
        child: Form(
          key: formkey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(hintText: 'Name'),
                onSaved: (value) {
                  newname = value;
                },
                initialValue: widget.name,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Phone'),
                onSaved: (value) {
                  newphone = value;
                },
                initialValue: widget.phone,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Email'),
                onSaved: (value) {
                  newemail = value;
                },
                initialValue: widget.email,
              ),
              TextFormField(
                decoration: const InputDecoration(hintText: 'Address'),
                onSaved: (value) {
                  newaddress = value;
                },
                initialValue: widget.address,
              ),
              ElevatedButton(
                onPressed: () {
                  if (formkey.currentState!.validate()) {
                    formkey.currentState!.save();
                    ContactModel cm = ContactModel(
                        id: widget.id,
                        name: newname!.toString(),
                        phone: newphone!.toString(),
                        email: newemail!.toString(),
                        address: newaddress!.toString());
                    contactController.updateContact(cm);
                    ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Contact Changed')));

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const Contact(),
                      ),
                    );
                  }
                  //print(cm);
                },
                child: const Text('Edit Contact'),
              )
            ],
          ),
        ),
      ),
    );
  }
}
