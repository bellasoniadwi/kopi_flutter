import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:kopi_flutter/Kopi_Page.dart';
import 'package:kopi_flutter/auth/constants.dart';
import 'package:flutter/material.dart';
import 'package:kopi_flutter/auth/signin_screen.dart';
import 'package:kopi_flutter/data/user_data.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController _nameTextController = TextEditingController();
  TextEditingController _passwordTextController = TextEditingController();
  TextEditingController _emailTextController = TextEditingController();
  bool _isPasswordVisible = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackgroundColor,
      body: SingleChildScrollView(
        child: Column(
          children: <Widget>[
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
                        "Sign Up",
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
                    padding: const EdgeInsets.only(bottom: 30),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: Icon(
                            Icons.person,
                            color: kPrimaryColor,
                          ),
                        ),
                        Expanded(
                            child: TextField(
                                controller: _nameTextController,
                                cursorColor: Colors.white,
                                style: TextStyle(color: kBackgroundColor),
                                decoration: InputDecoration(
                                  labelText: 'Nama',
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
                  Padding(
                    padding: const EdgeInsets.only(bottom: 30),
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
                                keyboardType: TextInputType.emailAddress,
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
                              obscureText: !_isPasswordVisible,
                              keyboardType: TextInputType.visiblePassword,
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
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _isPasswordVisible =
                                          !_isPasswordVisible; // Toggle password visibility
                                    });
                                  },
                                  child: Icon(
                                    _isPasswordVisible
                                        ? Icons.visibility_off
                                        : Icons.visibility,
                                    color: Colors.black,
                                  ),
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
                                return SignInScreen();
                              }));
                            },
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.arrow_back,
                                  color: Colors.black,
                                ),
                                SizedBox(width: 10),
                                Text("Sign In",
                                    style: TextStyle(color: Colors.black)),
                              ],
                            ),
                          ),
                        ),
                        Spacer(),
                        InkWell(
                          onTap: () async {
                            if (_emailTextController.text.isEmpty ||
                                _passwordTextController.text.isEmpty || _nameTextController.text.isEmpty) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Nama, email, dan password harus diisi")));
                              return;
                            }

                            if (!_emailTextController.text.contains('@') ||
                                !_emailTextController.text.contains('.')) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("Email tidak valid")),
                              );
                              return;
                            }

                            if (_passwordTextController.text.length < 8) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content: Text(
                                          "Password minimal harus 8 karakter")));
                              return;
                            }

                            try {
                              await FirebaseAuth.instance
                                  .createUserWithEmailAndPassword(
                                email: _emailTextController.text,
                                password: _passwordTextController.text,
                              );

                              saveUserDataToFirestore(_nameTextController.text,
                                  _emailTextController.text);
                              print("Membuat akun baru");

                              Provider.of<UserData>(context, listen: false)
                                  .updateUserData(_nameTextController.text,
                                      _emailTextController.text);

                              final SharedPreferences prefs =
                                  await SharedPreferences.getInstance();
                              prefs.setBool('isLoggedIn', true);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => KopiPage()),
                              );
                            } catch (error) {
                              String errorMessage = error.toString();
                              if (error is FirebaseAuthException) {
                                if (error.code == 'email-already-in-use') {
                                  errorMessage = "Email sudah terdaftar";
                                }
                              }
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text(errorMessage)),
                              );
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

  void saveUserDataToFirestore(String name, String email) {
    FirebaseFirestore firestore = FirebaseFirestore.instance;

    String? uid = FirebaseAuth.instance.currentUser?.uid;

    if (uid != null) {
      firestore
          .collection("users")
          .doc(uid)
          .set({"name": name, "email": email, "role": "Petani"}).then((value) {
        print("Data tersimpan di firestore");
      }).catchError((error) {
        print("Data gagal disimpan: $error");
      });
    }
  }
}
