class StackModel {
  var id;

  String text;
  String image;

  StackModel(
    String documentID,
    String text,
    String image,
  );

  Map<String, dynamic> toMap() {
    var map = new Map<String, dynamic>();

    map['id'] = id;
    map['text'] = text;
    map['image'] = image;

    return map;
  }

  StackModel.fromMap(Map<String, dynamic> map) {
    this.id = map['id'];
    this.image = map['image'];
    this.text = map['text'];
  }
}
