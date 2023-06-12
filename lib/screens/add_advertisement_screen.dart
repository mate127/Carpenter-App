import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class AddAdvertisementScreen extends StatefulWidget {
  const AddAdvertisementScreen({Key? key}) : super(key: key);

  @override
  State<AddAdvertisementScreen> createState() => _AddAdvertisementScreenState();
}

class _AddAdvertisementScreenState extends State<AddAdvertisementScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descriptionController = TextEditingController();

  addAdvertisement(String title, String description) async {
    CollectionReference users = FirebaseFirestore.instance.collection('users');
    DocumentReference userRef = users.doc(user?.uid);
    CollectionReference ads =
        FirebaseFirestore.instance.collection('advertisements');
    await ads
        .add({'title': title, 'description': description, 'userRef': userRef});
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        title: const Text('Add advertisement'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(15.0, 50.0, 40.0, 100.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Title', style: TextStyle(fontSize: 15.0)),
                  TextFormField(
                    controller: _titleController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                ],
              ),
              const SizedBox(
                height: 20.0,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Description', style: TextStyle(fontSize: 15.0)),
                  TextFormField(
                    controller: _descriptionController,
                    textAlignVertical: TextAlignVertical.top,
                    maxLines: null,
                    keyboardType: TextInputType.multiline,
                    decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 120.0),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(15.0))),
                  ),
                ],
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    addAdvertisement(_titleController.text.trim(),
                        _descriptionController.text.trim());
                  },
                  child: const Text('Submit'))
            ],
          ),
        ),
      ),
    );
  }
}
