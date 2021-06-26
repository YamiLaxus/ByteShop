import 'package:flutter/material.dart';

class NotFound extends StatefulWidget {
  @override
  _OtraPagnaState createState() => _OtraPagnaState();
}

class _OtraPagnaState extends State<NotFound> {
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
            child: (new Text("Ups! 404 Contenido no disponibel.",
                style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.bold))),
          ),
          new Align(
            alignment: Alignment.topCenter,
            child: (new Text(
                "Espera futuras versiones de la App lo agregaremos pronto.",
                style: TextStyle(fontSize: 13.0))),
          ),
        ],
      ),
    );
  }
}
