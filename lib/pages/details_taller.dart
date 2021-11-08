import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_target_sa/pages/about.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsTaller extends StatefulWidget {
  final product_detail_name;
  final product_detail_picture;
  final product_detail_operador;
  final product_detail_details;
  final product_detail_storage;
  final product_detail_ram;
  final product_detail_price;
  final product_detail_quantity;

  DetailsTaller(
      {this.product_detail_name,
      this.product_detail_picture,
      this.product_detail_operador,
      this.product_detail_details,
      this.product_detail_storage,
      this.product_detail_ram,
      this.product_detail_price,
      this.product_detail_quantity});

  @override
  _DetailsState createState() => _DetailsState();
}

class _DetailsState extends State<DetailsTaller> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Colors.blue[800],
        title: InkWell(child: Text('Informacion')),
        actions: <Widget>[],
      ),
      body: new ListView(
        children: <Widget>[
          new Container(
            height: 280.0,
            child: GridTile(
              child: Container(
                width: 100,
                height: 100,
                color: Colors.white70,
                child: CachedNetworkImage(
                    imageUrl: '${widget.product_detail_picture}' + '?alt=media',
                    fit: BoxFit.fill,
                    placeholder: (_, __) {
                      return Center(
                          child: CupertinoActivityIndicator(
                        radius: 15,
                      ));
                    }),
              ),
              footer: new Container(),
            ),
          ),

          Container(
            color: Colors.white70,
            child: ListTile(
              leading: new Text(
                '${widget.product_detail_name}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
              ),
              title: new Row(
                children: <Widget>[
                  Expanded(
                      child: new Text(
                    'Tel. ${widget.product_detail_price.toString()}',
                    style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18.0,
                        color: Colors.red),
                  )),
                ],
              ),
            ),
          ),

          // ================The first button =============
          Row(
            children: <Widget>[
              // ================ the color button ===========
              Expanded(
                child: MaterialButton(
                    onPressed: () {
                      msgListaPedido();
                    },
                    color: Colors.blue,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text(
                      "Contactar Ahora",
                      style: TextStyle(
                          fontWeight: FontWeight.bold, fontSize: 16.0),
                    )),
              ),
              new IconButton(
                  icon: Icon(Icons.info),
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => new OtraPagina()));
                  }),
            ],
          ),
          Divider(
            color: Colors.deepPurple,
          ),
          new ListTile(
            title: new Text("Más Detalles"),
            subtitle: new Text('${widget.product_detail_details}'),
          ),
          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Dirección: ",
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),

                //Set value at variable widget.=====================================read this
                child: new Text('${widget.product_detail_storage}'),
              )
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  "Horario: ",
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),

                //Set value at variable widget.=====================================read this
                child: new Text('${widget.product_detail_ram.toString()}'),
              )
            ],
          ),

          new Row(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.fromLTRB(12.0, 5.0, 5.0, 5.0),
                child: new Text(
                  'Servicios: ',
                  style: TextStyle(),
                ),
              ),
              Padding(
                padding: EdgeInsets.all(5.0),

                //Set value at variable widget.=====================================read this
                child: new Text('${widget.product_detail_operador}'),
              )
            ],
          ),
        ],
      ),
    );
  }

  void msgListaPedido() async {
    String pedido = "";
    DateTime dateToday =
        DateTime(DateTime.now().year, DateTime.now().month, DateTime.now().day);
    String fecha = dateToday.toString();
    pedido = pedido + "Pocket";
    pedido = pedido + "\n";
    pedido = pedido + "\n";
    pedido = pedido + "FECHA: " + fecha.toString();
    pedido = pedido + "\n";
    pedido = pedido + "_______________________________";
    pedido = pedido + "\n";
    pedido = pedido + "Hola, quiero realizar una consulta, ";

//Evitar pedidos a 0 ********************************************

    await launch(
        "https://wa.me/${502}${widget.product_detail_price.toString()}?text=$pedido");
  }
}
