import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carent/pages/admin_home.dart';
import 'package:carent/pages/home.dart';
import 'package:carent/pages/signup.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'componen/varglobal.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final auth = FirebaseAuth.instance;
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          ListView(
            children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.5,
                width: double.maxFinite,
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: MediaQuery.of(context).size.height * 0.5,
                    autoPlay: true,
                    autoPlayAnimationDuration: Duration(seconds: 3),
                    disableCenter: false,
                    pauseAutoPlayInFiniteScroll: true,
                  ),
                  items: [
                    Container(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/cars.png',
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                          Text(
                            'Pilih mobil pilihanmu\ndengan lepas kunci',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, color: Colors.blue.shade600),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/car-wash.png',
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                          Text(
                            'Berkendara nyaman\ndengan mobil yang bersih',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, color: Colors.blue.shade600),
                          )
                        ],
                      ),
                    ),
                    Container(
                      width: double.maxFinite,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/img/route.png',
                            fit: BoxFit.cover,
                            height: 250,
                          ),
                          Text(
                            'Cari mobil pilihan\ndengan lokasi terdekat',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 20, color: Colors.blue.shade600),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    color: Colors.blue.shade200,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(50),
                        topRight: Radius.circular(50))),
                height: MediaQuery.of(context).size.height * 0.5,
                padding: EdgeInsets.only(left: 20, right: 20, top: 10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Sign In',
                          style: TextStyle(
                              fontSize: 25, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextField(
                      controller: email,
                      decoration: InputDecoration(
                          labelText: 'Email', border: OutlineInputBorder()),
                    ),
                    TextField(
                      controller: password,
                      decoration: InputDecoration(
                          labelText: 'Password', border: OutlineInputBorder()),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: TextButton(
                          onPressed: () async {
                            try {
                              await auth.sendPasswordResetEmail(
                                email: email.text,
                              );

                              AwesomeDialog(
                                context: context,
                                animType: AnimType.scale,
                                dialogType: DialogType.success,
                                title:
                                    'Check! Reset password send to ${email.text}',
                                btnCancelOnPress: () {},
                                btnOkOnPress: () {},
                              ).show();
                            } catch (e) {
                              ScaffoldMessenger.of(context)
                                  .showSnackBar(SnackBar(
                                content: Text(e.toString()),
                                backgroundColor: Colors.orange.shade400,
                              ));
                            }
                          },
                          child: Text('Forgot password?')),
                    ),
                    Align(
                        alignment: Alignment.center,
                        child: ElevatedButton(
                            onPressed: () async {
                              // if (email.text == 'jeremyreinhart5@gmail.com' ||
                              //     password.text == 'jeremy123') {
                              //   Utils.USER_NOW = 'jeremyreinhart5@gmail.com';
                              //   Utils.IS_ADMIN = true;
                              //   Navigator.pushAndRemoveUntil(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => AdminHome(),
                              //       ),
                              //       (route) => false);
                              // } else if (email.text ==
                              //             'zendiibrahim834@gmail.com' &&
                              //         password.text == 'zendi123' ||
                              //     email.text == 'stephenwinata34@gmail.com' &&
                              //         password.text == 'stephen123' ||
                              //     email.text == 'anton@gmail.com' &&
                              //         password.text == 'anton123' ||
                              //     email.text == 'putri@gmail.com' &&
                              //         password.text == 'putri123') {
                              //   Utils.USER_NOW = email.text;
                              //   Utils.IS_ADMIN = false;
                              //   Navigator.pushAndRemoveUntil(
                              //       context,
                              //       MaterialPageRoute(
                              //         builder: (context) => HomePage(),
                              //       ),
                              //       (route) => false);
                              // }

                              ///==== AUTH =====
                              await FirebaseAuth.instance
                                  .signInWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text);

                              try {
                                Utils.IS_ADMIN = true;

                                if (email.text == 'jeremyreinhart5@gmail.com' &&
                                    password.text == 'jeremy123') {
                                  Utils.USER_NOW = 'jeremyreinhart5@gmail.com';
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => AdminHome(),
                                      ),
                                      (route) => false);
                                } else {
                                  print('INI BUKAN JEREMY');
                                  Navigator.pushAndRemoveUntil(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => HomePage(),
                                      ),
                                      (route) => false);
                                }
                              } on FirebaseAuthException catch (e) {
                                if (e.code == 'wrong-password') {
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('Password salah'),
                                      backgroundColor: Colors.orange.shade400,
                                    ));

                                    email.clear();
                                    password.clear();
                                  });
                                } else if (e.code == 'user-not-found') {
                                  setState(() {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                      content: Text('User tidak ditemukan'),
                                      backgroundColor: Colors.orange.shade400,
                                    ));

                                    email.clear();
                                    password.clear();
                                  });
                                }
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(e.toString()),
                                  backgroundColor: Colors.orange.shade400,
                                ));
                              }
                              // Navigator.pushAndRemoveUntil(
                              //     context,
                              //     MaterialPageRoute(
                              //       builder: (context) => HomePage(),
                              //     ),
                              //     (route) => false);
                            },
                            child: Text('SignIn'))),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text('Belum mendaftar ? '),
                        TextButton(
                            onPressed: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => SignUp(),
                                  ));
                            },
                            child: Text('Sign Up'))
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
          // Positioned(
          //   top: 25,
          //   left: 10,
          //   child: CircleAvatar(
          //     radius: 35,
          //     backgroundColor: Colors.blue.shade300,
          //     child: Image.asset(
          //       'assets/img/logo.png',
          //       height: 70,
          //     ),
          //   ),
          // )
        ],
      ),
    );
  }
}
