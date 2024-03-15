import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:cloud_firestore_demo/model/cart_model.dart';
import 'package:cloud_firestore_demo/model/product_model.dart';
import 'package:cloud_firestore_demo/model/user_model.dart';

class FirestoreService{
  UserModel userModel = UserModel();
  FirebaseFirestore firebaseInstance = FirebaseFirestore.instance;


  Future<List<UserModel>> getAllUsers() async {
    CollectionReference users = firebaseInstance.collection("users");

    try {
      QuerySnapshot querySnapshot = await users.get();
      List<UserModel> usersList = querySnapshot.docs.map((doc) {
        return UserModel.fromJSON(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return usersList;
    } catch (error) {
      print("Error getting users: $error");
      return []; // Return empty list if error occurs
    }
  }

  Future<UserModel> getUserDetails({required String userId}) async{
    CollectionReference users = firebaseInstance.collection("users");
    try {
      DocumentSnapshot userSnapshot = await users.doc(userId).get();

      if (userSnapshot.exists) {
        return UserModel.fromJSON(userSnapshot.data() as Map<String, dynamic>, userSnapshot.id);
      } else {
        print("User with ID $userId does not exist");
        return UserModel();
      }
    } catch (error) {
      print("Error getting user: $error");
      return UserModel();
    }
  }

  Future<String> addUser(Map<String, dynamic> userData) async {
    CollectionReference users = firebaseInstance.collection("users");
    try {
      await users.add(userData);
      return "Record Inserted Successfully.";
    } catch (error) {
      return error.toString();
    }
  }

  Future<String> editUser(Map<String, dynamic> userData) async{
    try{
      DocumentReference user = firebaseInstance.collection('users').doc(userData['id']);

      await user.update(userData);

      return "Record Edited Successfully.";
    }
    catch(error){
      print(error.toString());
      return error.toString();
    }

  }

  Future<String> deleteUser({required String userId}) async{
    DocumentReference  user = firebaseInstance.collection("users").doc(userId);
    try{
      await user.delete();
      return "Record Deleted Successfully.";
    }
    catch (error){
      return error.toString();
    }
  }


  Future<List<CartModel>> getCartDetails() async{
    CollectionReference users = firebaseInstance.collection("cart");
    try {
      QuerySnapshot querySnapshot = await users.get();
      List<CartModel> cartList = querySnapshot.docs.map((doc) {
        return CartModel.fromJSON(doc.data() as Map<String, dynamic>, doc.id);
      }).toList();
      return cartList;
    } catch (error) {
      print("Error getting users: $error");
      return []; // Return empty list if error occurs
    }
  }

  Future<ProductModel> getProductDetails({required String productId}) async{
    CollectionReference users = firebaseInstance.collection("product");
    try {
      DocumentSnapshot userSnapshot = await users.doc(productId).get();

      if (userSnapshot.exists) {
        return ProductModel.fromJSON(userSnapshot.data() as Map<String, dynamic>, userSnapshot.id);
      } else {
        print("Product with ID $productId does not exist");
        return ProductModel();
      }
    } catch (error) {
      print("Error getting product: $error");
      return ProductModel();
    }
  }
}