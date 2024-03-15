import 'package:cloud_firestore_demo/model/cart_model.dart';
import 'package:cloud_firestore_demo/model/product_model.dart';
import 'package:flutter/material.dart';

import 'firestore_service.dart';
import 'model/user_model.dart';

class CartScreen extends StatefulWidget {
  const CartScreen({super.key});

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
  FirestoreService firestoreService = FirestoreService();
  List<CartModel> cartList = [];
  List<UserModel> userList = [];
  List<ProductModel> productModel = [];

  UserModel user = UserModel();
  ProductModel product = ProductModel();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getCartDetails();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Cart"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: cartList.length,
              itemBuilder: (context, index) {
                getData(index);
                return ListTile(
                  title: Text("Product Name : ${product.name}"),
                  subtitle: Text("User Name : ${user.name}"),
                );
              },
            ),
          )
        ],
      ),
    );
  }

  void getData(int index) async{
    user =  await getUserDetails(userId: cartList[index].userId.toString());
    product =  await getProductDetails(productId: cartList[index].productId.toString());
    setState(() {
    });
  }

  void getCartDetails() async{
    cartList = await firestoreService.getCartDetails();
    print(cartList);

    setState(() {});
  }

  Future<UserModel> getUserDetails({required String userId}) async{
    return await firestoreService.getUserDetails(userId: userId);
  }

  Future<ProductModel> getProductDetails({required String productId}) async{
    return await firestoreService.getProductDetails(productId: productId);
  }
}
