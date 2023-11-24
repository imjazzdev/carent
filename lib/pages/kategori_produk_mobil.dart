import 'package:carent/pages/detail.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'componen/item_product.dart';

class KategoriProdukMobil extends StatefulWidget {
  const KategoriProdukMobil({super.key});

  @override
  State<KategoriProdukMobil> createState() => _KategoriProdukMobilState();
}

class _KategoriProdukMobilState extends State<KategoriProdukMobil> {
  final produk = FirebaseFirestore.instance.collection('produk');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Produk'),
      ),
      body: StreamBuilder<QuerySnapshot>(
          stream: produk.snapshots(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return GridView(
                padding:
                    EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
                gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
                    maxCrossAxisExtent: 200,
                    childAspectRatio: 2 / 2.8,
                    crossAxisSpacing: 20,
                    mainAxisSpacing: 20),
                children: snapshot.data!.docs
                    .map((e) => InkWell(
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
                                    informasi_detail: e['informasi_detail'],
                                  ),
                                ));
                          },
                          child: ItemProduct(
                              title: e['title'] ?? 'Example',
                              harga: e['harga'] ?? 'Example',
                              img: e['img'] ??
                                  'https://firebasestorage.googleapis.com/v0/b/deal-app-c0f78.appspot.com/o/fortuner.jfif?alt=media&token=ccd93273-3713-4808-892f-4f68e0c72381',
                              lokasi: e['lokasi'] ?? 'Example'),
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
