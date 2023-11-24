import 'package:carent/pages/admin_on_rental.dart';
import 'package:carent/pages/admin_pengajuan_sewa.dart';
import 'package:carent/pages/admin_profile.dart';
import 'package:carent/pages/componen/kategori.dart';
import 'package:flutter/material.dart';

class AdminHome extends StatelessWidget {
  const AdminHome({super.key});

  @override
  Widget build(BuildContext context) {
    print('Open Admin Home');
    return Scaffold(
        body: SafeArea(
            child: SizedBox(
          height: double.maxFinite,
          width: double.maxFinite,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Dashboard Admin',
                style: TextStyle(fontSize: 30),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  KategoriItem(
                      icon: 'assets/img/file.png',
                      title: 'Pengajuan\nSewa',
                      route: AdminPengajuanSewa()),
                  KategoriItem(
                      icon: 'assets/img/gas-pump.png',
                      title: 'On\nRental',
                      route: AdminOnRental()),
                ],
              )
            ],
          ),
        )),
        bottomNavigationBar: Container(
          padding: EdgeInsets.only(left: 30, right: 30, bottom: 10, top: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Icon(
                Icons.home,
                size: 50,
                color: Colors.blue,
              ),
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => AdminProfile(),
                        ));
                  },
                  icon: Icon(Icons.person_2_rounded,
                      size: 50, color: Colors.blue.shade200))
            ],
          ),
        ));
  }
}
