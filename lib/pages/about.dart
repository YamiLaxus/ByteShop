import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OtraPagina extends StatefulWidget {
  @override
  _OtraPagnaState createState() => _OtraPagnaState();
}

class _OtraPagnaState extends State<OtraPagina> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xff392850),
        title: InkWell(child: Text('Pocket Team')),
        actions: <Widget>[],
      ),
      body: ListView(
        children: [
          new Container(
            height: 90.0,
            child: GridTile(
              child: Container(
                width: 100,
                height: 100,
                child: Image.asset("images/PhoneDevLogo.png"),
              ),
            ),
          ),
          Divider(
            color: Colors.deepPurple,
          ),
          new Align(
            alignment: Alignment.topCenter,
            child: (new Text("Version Beta 1.0 Powered By Phone.Dev.",
                style: TextStyle(fontSize: 15.0))),
          ),
          Divider(
            color: Colors.deepPurple,
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
    pedido = pedido + "Hola, .";
    pedido = pedido + "_______________________________";

//Evitar informacion ********************************************

    await launch("https://wa.me/${50241642429}?text=$pedido");
  }
}
