import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminPengajuanSewa extends StatefulWidget {
  const AdminPengajuanSewa({super.key});

  @override
  State<AdminPengajuanSewa> createState() => _AdminPengajuanSewaState();
}

class _AdminPengajuanSewaState extends State<AdminPengajuanSewa> {
  @override
  Widget build(BuildContext context) {
    //   Future updateStatusPenyewaan() async {
    //   final doc =
    //       FirebaseFirestore.instance.collection('produk').where('status_penyewaan', isEqualTo: 'Diajukan');
    //   doc.update(
    //     {
    //       'status_penyewaan': 'Diterima',
    //     },
    //   );
    // }
    final produk = FirebaseFirestore.instance
        .collection('produk')
        .where('status_penyewaan', isEqualTo: 'Diajukan');
    return Scaffold(
      appBar: AppBar(
        title: Text('Pengajuan Sewa'),
      ),
      body: StreamBuilder<QuerySnapshot>(
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
                              onTap: () {},
                              child: Container(
                                height: 120,
                                margin: EdgeInsets.only(bottom: 20),
                                padding: EdgeInsets.all(8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(15),
                                    boxShadow: [
                                      BoxShadow(
                                          offset: Offset(4, 4),
                                          color: Colors.blue.withOpacity(0.5),
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
                                              fontSize: 18,
                                              fontWeight: FontWeight.bold),
                                        ),
                                        Text(e['lokasi'],
                                            style: TextStyle(
                                              fontSize: 16,
                                            )),
                                        Text('Rp ${e['harga']}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue)),
                                        Text('${e['user']}',
                                            style: TextStyle(
                                                fontSize: 14,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.grey)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 30,
                                right: 10,
                                child: IconButton(
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.scale,
                                        dialogType: DialogType.warning,
                                        title:
                                            'Ingin mengubah status produk ke On Rental?',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          final doc = FirebaseFirestore.instance
                                              .collection('produk')
                                              .doc(e['title']);
                                          doc.update(
                                            {
                                              'status_penyewaan': 'Diterima',
                                            },
                                          );
                                        },
                                      ).show();
                                    },
                                    icon: Icon(
                                      Icons.check_outlined,
                                      size: 50,
                                      color: Colors.green,
                                    )))
                          ],
                        ))
                    .toList(),
              );
            } else {
              return const CircularProgressIndicator();
            }
          }),
    );
  }
}
