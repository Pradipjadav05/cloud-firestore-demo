import 'package:cloud_firestore_demo/cart_screen.dart';
import 'package:cloud_firestore_demo/firestore_service.dart';
import 'package:cloud_firestore_demo/model/user_model.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController mobileController = TextEditingController();

  FirestoreService firestoreService = FirestoreService();
  List<UserModel> userList = [];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getAllUsers();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Home Screen"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: userList.length,
              itemBuilder: (context, index) {
                return Card(
                  child: ListTile(
                    title: Text(userList[index].name.toString()),
                    subtitle: Text(userList[index].mobile.toString()),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        InkWell(
                          child: const Icon(
                            Icons.delete,
                            color: Colors.red,
                          ),
                          onTap: () async {
                            String res = await firestoreService.deleteUser(
                                userId: userList[index].id.toString());
                            getAllUsers();
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content: Text(res),
                              ),
                            );
                          },
                        ),
                        const SizedBox(width: 8),
                        // Add some space between icons
                        InkWell(
                          child: const Icon(
                            Icons.edit,
                            color: Colors.green,
                          ),
                          onTap: () {
                            nameController.text =
                                userList[index].name.toString();
                            mobileController.text =
                                userList[index].mobile.toString();
                            showDialog(
                              context: context,
                              builder: (context) {
                                return editRecordDialog(
                                    id: userList[index].id.toString());
                              },
                            );
                          },
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          TextButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const CartScreen(),
                    ));
              },
              child: const Text("Relation"))
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return addRecordDialog();
            },
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget addRecordDialog() {
    return AlertDialog(
      title: const Text("Add Record"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter Name",
            ),
          ),
          TextFormField(
            controller: mobileController,
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              counterText: "",
              border: UnderlineInputBorder(),
              hintText: "Enter Mobile No.",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () {
            Navigator.pop(context);
          },
          child: const Text("Cancel"),
        ),
        TextButton(
          onPressed: () async {
            UserModel user = UserModel(
                name: nameController.text, mobile: mobileController.text);
            String res = await firestoreService.addUser(user.toJSON());
            Navigator.of(context).pop();
            getAllUsers();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(res),
              ),
            );
          },
          child: const Text("Add"),
        ),
      ],
    );
  }

  Widget editRecordDialog({String? id}) {
    return AlertDialog(
      title: const Text("Edit Record"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormField(
            controller: nameController,
            keyboardType: TextInputType.name,
            decoration: const InputDecoration(
              border: UnderlineInputBorder(),
              hintText: "Enter Name",
            ),
          ),
          TextFormField(
            controller: mobileController,
            maxLength: 10,
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(
              counterText: "",
              border: UnderlineInputBorder(),
              hintText: "Enter Mobile No.",
            ),
          ),
        ],
      ),
      actions: [
        TextButton(
          onPressed: () async {
            UserModel user = UserModel(
                id: id,
                name: nameController.text,
                mobile: mobileController.text);
            String res = await firestoreService.editUser(user.toJSON());
            Navigator.of(context).pop();
            getAllUsers();
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(res),
              ),
            );
          },
          child: const Text("Edit"),
        ),
      ],
    );
  }

  void getAllUsers() async {
    userList = await firestoreService.getAllUsers();
    setState(() {});
  }
}
