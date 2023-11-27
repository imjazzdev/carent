import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AdminOnRental extends StatelessWidget {
  const AdminOnRental({super.key});

  @override
  Widget build(BuildContext context) {
    final produk = FirebaseFirestore.instance
        .collection('produk')
        .where('status_penyewaan', isEqualTo: 'Diterima');
    return Scaffold(
      appBar: AppBar(
        title: Text('On Rental'),
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
                                margin: EdgeInsets.only(bottom: 20),
                                height: 120,
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
                                              fontSize: 14,
                                            )),
                                        Text('Rp ${e['harga']}',
                                            style: TextStyle(
                                                fontSize: 18,
                                                fontWeight: FontWeight.bold,
                                                color: Colors.blue)),
                                        // Text(e['user'][0],
                                        //     style: TextStyle(
                                        //         fontSize: 16,
                                        //         color: Colors.black54)),
                                      ],
                                    )
                                  ],
                                ),
                              ),
                            ),
                            Positioned(
                                bottom: 35,
                                right: 8,
                                child: IconButton(
                                    onPressed: () {
                                      AwesomeDialog(
                                        context: context,
                                        animType: AnimType.scale,
                                        dialogType: DialogType.warning,
                                        title: 'Masa rental sudah selesai?',
                                        btnCancelOnPress: () {},
                                        btnOkOnPress: () {
                                          final doc = FirebaseFirestore.instance
                                              .collection('produk')
                                              .doc(e['title']);
                                          doc.update(
                                            {
                                              'status_penyewaan': 'null',
                                            },
                                          );
                                        },
                                      ).show();
                                    },
                                    icon: Icon(
                                      Icons.delete_forever_rounded,
                                      size: 40,
                                      color: Colors.red,
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
