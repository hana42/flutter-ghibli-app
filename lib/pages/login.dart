import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:ghibli/pages/password_recovery_page.dart';
import 'package:ghibli/utils/utils.dart';

class LoginWidget extends StatefulWidget {
  final VoidCallback onClickedSignUp;
  const LoginWidget({Key? key, required this.onClickedSignUp})
      : super(key: key);

  @override
  State<LoginWidget> createState() => _LoginWidgetState();
}

class _LoginWidgetState extends State<LoginWidget> {
  final formKey = GlobalKey<FormState>();
  final scaffoldKey = GlobalKey<ScaffoldMessengerState>();
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
                        bottom: Radius.circular(18),
                      )),
                  child: Column(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(color: Colors.black, fontSize: 20),
                        ),
                        Text(
                          'Welcome! Please sign in to continue',
                          style: TextStyle(color: Colors.black),
                        ),
                        Row(
                          children: [
                            Text(
                              'Don\'t have an account?',
                              style: TextStyle(color: Colors.black),
                            ),
                            TextButton(
                                onPressed: widget.onClickedSignUp,
                                child: Text('Register')),
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
                        Align(
                          alignment: Alignment.centerRight,
                          child: TextButton(
                              onPressed: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => PasswordRecoveryPage(),
                                    ),
                                  ),
                              child: Text('Forgot Password?')),
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
                                        Color.fromARGB(255, 151, 202, 223))),
                            onPressed: () async {
                              try {
                                await _auth.signInWithEmailAndPassword(
                                    email: emailController.text.trim(),
                                    password: passwordController.text.trim());
                              } on FirebaseAuthException catch (e) {
                                Utils.showSnackBar(e.message);
                              }
                            },
                            child: Text(
                              'Sign In',
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
