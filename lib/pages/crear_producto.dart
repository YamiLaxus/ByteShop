import 'package:flutter/material.dart';
import 'dart:io';

import 'package:url_launcher/url_launcher.dart';

class CommonThings {
  static Size size;
}

class CrearProductos extends StatefulWidget {
  final String id;
  const CrearProductos({this.id});

  @override
  _CrearProductos createState() => _CrearProductos();
}

enum SelectSource { camara, galeria }

class _CrearProductos extends State<CrearProductos> {
  File _foto;
  String urlFoto;
  bool _isInAsyncCall = false;
  int price;
  //Auth auth = Auth();

  TextEditingController priceInputController;
  TextEditingController nameInputController;
  TextEditingController imageInputController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xff392850),
        title: InkWell(child: Text('Pocket Info')),
        actions: <Widget>[],
      ),
      body: new ListView(
        children: [
          new Container(
            height: 90.0,
            child: GridTile(
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset("images/banrura.png"),
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
            child: (new Text(" Cuenta Ahorro Banrural Cta. No. 4010226453")),
          ),
          new Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
            child: (new Text(" Osbaldo Esequiel Martínez")),
          ),
          Divider(
            color: Colors.deepPurple,
          ),
          new Container(
            height: 90.0,
            child: GridTile(
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset("images/bi.webp"),
              ),
            ),
          ),
          new Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
            child: (new Text(" Cuenta Ahorro BI Cta. No. 176-36-85680")),
          ),
          new Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
            child: (new Text(" Osbaldo Esequiel Martínez")),
          ),
          Divider(
            color: Colors.deepPurple,
          ),
          new Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
            child: (new Text(
                "Luego de realizar el pedido, deberá identificar su pago mediante foto de voleta o caputra de la transferencia. Tambien es necesario que mencione su localidad por si aplicaria costo de envio o recogera su producto en nuestra tienda.")),
          ),
          Divider(
            color: Colors.deepPurple,
          ),
          new Padding(
            padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
            child: (new Text(
                "Nota: Recomendaciones, el obejtivo de nuestra aplicacion es facilitar nuestros productos de forma catalogada para ti, por lo tanto utilizala para obetner informacion.\n\nBajo ningun motivo deposite dinero a otra cuenta bancaria que no sea oficialmente registrada en la aplicacion y te invitamos a visitar las tiendas para que puedas ver los productos por ti mismo. \n\nPreciona el Boton de abajo para más información.")),
          ),
          new Container(
            height: 90.0,
            child: GridTile(
              child: new IconButton(
                  icon: Image.asset("images/whatsapp.png"),
                  onPressed: () {
                    msgListaPedido();
                  }),
            ),
          ),
        ],
      ),
    );
  }

  void msgListaPedido() async {
    String pedido = "";
    String fecha = DateTime.now().toString();
    pedido = pedido + "OpenTarget";
    pedido = pedido + "\n";
    pedido = pedido + "\n";
    pedido = pedido + "FECHA: " + fecha.toString();
    pedido = pedido + "\n";
    pedido = pedido + "\n";
    pedido =
        pedido + "Hola, me puede dar más información sobre el pago por favor.";
    pedido = pedido + "_______________________________";

//Evitar informacion ********************************************

    await launch("https://wa.me/${50256951963}?text=$pedido");
  }
}
