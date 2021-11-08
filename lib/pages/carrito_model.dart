import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:open_target_sa/models/acc_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class Cart extends StatefulWidget {
  final List<AccModel> _cart;

  Cart(this._cart);

  @override
  _CartState createState() => _CartState(this._cart);
}

class _CartState extends State<Cart> {
  _CartState(this._cart);
  final _scrollController = ScrollController();
  var _firstScroll = true;
  bool _enabled = false;

  List<AccModel> _cart;

  Container pagoTotal(List<AccModel> _cart) {
    return Container(
      alignment: Alignment.centerRight,
      padding: EdgeInsets.only(left: 120),
      height: 70,
      width: 400,
      color: Colors.grey[200],
      child: Row(
        children: <Widget>[
          Text("Total:  \Q.${valorTotal(_cart)}",
              style: new TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 14.0,
                  color: Colors.black))
        ],
      ),
    );
  }

  String valorTotal(List<AccModel> listaProductos) {
    double total = 0.0;

    for (int i = 0; i < listaProductos.length; i++) {
      total = total + listaProductos[i].price * listaProductos[i].quantity;
    }
    return total.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: Icon(Icons.details),
            onPressed: null,
            color: Colors.white,
          )
        ],
        title: Text(
          "Tu carrito",
          style: TextStyle(
              fontWeight: FontWeight.bold, fontSize: 18.0, color: Colors.white),
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).pop();
            setState(() {
              _cart.length;
            });
          },
          color: Colors.white,
        ),
        backgroundColor: Colors.blue[800],
      ),
      body: GestureDetector(
        onVerticalDragUpdate: (details) {
          if (_enabled && _firstScroll) {
            _scrollController
                .jumpTo(_scrollController.position.pixels - details.delta.dy);
          }
        },
        onVerticalDragEnd: (_) {
          if (_enabled) _firstScroll = false;
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                itemCount: _cart.length,
                itemBuilder: (context, index) {
                  final String imagen = _cart[index].image;
                  var item = _cart[index];
                  return Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8.0, vertical: 2.0),
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  width: 100,
                                  height: 100,
                                  child: CachedNetworkImage(
                                      imageUrl: '${item.image}' + '?alt=media',
                                      fit: BoxFit.fitHeight,
                                      placeholder: (_, __) {
                                        return Center(
                                            child: CupertinoActivityIndicator(
                                          radius: 15,
                                        ));
                                      }),
                                )),
                                Column(
                                  children: [
                                    Text(item.name,
                                        style: new TextStyle(
                                            fontWeight: FontWeight.bold,
                                            fontSize: 16.0,
                                            color: Colors.black)),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        Container(
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              color: Colors.deepPurple[600],
                                              boxShadow: [
                                                BoxShadow(
                                                  blurRadius: 6.0,
                                                  color: Colors.blue[400],
                                                  offset: Offset(0.0, 1.0),
                                                )
                                              ],
                                              borderRadius: BorderRadius.all(
                                                Radius.circular(50.0),
                                              )),
                                          margin: EdgeInsets.only(top: 20.0),
                                          padding: EdgeInsets.all(2.0),
                                          child: new Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              SizedBox(
                                                height: 8.0,
                                              ),
                                              IconButton(
                                                icon: Icon(Icons.remove),
                                                onPressed: () {
                                                  setState(() {
                                                    _cart[index].quantity--;
                                                    valorTotal(_cart);
                                                  });
                                                },
                                                color: Colors.white,
                                              ),
                                              Text('${_cart[index].quantity}',
                                                  style: new TextStyle(
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 22.0,
                                                      color: Colors.white)),
                                              IconButton(
                                                icon: Icon(Icons.add),
                                                onPressed: () {
                                                  setState(() {
                                                    _cart[index].quantity++;
                                                    valorTotal(_cart);
                                                  });
                                                },
                                                color: Colors.white,
                                              ),
                                              SizedBox(
                                                height: 8.0,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 38.0,
                                ),
                                Text(
                                  'Q.${item.price.toString()}',
                                  style: new TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 22.0,
                                      color: Colors.black),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                      Divider(
                        color: Colors.purple,
                      )
                    ],
                  );
                },
              ),
              SizedBox(
                width: 10.0,
              ),
              pagoTotal(_cart),
              SizedBox(
                width: 20.0,
              ),
              Container(
                height: 100,
                width: 200,
                padding: EdgeInsets.only(top: 50),
                // ignore: deprecated_member_use
                child: RaisedButton(
                  textColor: Colors.white,
                  color: Colors.deepPurple,
                  child: Text("COMPRAR"),
                  onPressed: () => {
                    if (valorTotal(_cart).toLowerCase() == "0.0")
                      {Text("No ")}
                    else
                      {msgListaPedido()}
                  },
                ),
              ),
              Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(bottom: 2),
                child: Text(
                  "     Nota la compra se realizara mediante WhatsApp." +
                      "\n" +
                      "Para más detalles ve a la parte de información en menú.",
                  style: TextStyle(fontSize: 12.0),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void msgListaPedido() async {
    String pedido = "";
    String fecha = DateTime.now().toString();
    pedido = pedido + "Pocket";
    pedido = pedido + "\n";
    pedido = pedido + "\n";
    pedido = pedido + "FECHA: " + fecha.toString();
    pedido = pedido + "\n";
    pedido = pedido + "CLIENTE: Consumidor Final";
    pedido = pedido + "\n";
    pedido = pedido + "_______________________________";

    for (int i = 0; i < _cart.length; i++) {
      pedido = '$pedido' +
          "\n" +
          "Producto: " +
          _cart[i].name +
          "\n" +
          "Cantidad: " +
          _cart[i].quantity.toString() +
          "\n" +
          "Precio: Q." +
          _cart[i].price.toString() +
          "\n" +
          "\_______________________________\n";
    }
    pedido = pedido + "TOTAL: Q." + valorTotal(_cart);

//Evitar pedidos a 0 ********************************************
    if (valorTotal(_cart).toLowerCase() != "0.0") {
      await launch("https://wa.me/${50256951963}?text=$pedido");
    } else {}
  }
}
