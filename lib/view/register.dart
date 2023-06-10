import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:materi3pam/controller/auth_controller.dart';

import '../model/user_model.dart';

class Register extends StatelessWidget {
  Register({super.key});
  final form = GlobalKey<FormState>();
  final authCtr = AuthController();

  @override
  Widget build(BuildContext context) {
    String? email;
    String? name;
    String? password;
    return Scaffold(
        body: Padding(
      padding: const EdgeInsets.all(20),
      child: Form(
        child: Column(children: [
          TextFormField(
            decoration: const InputDecoration(labelText: 'Name'),
            onChanged: (value) {
              name = value;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Email'),
            onChanged: (value) {
              email = value;
            },
          ),
          TextFormField(
            decoration: const InputDecoration(labelText: 'Password'),
            onChanged: (value) {
              password = value;
            },
          ),
          const SizedBox(
            height: 20,
          ),
          ElevatedButton(
            onPressed: () async {
              if (form.currentState!.validate()) {
                UserModel? registeredUser = await authCtr
                    .registerWithEmailAndPassword(email!, name!, password!);
                if (registeredUser != null) {
                  // Registration successful
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Registration Successful'),
                        content: const Text(
                            'You have been successfully registered.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              // Navigator.push(context,
                              //     MaterialPageRoute(builder: (context) {
                              //   return Login();
                              // }));
                              // Navigate to the next screen or perform any desired action
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  // Registration failed
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: const Text('Registration Failed'),
                        content: const Text(
                            'An error occurred during registration.'),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            child: const Text('OK'),
                          ),
                        ],
                      );
                    },
                  );
                }
              }
            },
            child: const Text('Register'),
          ),
        ]),
      ),
    ));
  }
}
