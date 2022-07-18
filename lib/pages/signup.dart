import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghibli/utils/utils.dart';

class SignUpWidget extends StatefulWidget {
  final Function() onClickedSignIn;
  const SignUpWidget({Key? key, required this.onClickedSignIn})
      : super(key: key);

  @override
  State<SignUpWidget> createState() => _SignUpWidgetState();
}

class _SignUpWidgetState extends State<SignUpWidget> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        physics: BouncingScrollPhysics(),
        reverse: true,
        keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
        padding: EdgeInsets.all(4),
        child: Form(
          key: formKey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: EdgeInsets.only(top: 40),
                alignment: Alignment.topCenter,
                child: Image.asset(
                  'assets/logo/myneighbourhayao.png',
                  scale: 1,
                ),
              ),
              Container(
                  height: MediaQuery.of(context).size.height / 1.5,
                  width: MediaQuery.of(context).size.width,
                  padding: EdgeInsets.fromLTRB(40, 20, 40, 80),
                  decoration: BoxDecoration(
                      color: Color.fromARGB(255, 224, 224, 224),
                      borderRadius: BorderRadius.vertical(
                        top: Radius.circular(48),
                      )),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign Up',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Text(
                          'Welcome! Please sign up to continue',
                          style: TextStyle(color: Colors.black),
                        ),
                        Row(
                          children: [
                            Text(
                              'Already have an account?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                                onPressed: widget.onClickedSignIn,
                                child: Text('Sign In')),
                          ],
                        ),
                        TextFormField(
                          controller: emailController,
                          textInputAction: TextInputAction.next,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (email) =>
                              email != null && !Utils.validateEmail(email.trim())
                                  ? 'Enter a valid email'
                                  : null,
                          decoration: InputDecoration(
                            hintText: 'Email',
                            hintStyle: const TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue)),
                            errorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1),
                            ),
                            fillColor: Colors.black,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 16, 12, 16),
                          ),
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black,
                              decorationColor: Colors.black,
                              fontSize: 14),
                        ),
                        TextFormField(
                          controller: passwordController,
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (pass) => pass != null && pass.length < 6
                              ? 'Password must contain at least 6 characters'
                              : null,
                          decoration: InputDecoration(
                            hintText: 'Password',
                            hintStyle: const TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue)),
                            errorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1),
                            ),
                            fillColor: Colors.black,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 16, 12, 16),
                          ),
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black,
                              decorationColor: Colors.black,
                              fontSize: 14),
                        ),
                        TextFormField(
                          textInputAction: TextInputAction.done,
                          obscureText: true,
                          autovalidateMode: AutovalidateMode.onUserInteraction,
                          validator: (pass) => pass != passwordController.text
                              ? 'Password must match'
                              : null,
                          decoration: InputDecoration(
                            hintText: 'Confirm Password',
                            hintStyle: const TextStyle(color: Colors.black),
                            enabledBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.grey, width: 1),
                            ),
                            focusedBorder: UnderlineInputBorder(
                                borderSide:
                                    const BorderSide(color: Colors.blue)),
                            errorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1),
                            ),
                            focusedErrorBorder: UnderlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.red, width: 1),
                            ),
                            fillColor: Colors.black,
                            isDense: true,
                            contentPadding:
                                const EdgeInsets.fromLTRB(12, 16, 12, 16),
                          ),
                          cursorColor: Colors.black,
                          style: TextStyle(
                              color: Colors.black,
                              decorationColor: Colors.black,
                              fontSize: 14),
                        ),
                        SizedBox(
                          height: 5,
                        ),
                        ElevatedButton(
                            style: ButtonStyle(
                                shape: MaterialStateProperty.resolveWith<
                                    OutlinedBorder>((_) {
                                  return RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20));
                                }),
                                fixedSize: MaterialStateProperty.all<Size>(
                                  Size(300, 60),
                                ),
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Color.fromARGB(255, 119, 188, 245))),
                            onPressed: () async {
                              try {
                                await _auth.createUserWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                              } on FirebaseAuthException catch (e) {
                                Utils.showSnackBar(e.message);
                              }
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.black),
                            )),
                      ])),
            ],
          ),
        ),
      ),
    );
  }
}
