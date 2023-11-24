import 'package:carent/pages/signin.dart';
import 'package:flutter/material.dart';

import 'componen/varglobal.dart';

class Profile extends StatelessWidget {
  const Profile({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.maxFinite,
        height: double.maxFinite,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset('assets/img/logo.png'),
            Text(
              Utils.USER_NOW,
              style: TextStyle(fontSize: 23),
            ),
            Text(
              'User',
              style: TextStyle(fontSize: 16, color: Colors.grey),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SignIn(),
                    ),
                    (route) => false);
              },
              child: Text(
                'Log Out',
              ),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            )
          ],
        ),
      ),
    );
  }
}
