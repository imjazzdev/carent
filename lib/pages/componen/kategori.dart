import 'package:carent/pages/kategori_on_rental.dart';
import 'package:carent/pages/kategori_pengajuan_rental.dart';
import 'package:carent/pages/kategori_produk_mobil.dart';
import 'package:flutter/material.dart';

class Kategori extends StatelessWidget {
  const Kategori({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 140,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          KategoriItem(
              icon: 'assets/img/car.png',
              title: 'Produk\nMobil',
              route: KategoriProdukMobil()),
          KategoriItem(
              icon: 'assets/img/file.png',
              title: 'Pengajuan\nRental',
              route: KategoriPengajuanRental()),
          KategoriItem(
              icon: 'assets/img/gas-pump.png',
              title: 'On\nRental',
              route: KategoriOnRental()),
        ],
      ),
    );
  }
}

class KategoriItem extends StatelessWidget {
  const KategoriItem(
      {super.key,
      required this.icon,
      required this.title,
      required this.route});

  final String icon;
  final String title;
  final Widget route;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => route,
            ));
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            height: 90,
            width: 90,
            child: Image.asset(icon),
          ),
          Text(
            title,
            style: TextStyle(
              fontSize: 16,
            ),
            textAlign: TextAlign.center,
          )
        ],
      ),
    );
  }
}
