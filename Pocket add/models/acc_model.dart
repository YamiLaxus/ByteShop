class AccModel {
  var id;

  String name;
  String image;
  String details;
  String type;
  int price;
  int quantity;

  AccModel(
    String documentID,
    String name,
    String image,
    String type,
    String details,
    int price,
    int quantity,
  );

  AccModel.map(dynamic obj) {
    this.id = obj['id'];
    this.name = obj['name'];
    this.image = obj['image'];
    this.type = obj['type'];
    this.details = obj['details'];
    this.price = obj['price'];
    this.quantity = obj['quantity'];
  }

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = id;
    map['name'] = name;
    map['image'] = image;
    map['details'] = details;
    map['type'] = type;
    map['price'] = price;
    map['quantity'] = quantity;

    return map;
  }

  AccModel.fromMap(Map<String, dynamic> map) {
    this.name = map['name'];
    this.id = map['id'];
    this.image = map['image'];
    this.details = map['details'];
    this.type = map['type'];
    this.price = map['price'];
    this.quantity = 0;
  }
}
