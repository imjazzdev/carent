import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class ItemProduct extends StatelessWidget {
  final String title;
  final String harga;
  final String img;
  final String lokasi;
  final Widget? iconDelete;
  ItemProduct(
      {required this.title,
      required this.harga,
      required this.img,
      required this.lokasi,
      this.iconDelete});

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      height: 100,
      decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
                blurRadius: 5,
                spreadRadius: 3,
                color: Colors.blue.withOpacity(0.2),
                offset: Offset(
                  1.5,
                  3,
                ))
          ],
          borderRadius: BorderRadius.circular(15)),
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ClipRRect(
              //     borderRadius: BorderRadius.only(
              //         topLeft: Radius.circular(15),
              //         topRight: Radius.circular(15),
              //         bottomLeft: Radius.circular(0),
              //         bottomRight: Radius.circular(0)),
              //     child: Image.asset(
              //       img,
              //       height: 130,
              //       fit: BoxFit.cover,
              //     )),
              ClipRRect(
                child: CachedNetworkImage(
                  imageUrl: img,
                  height: 140,
                  width: double.maxFinite,
                  fit: BoxFit.cover,
                ),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(15),
                    topRight: Radius.circular(15),
                    bottomLeft: Radius.circular(0),
                    bottomRight: Radius.circular(0)),
              ),
              Container(
                width: double.infinity,
                padding:
                    const EdgeInsets.only(left: 7, right: 7, bottom: 7, top: 7),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      overflow: TextOverflow.fade,
                      maxLines: 1,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                    ),
                    Text(lokasi),
                    Text(
                      'Rp ${harga}',
                      style: TextStyle(
                          color: Colors.blue,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
            ],
          ),
          Positioned(
              bottom: 25, right: 0, child: iconDelete ?? const SizedBox())
        ],
      ),
    );
  }
}
