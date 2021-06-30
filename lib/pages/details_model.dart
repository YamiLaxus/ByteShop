import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:open_target_sa/pages/crear_producto.dart';
import 'package:url_launcher/url_launcher.dart';

class DetailsModel extends StatefulWidget {
  final product_detail_name;
  final product_detail_picture;
  final product_detail_operador;
  final product_detail_details;
  final product_detail_storage;
  final product_detail_ram;
  final product_detail_price;
  final product_detail_quantity;

  DetailsModel(
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

class _DetailsState extends State<DetailsModel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        elevation: 0.1,
        backgroundColor: Color(0xff392850),
        title: InkWell(child: Text('Detalles del Producto')),
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
                    fit: BoxFit.fitHeight,
                    placeholder: (_, __) {
                      return Center(
                          child: CupertinoActivityIndicator(
                        radius: 15,
                      ));
                    }),
              ),
              footer: new Container(
                color: Colors.white70,
                child: ListTile(
                  leading: new Text(
                    '${widget.product_detail_name}',
                    style:
                        TextStyle(fontWeight: FontWeight.bold, fontSize: 24.0),
                  ),
                  title: new Row(
                    children: <Widget>[
                      Expanded(
                          child: new Text(
                        'Q.${widget.product_detail_price.toString()}',
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 18.0,
                            color: Colors.red),
                      )),
                    ],
                  ),
                ),
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
                    showDialog(
                        context: context,
                        builder: (context) {
                          return new AlertDialog(
                            title: new Text(
                                "Ten un lindo día gracias por visitarnos."),
                            actions: <Widget>[
                              new MaterialButton(
                                onPressed: () {
                                  Navigator.of(context).pop(context);
                                },
                                child: new Text("Salir"),
                              ),
                            ],
                          );
                        });
                  },
                  color: Colors.white,
                  textColor: Colors.grey,
                  elevation: 1,
                ),
              )
            ],
          ),

          Row(
            children: <Widget>[
              // ================ the color button ===========
              Expanded(
                child: MaterialButton(
                    onPressed: () {
                      msgListaPedido();
                    },
                    color: Colors.deepPurple,
                    textColor: Colors.white,
                    elevation: 0.2,
                    child: new Text(
                      "Comprar Ahora",
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
                            builder: (context) => new CrearProductos()));
                  }),
            ],
          ),
          Divider(
            color: Colors.deepPurple,
          ),
          new ListTile(
            title: new Text("Detalles del Producto"),
            subtitle: new Text('${widget.product_detail_details}'),
          ),
          Divider(
            color: Colors.deepPurple,
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
    pedido = pedido + "CLIENTE: Consumidor Final";
    pedido = pedido + "\n";
    pedido = pedido + "_______________________________";

    pedido = '$pedido' +
        "\n" +
        "Producto: ${widget.product_detail_name}" +
        "\n" +
        "Cantidad: 1" +
        "\n" +
        "Precio: Q.${widget.product_detail_price.toString()}" +
        "\n" +
        "\_______________________________\n";

    pedido = pedido + "TOTAL: Q. ${widget.product_detail_price.toString()}";

//Evitar pedidos a 0 ********************************************

    await launch("https://wa.me/${50256951963}?text=$pedido");
  }
}
