import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghibli/utils/utils.dart';

class PasswordRecoveryPage extends StatefulWidget {
  const PasswordRecoveryPage({Key? key}) : super(key: key);

  @override
  State<PasswordRecoveryPage> createState() => _PasswordRecoveryPageState();
}

class _PasswordRecoveryPageState extends State<PasswordRecoveryPage> {
  final formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      appBar: AppBar(
        backgroundColor: Color.fromARGB(150, 189, 189, 189),
        elevation: 0,
        automaticallyImplyLeading: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(40),
        child: GestureDetector(
          onTap: () {},
          child: Form(
            key: formKey,
            child: Column(
              // mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  padding: EdgeInsets.only(top: 40),
                  alignment: Alignment.topCenter,
                  child: Icon(Icons.lock, size: 80, color: Colors.blue),
                ),
                SizedBox(height: 55),
                TextFormField(
                  controller: emailController,
                  textInputAction: TextInputAction.next,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (email) =>
                      email != null ? 'Enter a valid email' : null,
                  decoration: InputDecoration(
                    hintText: 'Enter your email',
                    hintStyle: const TextStyle(color: Colors.black),
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.grey, width: 1),
                    ),
                    focusedBorder: UnderlineInputBorder(
                        borderSide: const BorderSide(color: Colors.blue)),
                    errorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    focusedErrorBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.red, width: 1),
                    ),
                    fillColor: Colors.black,
                    isDense: true,
                    contentPadding: const EdgeInsets.fromLTRB(12, 16, 12, 16),
                  ),
                  cursorColor: Colors.black,
                  style: TextStyle(
                      color: Colors.black,
                      decorationColor: Colors.black,
                      fontSize: 14),
                ),
                SizedBox(height: 15),
                ElevatedButton(
                    style: ButtonStyle(
                        shape:
                            MaterialStateProperty.resolveWith<OutlinedBorder>(
                                (_) {
                          return RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20));
                        }),
                        fixedSize: MaterialStateProperty.all<Size>(
                          Size(300, 60),
                        ),
                        backgroundColor: MaterialStateProperty.all<Color>(
                            Color.fromARGB(255, 151, 202, 223))),
                    onPressed: () async {
                      final isValid = formKey.currentState!.validate();
                      if (!isValid) return;

                      try {
                        await _auth.sendPasswordResetEmail(
                          email: emailController.text.trim(),
                        );
                        Utils.showSnackBar('Password reset email sent!');
                      } on FirebaseAuthException catch (e) {
                        Utils.showSnackBar(e.message);
                      }
                    },
                    child: Text('Reset Password')),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
