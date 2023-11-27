import 'package:carent/pages/profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'componen/carousel_banner.dart';
import 'componen/item_product.dart';
import 'componen/kategori.dart';
import 'componen/varglobal.dart';
import 'detail.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final produk = FirebaseFirestore.instance.collection('produk').limit(4);

  @override
  void initState() {
    Utils.USER_NOW = FirebaseAuth.instance.currentUser!.email!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(Utils.USER_NOW);
    return Scaffold(
      appBar: AppBar(
        title: Text('Home'),
        centerTitle: true,
        leading: Image.asset('assets/img/logo.png'),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => Profile(),
                    ));
              },
              icon: Icon(Icons.person_2_rounded))
        ],
      ),
      body: ListView(
        children: [
          CarouselBanner(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Kategori',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Kategori(),
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Recomended',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          StreamBuilder<QuerySnapshot>(
              stream: produk.snapshots(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return GridView(
                    shrinkWrap: true,
                    padding: EdgeInsets.only(left: 20, right: 20, bottom: 20),
                    physics: NeverScrollableScrollPhysics(),
                    gridDelegate:
                        const SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 2 / 2.9,
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
              })
        ],
      ),
    );
  }
}
