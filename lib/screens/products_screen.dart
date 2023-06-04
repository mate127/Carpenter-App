import 'package:carpenter_app/screens/add_product_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ProductsScreen extends StatefulWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  State<ProductsScreen> createState() => _ProductsScreenState();
}

class _ProductsScreenState extends State<ProductsScreen> {
  String searchName = "";
  List<Map<String, dynamic>> data = [
    {'name': 'Oak table', 'user': 'John Doe'},
    {'name': 'Pine table', 'user': 'John Doe'},
    {'name': 'Oak chair', 'user': 'Jane Doe'}
  ];
  addData() async {
    for (var element in data) {
      FirebaseFirestore.instance.collection('products').add(element);
    }
    print('all data added');
  }

  @override
  void initState() {
    // TODO: implement initState
    addData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const AddProductScreen()));
            },
            child: const Text('Add product'),
            style:
                ElevatedButton.styleFrom(minimumSize: const Size(80.0, 30.0)),
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
            child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('products')
                    .snapshots(),
                builder: (context, snapshots) {
                  return (snapshots.connectionState == ConnectionState.waiting)
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (context, index) {
                            var data = this.data;
                            return Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: ListTile(
                                title: Text(
                                  data[index]['name'],
                                  style: TextStyle(fontSize: 25.0),
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
