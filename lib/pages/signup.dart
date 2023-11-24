import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatelessWidget {
  const SignUp({super.key});

  @override
  Widget build(BuildContext context) {
    final auth = FirebaseAuth.instance;
    TextEditingController email = TextEditingController();
    TextEditingController password = TextEditingController();
    TextEditingController passwordConfirm = TextEditingController();

    return Scaffold(
      body: ListView(
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
                        height: 300,
                      ),
                      Text(
                        'Pilih mobil pilihanmu\ndengan lepas kunci',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade600),
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
                        height: 300,
                      ),
                      Text(
                        'Berkendara nyaman\ndengan mobil yang bersih',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade600),
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
                        height: 300,
                      ),
                      Text(
                        'Cari mobil pilihan\ndengan lokasi terdekat',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 20, color: Colors.grey.shade600),
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
            height: MediaQuery.of(context).size.height * 0.6,
            padding: EdgeInsets.only(left: 20, right: 20, top: 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
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
                TextField(
                  controller: passwordConfirm,
                  decoration: InputDecoration(
                      labelText: 'Password Confirm',
                      border: OutlineInputBorder()),
                ),
                Align(
                    alignment: Alignment.center,
                    child: ElevatedButton(
                        onPressed: () async {
                          try {
                            await auth.createUserWithEmailAndPassword(
                                email: email.text, password: password.text);

                            AwesomeDialog(
                              context: context,
                              animType: AnimType.scale,
                              dialogType: DialogType.success,
                              title: 'Data disimpan\nsilahkan Sign In',
                              btnCancelOnPress: () {},
                              btnOkOnPress: () {
                                Navigator.pop(context);
                              },
                            ).show();
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                              content: Text(e.toString()),
                              backgroundColor: Colors.orange.shade400,
                            ));
                          }
                        },
                        child: Text('Sign Up'))),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Sudah mendaftar ? '),
                    TextButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        child: Text('Sign In'))
                  ],
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
