import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carent/pages/componen/varglobal.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'componen/item_keterangan.dart';

class Detail extends StatefulWidget {
  final String img;

  final String title;
  final String merk;
  final String harga;
  final String lokasi;
  final String informasi_detail;

  const Detail(
      {super.key,
      required this.img,
      required this.title,
      required this.merk,
      required this.harga,
      required this.lokasi,
      required this.informasi_detail});

  @override
  State<Detail> createState() => _DetailState();
}

class _DetailState extends State<Detail> {
  Future updateStatusPenyewaan() async {
    final doc =
        FirebaseFirestore.instance.collection('produk').doc(widget.title);
    doc.update(
      {
        'status_penyewaan': 'Diajukan',
      },
    );
  }

  Future addUser() async {
    final doc =
        FirebaseFirestore.instance.collection('produk').doc(widget.title);
    doc.set({
      'user': FieldValue.arrayUnion([Utils.USER_NOW])
    }, SetOptions(merge: true));
  }

  @override
  Widget build(BuildContext context) {
    print('Open User Home');
    return Scaffold(
      body: SafeArea(
          child: ListView(
        padding: EdgeInsets.all(20),
        children: [
          SizedBox(
            height: 20,
          ),
          ClipRRect(
            borderRadius: BorderRadius.circular(15),
            child: Container(
              decoration: BoxDecoration(boxShadow: [
                BoxShadow(
                    blurRadius: 10,
                    spreadRadius: 3,
                    offset: const Offset(2, 2),
                    color: Colors.blue.shade400)
              ]),
              child: CachedNetworkImage(
                imageUrl: widget.img,
                fit: BoxFit.cover,
                width: double.maxFinite,
                errorWidget: (context, url, error) => Center(
                    child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(
                      Icons.wifi,
                      size: 60,
                      color: Colors.red,
                    ),
                    Text(
                      error.toString(),
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.red),
                    ),
                  ],
                )),
                placeholder: (context, url) =>
                    const Center(child: CircularProgressIndicator()),
              ),
            ),
          ),
          SizedBox(
            height: 15,
          ),
          Text(
            widget.title,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            widget.lokasi,
            style: const TextStyle(fontSize: 18, color: Colors.blue),
          ),
          Text(
            widget.merk,
            style: const TextStyle(fontSize: 16, color: Colors.grey),
          ),
          SizedBox(
            height: 15,
          ),
          Padding(
            padding: const EdgeInsets.only(bottom: 20),
            child: Text(
              'Keterangan',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.grey.shade700),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ItemKeterangan(
                  icon: 'assets/img/license-plate.png',
                  title: 'Genap',
                  color: Colors.purple.shade100),
              ItemKeterangan(
                  icon: 'assets/img/gas-pump.png',
                  title: 'Bensin',
                  color: Colors.purple.shade100),
              ItemKeterangan(
                  icon: 'assets/img/taxes.png',
                  title: 'Aktif',
                  color: Colors.purple.shade100),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 5),
            child: Text(
              'Informasi detail',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.grey.shade700),
            ),
          ),
          Text(
            widget.informasi_detail,
            textAlign: TextAlign.justify,
          ),
          Padding(
            padding: const EdgeInsets.only(top: 10, bottom: 5),
            child: Text(
              'Pembayaran',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                  color: Colors.grey.shade700),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: Image.asset('assets/img/hsbc.png'),
                ),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/img/bca.png')),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/img/mega.png')),
                ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: Image.asset('assets/img/bri.png')),
              ],
            ),
          )
        ],
      )),
      bottomNavigationBar: Container(
        margin: const EdgeInsets.only(left: 10, right: 10, bottom: 10, top: 2),
        padding:
            const EdgeInsets.only(left: 20, right: 10, top: 10, bottom: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.blue.shade50,
            border: Border.all(color: Colors.blue.shade200),
            boxShadow: [
              BoxShadow(
                  offset: const Offset(1, 1),
                  blurRadius: 10,
                  color: Colors.blue.withOpacity(0.2))
            ]
            // gradient: LinearGradient(
            //     begin: Alignment.topCenter,
            //     end: Alignment.bottomCenter,
            //     colors: [Colors.purple.shade200, Colors.pink.shade100]),
            ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Row(
              children: [
                Text(
                  'Rp ${widget.harga}',
                  style: const TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue),
                ),
                Text(
                  '/day',
                  style: const TextStyle(fontSize: 25, color: Colors.blue),
                ),
              ],
            ),
            SizedBox(
              width: 10,
            ),
            InkWell(
              onTap: () {
                try {
                  launchUrl(Uri.parse('https://wa.me/+6287771062510'));
                } catch (e) {
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(e.toString()),
                    backgroundColor: Colors.orange.shade400,
                  ));
                }
              },
              child: Image.asset(
                'assets/img/whatsapp.png',
                height: 30,
              ),
            ),
            Utils.IS_ADMIN
                ? SizedBox()
                : IconButton(
                    onPressed: () {
                      AwesomeDialog(
                        context: context,
                        animType: AnimType.scale,
                        dialogType: DialogType.warning,
                        title: 'Ingin mengajukan sewa kepada admin?',
                        btnCancelOnPress: () {},
                        btnOkOnPress: () {
                          setState(() {
                            updateStatusPenyewaan();
                            addUser();
                          });
                        },
                      ).show();
                    },
                    icon:
                        Icon(Icons.arrow_forward, size: 30, color: Colors.blue))
          ],
        ),
      ),
    );
  }
}
