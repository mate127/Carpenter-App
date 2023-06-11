import 'package:carpenter_app/auth/auth.dart';
import 'package:carpenter_app/screens/advertisement_screen.dart';
import 'package:carpenter_app/screens/products_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isProducts = true;
  void toggleAds() => setState(() {
        isProducts = false;
      });
  void toggleProds() => setState(() {
        isProducts = true;
      });
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Center(
          child:
              Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
            const SizedBox(height: 10.0),
            if (user == null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AuthScreen()));
                    },
                    child: const Text(
                      'Sign in',
                      style: TextStyle(color: Colors.blue, fontSize: 17.0),
                    ),
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
            if (user != null)
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()));
                      FirebaseAuth.instance.signOut();
                      navigatorKey.currentState!
                          .popUntil((route) => route.isFirst);
                    },
                    child: const Text(
                      'Sign out',
                      style: TextStyle(color: Colors.blue, fontSize: 17.0),
                    ),
                  ),
                  const SizedBox(
                    width: 30.0,
                  ),
                ],
              ),
            const SizedBox(height: 10.0),
            Row(
              children: [
                ElevatedButton(
                    onPressed: toggleAds,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white12,
                        minimumSize: const Size(80.0, 30.0)),
                    child: const Text('Ads')),
                const SizedBox(
                  width: 10.0,
                ),
                ElevatedButton(
                    onPressed: toggleProds,
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white12,
                        minimumSize: const Size(80.0, 30.0)),
                    child: const Text(
                      'Products',
                    )),
              ],
            ),
            const SizedBox(height: 10.0),
            isProducts ? const ProductsScreen() : const AdvertisementScreen()
          ]),
        ),
      ),
    );
  }
}
