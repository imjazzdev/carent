import 'package:cached_network_image/cached_network_image.dart';
import 'package:carent/pages/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'componen/varglobal.dart';

class KategoriPengajuanRental extends StatelessWidget {
  const KategoriPengajuanRental({super.key});

  @override
  Widget build(BuildContext context) {
    final produk = FirebaseFirestore.instance
        .collection('produk')
        .where('status_penyewaan', isEqualTo: 'Diajukan')
        .where('user', arrayContains: Utils.USER_NOW);
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengajuan Rental'),
      ),
      body: ListView(
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 15),
            padding: EdgeInsets.all(10),
            child: Text(
                'Menunggu persejuan admin. Silahkan hubungi nomor yang tertera pada produk dan lakukan pembayaran.'),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                border: Border.all(color: Colors.red.shade400)),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: produk.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return ListView(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(20),
                    children: snapshot.data!.docs
                        .map((e) => Stack(
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Detail(
                                            img: e['img'],
                                            title: e['title'],
                                            harga: e['harga'],
                                            merk: e['merk'],
                                            lokasi: e['lokasi'],
                                            informasi_detail:
                                                e['informasi_detail'],
                                          ),
                                        ));
                                  },
                                  child: Container(
                                    height: 120,
                                    padding: EdgeInsets.all(8),
                                    margin: EdgeInsets.only(bottom: 20),
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(15),
                                        boxShadow: [
                                          BoxShadow(
                                              offset: Offset(4, 4),
                                              color:
                                                  Colors.blue.withOpacity(0.5),
                                              blurRadius: 5)
                                        ],
                                        color: Colors.blue.shade50),
                                    child: Row(
                                      children: [
                                        Container(
                                          child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                              child: CachedNetworkImage(
                                                imageUrl: e['img'],
                                                height: 100,
                                                width: 100,
                                                fit: BoxFit.cover,
                                              )),
                                        ),
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceEvenly,
                                          children: [
                                            Text(
                                              e['title'],
                                              style: TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold),
                                            ),
                                            Text(e['lokasi'],
                                                style: TextStyle(
                                                  fontSize: 18,
                                                )),
                                            Text('Rp ${e['harga']}',
                                                style: TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                    color: Colors.blue)),
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                Positioned(
                                    bottom: 10,
                                    right: 8,
                                    child: Image.asset(
                                      'assets/img/file.png',
                                      height: 50,
                                      width: 50,
                                    ))
                              ],
                            ))
                        .toList(),
                  );
                } else {
                  return const CircularProgressIndicator();
                }
              }),
        ],
      ),
    );
  }
}
