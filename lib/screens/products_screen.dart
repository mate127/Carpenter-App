import 'package:carpenter_app/screens/add_product_screen.dart';
import 'package:carpenter_app/screens/notification_screen.dart';
import 'package:carpenter_app/screens/product_details.dart';
import 'package:carpenter_app/screens/query_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/role.dart';
import '../models/userModel.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  UserModel currentUser = UserModel("", "", Role.buyer);
  String searchName = "";
  List<Map<String, dynamic>> globalProductData = [];
  bool isLoaded = false;
  Future<void> getData() async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentReference userRef = users.doc(user?.uid);
    DocumentSnapshot userSnapshot = await userRef.get();
    Map<String, dynamic> data = userSnapshot.data() as Map<String, dynamic>;
    currentUser.email = user!.email!;
    isLoaded = false;
    globalProductData = [];
    CollectionReference products =
        FirebaseFirestore.instance.collection('products');
    QuerySnapshot snapshot = await products.get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    for (var document in documents) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        Map<String, dynamic>? product = {};
        product['name'] = data['name'];
        product['description'] = data['description'];
        product['hours'] = data['hours'];
        product['picture'] = data['picture'];
        var materialRef = data['materials'];
        for (DocumentSnapshot materialDoc in materialRef) {}
        var userRef = data['userRef'];
        DocumentSnapshot documentSnapshot = await userRef.get();
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          product['user'] = data['username'];
          globalProductData.add(product);
        }
      }
    }
    isLoaded = true;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (currentUser.role == Role.buyer)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddProductScreen()));
              },
              style:
                  ElevatedButton.styleFrom(minimumSize: const Size(80.0, 30.0)),
              child: const Text('Add product'),
            ),
          TextField(
            decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search), hintText: 'Search...'),
            onChanged: (val) {
              setState(() {
                searchName = val;
              });
            },
          ),
          const SizedBox(
            height: 10.0,
          ),
          Expanded(
            child: FutureBuilder(
                future: getData(),
                builder: (context, snapshots) {
                  return (!isLoaded)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: globalProductData.length,
                          itemBuilder: (context, index) {
                            var data = globalProductData;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: ListTile(
                                title: Text(
                                  data[index]['name'],
                                  style: const TextStyle(fontSize: 25.0),
                                ),
                                subtitle: Text(data[index]['user']),
                                shape: RoundedRectangleBorder(
                                  side: const BorderSide(
                                      color: Colors.black, width: 0.7),
                                  borderRadius: BorderRadius.circular(6),
                                ),
                              ),
                            );
                          });
                }),
          )
        ],
      ),
    );
  }
}
