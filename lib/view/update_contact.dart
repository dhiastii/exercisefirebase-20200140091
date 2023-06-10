import 'package:materi3pam/controller/contact_controller.dart';
import 'package:materi3pam/model/contact_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class UpdateContact extends StatefulWidget {
  UpdateContact({super.key});

  @override
  State<UpdateContact> createState() => _UpdateContactState();
}

class _UpdateContactState extends State<UpdateContact> {
  var contactController = ContactController();
  final _formKey = GlobalKey<FormState>();
  String? name;
  String? phone;
  String? email;
  String? address;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Update Contact'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Name',
                ),
                onChanged: (value) => name = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Phone',
                ),
                onChanged: (value) => phone = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Email',
                ),
                onChanged: (value) => email = value,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Address',
                ),
                onChanged: (value) => address = value,
              ),
              ElevatedButton(
                onPressed: () {
                  ContactModel cm = ContactModel(
                    name: name!, //dari variabel di def. diatas
                    phone: phone!,
                    email: email!,
                    address: address!,
                  );
                  contactController.editContact(cm);
                },
                child: const Text('Update Contact'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
