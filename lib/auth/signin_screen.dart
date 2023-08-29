import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kopi_flutter/Kopi_Page.dart';
import 'package:kopi_flutter/auth/constants.dart';
import 'package:flutter/material.dart';
import 'package:kopi_flutter/auth/signup_screen.dart';
import 'package:kopi_flutter/data/user_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
            // Expanded(
            //   flex: 3,
            //   child: Container(
            //     decoration: BoxDecoration(
            //       image: DecorationImage(
            //         image: AssetImage("assets/image/hand.png"),
            //         fit: BoxFit.cover,
            //         alignment: Alignment.bottomCenter,
            //       ),
            //     ),
            //   ),
            // ),
            Container(
              height: MediaQuery.of(context).size.height * 0.3,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/image/hand.png"),
                  fit: BoxFit.cover,
                  alignment: Alignment.bottomCenter,
                ),
              ),
            ),
            Container(
              height: MediaQuery.of(context).size.height * 0.6,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                  children: <Widget>[
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Sign In",
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 60,
                              fontWeight: FontWeight.bold,
                              fontFamily: "Pacifico"),
                        ),
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 40),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(right: 16),
                            child: Icon(
                              Icons.alternate_email,
                              color: kPrimaryColor,
                            ),
                          ),
                          Expanded(
                              child: TextField(
                                  controller: _emailTextController,
                                  cursorColor: Colors.white,
                                  style: TextStyle(color: kBackgroundColor),
                                  decoration: InputDecoration(
                                    labelText: 'Email',
                                    labelStyle:
                                        TextStyle(color: kBackgroundColor),
                                    filled: true,
                                    floatingLabelBehavior:
                                        FloatingLabelBehavior.never,
                                    fillColor: kPrimaryColor,
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10.0),
                                      borderSide: const BorderSide(
                                          width: 0, style: BorderStyle.none),
                                    ),
                                  )))
                        ],
                      ),
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.lock,
                            color: kPrimaryColor,
                          ),
                        ),
                        Expanded(
                            child: TextField(
                                controller: _passwordTextController,
                                cursorColor: Colors.white,
                                style: TextStyle(color: kBackgroundColor),
                                decoration: InputDecoration(
                                  labelText: 'Password',
                                  labelStyle: TextStyle(color: kBackgroundColor),
                                  filled: true,
                                  floatingLabelBehavior:
                                      FloatingLabelBehavior.never,
                                  fillColor: kPrimaryColor,
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10.0),
                                    borderSide: const BorderSide(
                                        width: 0, style: BorderStyle.none),
                                  ),
                                )))
                      ],
                    ),
                    Spacer(),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 30),
                      child: Row(
                        children: <Widget>[
                          // SizedBox(width: 20),
                          Container(
                            margin: EdgeInsets.only(bottom: 25),
                            padding: EdgeInsets.symmetric(
                                horizontal: 26, vertical: 16),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              color: Colors.white,
                            ),
                            child: InkWell(
                              onTap: () {
                                Navigator.push(context,
                                    MaterialPageRoute(builder: (context) {
                                  return SignUpScreen();
                                }));
                              },
                              child: Row(
                                children: <Widget>[
                                  Icon(
                                    Icons.arrow_back,
                                    color: Colors.black,
                                  ),
                                  SizedBox(width: 10),
                                  Text("Sign Up",
                                      style: TextStyle(color: Colors.black)),
                                ],
                              ),
                            ),
                          ),
                          Spacer(),
                          InkWell(
                            onTap: () async {
                              try {
                                final UserCredential userCredential =
                                    await FirebaseAuth.instance
                                        .signInWithEmailAndPassword(
                                            email: _emailTextController.text,
                                            password:
                                                _passwordTextController.text);
      
                                final String uid = userCredential.user?.uid ?? '';
      
                                var userDoc = await FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(uid)
                                    .get();
                                if (userDoc.exists) {
                                  String role = userDoc.data()?['role'] ?? '';
                                  if (role == 'Petani') {
                                    Provider.of<UserData>(context, listen: false)
                                        .updateUserData(
                                            userCredential.user?.displayName ??
                                                "Guest",
                                            userCredential.user?.email ??
                                                "guest@example.com");
      
                                    // Set status login sebagai true saat pengguna berhasil login
                                    final SharedPreferences prefs =
                                        await SharedPreferences.getInstance();
                                    prefs.setBool('isLoggedIn', true);
      
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => KopiPage()));
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                'You are not allowed to log in. Please contact the admin.')));
                                  }
                                }
                              } catch (error) {
                                print("Error ${error.toString()}");
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text('Invalid Email or Password')));
                              }
                            },
                            child: Container(
                              margin: EdgeInsets.only(bottom: 25),
                              padding: EdgeInsets.symmetric(
                                  horizontal: 26, vertical: 16),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                color: Colors.white,
                              ),
                              child: Row(
                                children: <Widget>[
                                  Text("Lanjutkan",
                                      style: TextStyle(color: Colors.black)),
                                  SizedBox(width: 10),
                                  Icon(
                                    Icons.arrow_forward,
                                    color: Colors.black,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }
}
