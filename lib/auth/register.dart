import 'package:carpenter_app/auth/phone_register.dart';
import 'package:carpenter_app/models/role.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../main.dart';
import '../utilities/utils.dart';
import '../screens/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  final Function() showLoginScreen;
  const RegisterScreen({Key? key, required this.showLoginScreen})
      : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();

  bool isValidEmail(value) {
    return RegExp(
            r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$')
        .hasMatch(value);
  }

  final _usernameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  Role role = Role.buyer;

  Future signUp() async {
    final isValid = _formKey.currentState!.validate();
    if (!isValid) return;
    showDialog(
        context: context,
        builder: (context) => const Center(child: CircularProgressIndicator()));
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim());
      addUserDetails(
          _usernameController.text.trim(), _emailController.text.trim(), role);
    } on FirebaseAuthException catch (e) {
      Utils.showSnackBar(e.message);
    }
    navigatorKey.currentState!.popUntil((route) => route.isFirst);
  }

  bool passwordConfirmed() {
    return _passwordController.text.trim() ==
        _confirmPasswordController.text.trim();
  }

  Future addUserDetails(String username, String email, Role role) async {
    await FirebaseFirestore.instance
        .collection('users')
        .add({'username': username, 'email': email, 'role': role.toString()});
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return SingleChildScrollView(
      child: SizedBox(
        height: size.height,
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: AppBar(title: const Text('Register'), centerTitle: true),
          body: Container(
              padding: const EdgeInsets.fromLTRB(40.0, 10.0, 40.0, 0.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => HomeScreen()));
                        },
                        child: const Text(
                          'Home',
                          style: TextStyle(color: Colors.blue, fontSize: 17.0),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 30.0),
                  Form(
                    key: _formKey,
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Username',
                                  style: TextStyle(fontSize: 15.0)),
                              TextFormField(
                                controller: _usernameController,
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Email',
                                  style: TextStyle(fontSize: 15.0)),
                              TextFormField(
                                controller: _emailController,
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      !isValidEmail(value)) {
                                    return 'Please enter valid email';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Password',
                                  style: TextStyle(fontSize: 15.0)),
                              TextFormField(
                                controller: _passwordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter the password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Confirm password',
                                  style: TextStyle(fontSize: 15.0)),
                              TextFormField(
                                controller: _confirmPasswordController,
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please repeat the password';
                                  }
                                  return null;
                                },
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderRadius:
                                            BorderRadius.circular(15.0))),
                              ),
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text('Choose a role',
                                  style: TextStyle(fontSize: 15.0)),
                              SizedBox(
                                height: 30.0,
                                child: ListTile(
                                  title: const Text('Buyer'),
                                  leading: Radio<Role>(
                                    value: Role.buyer,
                                    groupValue: role,
                                    onChanged: (Role? value) {
                                      setState(() {
                                        role = value!;
                                      });
                                    },
                                  ),
                                ),
                              ),
                              ListTile(
                                title: const Text('Carpenter'),
                                leading: Radio<Role>(
                                  value: Role.carpenter,
                                  groupValue: role,
                                  onChanged: (Role? value) {
                                    setState(() {
                                      role = value!;
                                    });
                                  },
                                ),
                              ),
                            ],
                          ),
                          ElevatedButton(
                              onPressed: () {
                                signUp();
                              },
                              child: const Text('Register')),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Already have an account? '),
                              GestureDetector(
                                onTap: widget.showLoginScreen,
                                child: const Text(
                                  'Login here.',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 10.0,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const Text('Or use simple '),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PhoneRegisterScreen()));
                                },
                                child: const Text(
                                  'register with phone.',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              )
                            ],
                          )
                        ]),
                  ),
                ],
              )),
        ),
      ),
    );
  }
}
