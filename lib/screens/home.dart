import 'package:carpenter_app/auth/auth.dart';
import 'package:carpenter_app/auth/login.dart';
import 'package:carpenter_app/auth/register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  User? user = FirebaseAuth.instance.currentUser;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home'), centerTitle: true),
      body: Center(
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          if (user == null)
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => AuthScreen()));
                  },
                  style:
                      ElevatedButton.styleFrom(backgroundColor: Colors.white54),
                  child: const Text(
                    'Sign in',
                    style: TextStyle(
                      color: Colors.blue,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15.0,
                ),
                const SizedBox(
                  width: 15.0,
                )
              ],
            ),
          const SizedBox(height: 100.0),
          if (user != null)
            Column(
              children: [
                Text('signed in as${user?.email}'),
                ElevatedButton(
                    onPressed: () {
                      showDialog(
                          context: context,
                          barrierDismissible: false,
                          builder: (context) =>
                              const Center(child: CircularProgressIndicator()));
                      FirebaseAuth.instance.signOut();
                      navigatorKey.currentState!
                          .popUntil((route) => route.isFirst);
                    },
                    child: const Text('Sign out')),
              ],
            )
        ]),
      ),
    );
  }
}
