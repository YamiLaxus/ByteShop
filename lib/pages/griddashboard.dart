import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_target_sa/pages/home.dart';
import 'package:open_target_sa/pages/notFound.dart';
import 'package:open_target_sa/pages/page_acc.dart';
import 'package:open_target_sa/pages/page_arte_ange.dart';
import 'package:open_target_sa/pages/page_fix.dart';
import 'package:open_target_sa/pages/page_playeras.dart';
import 'package:open_target_sa/pages/page_tablets.dart';
import 'package:open_target_sa/pages/page_zapatos.dart';

// ignore: must_be_immutable

class GridDashboard extends StatelessWidget {
  Item item1 = new Item(
      title: "Celulares",
      img: "images/categories/phone.png",
      page: MyHomePage());
  Item item2 = new Item(
      title: "Tablets", img: "images/categories/ipad.png", page: TabletPage());
  Item item3 = new Item(
      title: "Accesorios", img: "images/categories/acc.png", page: AccPage());
  Item item4 = new Item(
      title: "Arte", img: "images/categories/art.png", page: ArtPage());
  Item item5 = new Item(
      title: "Kiki Store", img: "images/categories/kkSrLog.jpg", page: PlayerasPage());
  Item item6 = new Item(
      title: "Calzado R.J",
      img: "images/categories/zapatos.png",
      page: ZapatosPage());
  Item item7 = new Item(
      title: "Servicios", img: "images/categories/fix.png", page: FixPage());
  Item item8 = new Item(
      title: "Una cosa más",
      img: "images/categories/more.png",
      page: NotFound());

  @override
  Widget build(BuildContext context) {
    final statusBarHeight = MediaQuery.of(context).padding.top;
    final screenHeight = MediaQuery.of(context).size.height;
    double cardWidth = MediaQuery.of(context).size.width / 2;
    double cardHeight = MediaQuery.of(context).size.height / 2;
    List<Item> myList = [
      item1,
      item2,
      item3,
      item4,
      item5,
      item6,
      item7,
      item8
    ];
    var color = 0xff453658;

    return Flexible(
      child: GridView.count(
          padding: EdgeInsets.only(top: 20, left: 16, right: 16),
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 12,
          childAspectRatio: 1.4,
          children: myList.map((data) {
            return Container(
              height: (screenHeight - statusBarHeight),
              decoration: BoxDecoration(
                  color: Color(color), borderRadius: BorderRadius.circular(10)),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    data.img,
                    width: 50,
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    data.title,
                    style: GoogleFonts.openSans(
                      textStyle: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                  IconButton(
                      icon: Icon(Icons.arrow_right,
                          size: 35, color: Colors.white),
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => data.page));
                      })
                ],
              ),
            );
          }).toList()),
    );
  }
}

class Item {
  String title;
  String img;
  Widget page;
  Item({this.title, this.img, this.page});
}
