class ProductosModel {
  var id;

  String name;
  String image;
  String operador;
  String details;
  String storage;
  String ram;
  int price;
  int quantity;

  ProductosModel(
    String documentID,
    String name,
    String image,
    String operador,
    String details,
    String storage,
    String ram,
    int price,
    int quantity,
  );

  ProductosModel.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.image = obj['image'];
    this.operador = obj['operador'];
    this.details = obj['details'];
    this.storage = obj['storage'];
    this.ram = obj['ram'];
    this.price = obj['price'];
    this.quantity = obj['quantity'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['operador'] = operador;
    map['details'] = details;
    map['storage'] = storage;
    map['ram'] = ram;
    map['price'] = price;
    map['quantity'] = quantity;

    return map;
  }

  ProductosModel.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.id = map['id'];
    this.image = map['image'];
    this.operador = map['operador'];
    this.details = map['details'];
    this.storage = map['storage'];
    this.ram = map['ram'];
    this.price = map['price'];
    this.quantity = 0;
  }
}
