import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_target_sa/models/acc_model.dart';
import 'package:open_target_sa/pages/categories.dart';
import 'package:open_target_sa/pages/crear_producto.dart';
import 'package:open_target_sa/pages/about.dart';
import 'package:open_target_sa/pages/details_model.dart';
import 'package:open_target_sa/pages/home.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_target_sa/services/firebase_services_zapatos.dart';
import 'carrito_model.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
      ),
      home: ZapatosPage(title: 'Pocket Calzado'),
    );
  }
}

class ZapatosPage extends StatefulWidget {
  ZapatosPage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<ZapatosPage> {
  List<AccModel> _productosModel = <AccModel>[];

  List<AccModel> _listaCarro = [];

  FirebaseServices db = new FirebaseServices();

  StreamSubscription<QuerySnapshot> productSub;

  bool isSearching = false;

  final product_name;
  final product_picture;
  final product_details;
  final product_type;
  final product_price;
  final product_quantity;

  _MyHomePageState(
      {this.product_name,
      this.product_picture,
      this.product_type,
      this.product_details,
      this.product_price,
      this.product_quantity});

  @override
  void initState() {
    super.initState();

    _productosModel = new List();

    productSub?.cancel();
    productSub = db.getProductList().listen((QuerySnapshot snapshot) {
      final List<AccModel> products = snapshot.documents
          .map((DocumentSnapshot) => AccModel.fromMap(DocumentSnapshot.data))
          .cast<AccModel>()
          .toList();

      setState(() {
        this._productosModel = products;
      });
    });
  }

  @override
  void dispose() {
    productSub?.cancel();
    super.dispose();
  }

  void _filter(value) {}

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Color(0xff392850),
      title: !isSearching
          ? new Text("Pocket Calzado")
          : TextField(
              onChanged: (value) {
                _filter(value);
              },
              style: TextStyle(color: Colors.white),
              decoration: InputDecoration(
                  icon: Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  hintText: "Buscar",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
      actions: [
        isSearching
            ? new IconButton(
                icon: Icon(
                  Icons.cancel,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    this.isSearching = false;
                  });
                })
            : new IconButton(
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                onPressed: () {
                  setState(() {
                    this.isSearching = true;
                  });
                }),
        Padding(
          padding: const EdgeInsets.only(right: 16.0, top: 12.0),
          child: GestureDetector(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Icon(
                  Icons.shopping_cart,
                  size: 30,
                ),
                if (_listaCarro.length > 0)
                  Padding(
                    padding: const EdgeInsets.only(left: 2.0),
                    child: CircleAvatar(
                      radius: 8.0,
                      backgroundColor: Colors.red,
                      foregroundColor: Colors.white,
                      child: Text(
                        _listaCarro.length.toString(),
                        style: TextStyle(
                            fontWeight: FontWeight.bold, fontSize: 12.0),
                      ),
                    ),
                  ),
              ],
            ),
            onTap: () {
              if (_listaCarro.isNotEmpty)
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => Cart(_listaCarro),
                  ),
                );
            },
          ),
        ),
      ],
    );

    final screenHeight = MediaQuery.of(context).size.height;
    final appBarHeight = appBar.preferredSize.height;
    final statusBarHeight = MediaQuery.of(context).padding.top;

    /* Widget image_carousel = new Container(
      height: 140.0,
      child: new Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage(
            'images/SamsungAseries.webp',
          ),
          AssetImage('images/huaweilogo.png'),
          AssetImage('images/SamsungLogoa.png'),
          AssetImage('images/galaxybnr.jpg'),
          AssetImage('images/phoneone.jpg')
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        autoplayDuration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotColor: Colors.deepPurple,
        dotBgColor: Colors.black,
      ),
    );*/

    return Scaffold(
        appBar: appBar,
        drawer: Container(
          width: 170.0,
          child: Drawer(
            child: Container(
              width: MediaQuery.of(context).size.width,
              color: Colors.white,
              child: new ListView(
                padding: EdgeInsets.only(top: 50.0),
                children: <Widget>[
                  Container(
                    height: 150,
                    // ignore: missing_required_param
                    child: new UserAccountsDrawerHeader(
                      accountEmail: new Text(''),
                      decoration: new BoxDecoration(
                          image: DecorationImage(
                              image: AssetImage("images/PocketLogo.png"),
                              fit: BoxFit.fill)),
                    ),
                  ),
                  new Divider(
                    color: Colors.black,
                  ),
                  new ListTile(
                    title: new Text(
                      "Home",
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: new Icon(
                      Icons.home,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => MyHomePage(),
                    )),
                  ),
                  new Divider(
                    color: Colors.black,
                  ),
                  new ListTile(
                    title: new Text(
                      "Categorias",
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: new Icon(
                      Icons.category,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => Categories(),
                    )),
                  ),
                  new Divider(
                    color: Colors.black,
                  ),
                  new ListTile(
                      title: new Text(
                        "Carrito",
                        style: TextStyle(color: Colors.black),
                      ),
                      trailing: new Icon(
                        Icons.shopping_cart,
                        size: 30.0,
                        color: Colors.black,
                      ),
                      onTap: () {
                        if (_listaCarro.isNotEmpty)
                          Navigator.of(context).push(
                            MaterialPageRoute(builder: (BuildContext context) {}
                                //builder: (context) => Cart(_listaCarro),
                                ),
                          );
                      }),
                  new Divider(
                    color: Colors.black,
                  ),
                  new ListTile(
                    title: new Text(
                      "Informacion de Pagos y Entrega",
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: new FaIcon(
                      FontAwesomeIcons.list,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => CrearProductos(),
                    )),
                  ),
                  new Divider(
                    color: Colors.black,
                  ),
                  new ListTile(
                    title: new Text(
                      "Acerca de",
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: new FaIcon(
                      FontAwesomeIcons.qrcode,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => OtraPagina(),
                    )),
                  ),
                ],
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: SingleChildScrollView(
              child: Container(
            child: Column(
              children: <Widget>[
                // image_carousel,
                Container(height: 0.7, color: Colors.grey),
                SizedBox(
                  height: 1.0,
                ),
                Container(
                    color: Color(0xff392850),
                    height: (screenHeight - appBarHeight - statusBarHeight),
                    child: GridView.builder(
                      padding: const EdgeInsets.all(4.0),
                      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 1),
                      itemCount: _productosModel.length,
                      itemBuilder: (context, index) {
                        final String imagen = _productosModel[index].image;
                        var item = _productosModel[index];
                        return Card(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            elevation: 10.0,
                            child: Stack(
                              fit: StackFit.loose,
                              alignment: Alignment.center,
                              children: <Widget>[
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: CachedNetworkImage(
                                          imageUrl:
                                              '${_productosModel[index].image}' +
                                                  '?alt=media',
                                          fit: BoxFit.cover,
                                          placeholder: (_, __) {
                                            return Center(
                                                child:
                                                    CupertinoActivityIndicator(
                                              radius: 15,
                                            ));
                                          }),
                                    ),
                                    Text(
                                      '${_productosModel[index].name}',
                                      textAlign: TextAlign.center,
                                      style: TextStyle(fontSize: 20.0),
                                    ),
                                    SizedBox(
                                      height: 15,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        SizedBox(
                                          height: 25,
                                        ),
                                        Text(
                                          'Q.${_productosModel[index].price.toString()}',
                                          style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 19.0,
                                              color: Colors.black),
                                        ),
                                        //Button details *********************************
                                        new IconButton(
                                          icon: Icon(Icons.arrow_forward_ios,
                                              size: 24,
                                              color: Colors.deepPurple[700]),
                                          onPressed: () => Navigator.of(context)
                                              .push(new MaterialPageRoute(
                                            builder: (BuildContext context) =>
                                                DetailsModel(
                                              product_detail_name:
                                                  _productosModel[index].name,
                                              product_detail_picture:
                                                  _productosModel[index].image,
                                              product_detail_details:
                                                  _productosModel[index]
                                                      .details,
                                              product_detail_price:
                                                  _productosModel[index].price,
                                            ),
                                          )),
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                            right: 8.0,
                                            bottom: 8.0,
                                          ),
                                          child: Align(
                                            alignment: Alignment.bottomRight,
                                            child: GestureDetector(
                                              child: (!_listaCarro
                                                      .contains(item))
                                                  ? Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.grey[700],
                                                      size: 38,
                                                    )
                                                  : Icon(
                                                      Icons.shopping_cart,
                                                      color: Colors.red,
                                                      size: 38,
                                                    ),
                                              onTap: () {
                                                setState(() {
                                                  if (!_listaCarro
                                                      .contains(item))
                                                    _listaCarro.add(item);
                                                  else
                                                    _listaCarro.remove(item);
                                                });
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                )
                              ],
                            ));
                      },
                    )),
              ],
            ),
          )),
        ));
  }
}
