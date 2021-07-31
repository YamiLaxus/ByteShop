import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:open_target_sa/pages/home.dart';
import 'griddashboard.dart';

void main() => runApp(MaterialApp(home: Categories()));

class Categories extends StatefulWidget {
  @override
  _CategoriesState createState() => _CategoriesState();
}

class _CategoriesState extends State<Categories> {
  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    //final appBarHeight = appBar.preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;
    double cardWidth = MediaQuery.of(context).size.width / 3.3;
    double cardHeight = MediaQuery.of(context).size.height / 3.6;

    return Scaffold(
        backgroundColor: Color(0xff392850),
        body: Column(
          children: [
            SizedBox(
              height: 50,
            ),
            Padding(
              padding: EdgeInsets.only(left: 16.0, right: 16.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Categorias",
                        style: GoogleFonts.openSans(
                            color: Colors.white,
                            fontSize: 22,
                            fontWeight: FontWeight.bold),
                      ),
                      Text(
                        "Inicio",
                        style: GoogleFonts.openSans(
                            color: Color(0xffa29aac),
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                  IconButton(
                      alignment: Alignment.center,
                      icon: Icon(
                        Icons.home,
                        color: Colors.white,
                      ),
                      onPressed: () =>
                          Navigator.of(context).push(new MaterialPageRoute(
                            builder: (BuildContext context) => MyHomePage(),
                          ))),
                ],
              ),
            ),
            GridDashboard()
          ],
        ));
  }
}
