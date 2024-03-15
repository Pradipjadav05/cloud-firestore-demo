class CartModel{
  String? id;
  String? productId;
  String? userId;

  CartModel({this.id, this.productId, this.userId});

  Map<String, dynamic> toJson() {
    return {
      'id' : id,
      'userId': userId,
      'productId': productId,
    };
  }


  factory CartModel.fromJSON(Map<String, dynamic> json, String id) {
    return CartModel(
      id: id,
      productId: json['productID'],
      userId: json['userID'],
    );
  }
}