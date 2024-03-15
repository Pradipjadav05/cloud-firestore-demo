class ProductModel{
  String? id;
  String? name;
  String? price;

  ProductModel({this.id, this.name, this.price});

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'name': name,
      'price': price,
    };
  }

  factory ProductModel.fromJSON(Map<String, dynamic> json, String id) {
    return ProductModel(
      id: id,
      name: json['name'],
      price: json['price'],
    );
  }
}