import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_pro/carousel_pro.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_target_sa/models/productos_model.dart';
import 'package:open_target_sa/pages/categories.dart';
import 'package:open_target_sa/pages/crear_producto.dart';
import 'package:open_target_sa/pages/details.dart';
import 'package:open_target_sa/pages/about.dart';
import 'package:open_target_sa/pages/pedidos_lista.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:open_target_sa/services/firebase_services.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Pocket Phone'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<ProductosModel> _productosModel = <ProductosModel>[];
  TextEditingController _searchController = TextEditingController();

  int currentIndex = 0;

  List<ProductosModel> _listaCarro = [];

  FirebaseServices db = new FirebaseServices();

  StreamSubscription<QuerySnapshot> productSub;

  bool isSearching = false;
  bool isLoading = false;

  final product_name;
  final product_picture;
  final product_operador;
  final product_details;
  final product_storage;
  final product_ram;
  final product_price;
  final product_quantity;

  _MyHomePageState(
      {this.product_name,
      this.product_picture,
      this.product_operador,
      this.product_details,
      this.product_storage,
      this.product_ram,
      this.product_price,
      this.product_quantity});

  @override
  void initState() {
    super.initState();

    _onSearchChanged() {
      print(_searchController.text);
    }

    _productosModel = new List();

    productSub?.cancel();
    productSub = db.getProductList().listen((QuerySnapshot snapshot) {
      final List<ProductosModel> products = snapshot.documents
          .map((DocumentSnapshot) =>
              ProductosModel.fromMap(DocumentSnapshot.data))
          .toList();

      setState(() {
        this._productosModel = products;
      });
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    productSub?.cancel();
    super.dispose();
  }

  void _filter(value) {}

  @override
  Widget build(BuildContext context) {
    final appBar = AppBar(
      backgroundColor: Colors.blue,
      title: !isSearching
          ? new Text("Pocket Phone")
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
                  Icons.info,
                  color: Colors.white,
                ),
                onPressed: () {}),
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

    Widget image_carousel = new Container(
      height: 140.0,
      child: new Carousel(
        boxFit: BoxFit.fill,
        images: [
          AssetImage('images/banners/iphoneBnnr.jpg'),
          AssetImage('images/banners/huaweiBnnr.jpg'),
          AssetImage('images/banners/samsungBnnr.jpg'),
          AssetImage('images/banners/pocketBnnr.jpg'),
        ],
        autoplay: true,
        animationCurve: Curves.fastOutSlowIn,
        autoplayDuration: Duration(seconds: 2),
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 4.0,
        indicatorBgPadding: 2.0,
        dotColor: Colors.blueAccent,
        dotBgColor: Colors.black,
      ),
    );
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
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => MyApp(),
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
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
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
                          MaterialPageRoute(
                            builder: (context) => Cart(_listaCarro),
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
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
                    builder: (BuildContext context) => CrearProductos(),
                  )),
                ),
                new Divider(
                  color: Colors.black,
                ),
                /*new ListTile(
                    title: new Text(
                      "Configuración",
                      style: TextStyle(color: Colors.black),
                    ),
                    trailing: new Icon(
                      Icons.settings,
                      size: 30.0,
                      color: Colors.black,
                    ),
                    onTap: () =>
                        Navigator.of(context).push(new MaterialPageRoute(
                      builder: (BuildContext context) => SettingsPage(),
                    )),
                  ),*/
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
                  onTap: () => Navigator.of(context).push(new MaterialPageRoute(
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
              /*Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _searchController,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(15),
                        ),
                        hintText: "Buscar",
                      ),
                    ),
                  ),
                  SizedBox(width: 5),
                  new IconButton(
                      icon: Icon(
                        Icons.search,
                        size: 40,
                        color: Colors.black,
                      ),
                      onPressed: () {}),
                  SizedBox(width: 20),
                ],
              ),*/
              image_carousel,
              Container(
                  color: Colors.white,
                  height: (screenHeight -
                      appBarHeight -
                      statusBarHeight -
                      140.0), //-210.0
                  child: GridView.builder(
                    padding: const EdgeInsets.all(4.0),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2),
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
                                              child: CupertinoActivityIndicator(
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
                                            size: 24, color: Colors.red[800]),
                                        onPressed: () => Navigator.of(context)
                                            .push(new MaterialPageRoute(
                                          builder: (BuildContext context) =>
                                              Details(
                                            product_detail_name:
                                                _productosModel[index].name,
                                            product_detail_picture:
                                                _productosModel[index].image,
                                            product_detail_operador:
                                                _productosModel[index].operador,
                                            product_detail_details:
                                                _productosModel[index].details,
                                            product_detail_storage:
                                                _productosModel[index].storage,
                                            product_detail_ram:
                                                _productosModel[index].ram,
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
                                            child: (!_listaCarro.contains(item))
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
                                                if (!_listaCarro.contains(item))
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
      ),
      /*bottomNavigationBar: BottomNavigationBar(
        currentIndex: currentIndex,
        onTap: (index) => setState(() => currentIndex = index),
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Inicio',
              backgroundColor: Colors.blue),
          BottomNavigationBarItem(
              icon: Icon(Icons.category),
              label: 'Categorias',
              backgroundColor: Colors.deepPurple),
          BottomNavigationBarItem(
              icon: Icon(Icons.info),
              label: 'Info',
              backgroundColor: Colors.red),
        ],
      ),*/
    );
  }
}

//====================================images carrucel redondo solo images======

/*
Stack(
                  children: <Widget>[
                    WaveClip(),
                    Container(
                      color: Colors.transparent,
                      padding: const EdgeInsets.only(left: 24, top: 48),
                      height: 150,
                      child: ListView.builder(
                        itemCount: _productosModel.length,
                        scrollDirection: Axis.horizontal,
                        itemBuilder: (context, index) {
                          return Row(
                            children: <Widget>[
                              Container(
                                height: 250,
                                padding: new EdgeInsets.only(
                                    left: 10.0, bottom: 10.0),
                                child: Card(
                                  elevation: 7.0,
                                  clipBehavior: Clip.antiAlias,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(24)),
                                  child: AspectRatio(
                                    aspectRatio: 1,
                                    child: CachedNetworkImage(
                                        imageUrl:
                                            '${_productosModel[index].image}' +
                                                '?alt=media',
                                        fit: BoxFit.cover,
                                        placeholder: (_, __) {
                                          return Center(
                                              child: CupertinoActivityIndicator(
                                            radius: 15,
                                          ));
                                        }),
                                  ),
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ),
                  ],
                ),*/
