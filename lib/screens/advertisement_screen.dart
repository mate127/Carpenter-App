import 'package:carpenter_app/models/userModel.dart';
import 'package:carpenter_app/screens/add_advertisement_screen.dart';
import 'package:carpenter_app/screens/advertisement_details.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../models/role.dart';

class AdvertisementScreen extends StatefulWidget {
  const AdvertisementScreen({Key? key}) : super(key: key);

  @override
  State<AdvertisementScreen> createState() => _AdvertisementScreenState();
}

class _AdvertisementScreenState extends State<AdvertisementScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  String searchName = "";
  List<Map<String, dynamic>> globalAdvertisementData = [];
  bool isLoaded = false;
  Future<void> getData() async {
    isLoaded = false;
    globalAdvertisementData = [];
    CollectionReference advertisements =
        FirebaseFirestore.instance.collection('advertisements');
    QuerySnapshot snapshot = await advertisements.get();
    List<QueryDocumentSnapshot> documents = snapshot.docs;
    for (var document in documents) {
      Map<String, dynamic>? data = document.data() as Map<String, dynamic>?;
      if (data != null) {
        Map<String, dynamic>? advertisement = {};
        advertisement['title'] = data['title'];
        advertisement['description'] = data['description'];
        var documentRef = data['userRef'];
        DocumentSnapshot documentSnapshot = await documentRef.get();
        if (documentSnapshot.exists) {
          Map<String, dynamic> data =
              documentSnapshot.data() as Map<String, dynamic>;
          advertisement['user'] = data['username'];
          globalAdvertisementData.add(advertisement);
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
          if (user != null)
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const AddAdvertisementScreen()));
              },
              style:
                  ElevatedButton.styleFrom(minimumSize: const Size(80.0, 30.0)),
              child: const Text('Add advertisement'),
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
                          itemCount: globalAdvertisementData.length,
                          itemBuilder: (context, index) {
                            var data = globalAdvertisementData;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: GestureDetector(
                                onTap: () => Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) =>
                                            AdvertisementDetails(
                                                data: data[index]))),
                                child: ListTile(
                                  title: Text(
                                    data[index]['title'],
                                    style: const TextStyle(fontSize: 25.0),
                                  ),
                                  subtitle: Text(data[index]['user']),
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(
                                        color: Colors.black, width: 0.7),
                                    borderRadius: BorderRadius.circular(6),
                                  ),
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
