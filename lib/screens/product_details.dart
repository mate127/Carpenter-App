import 'package:flutter/material.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({Key? key}) : super(key: key);

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Product details'),
          centerTitle: true,
        ),
        body: Padding(
          padding: EdgeInsets.fromLTRB(30.0, 50.0, 0.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Image.asset(
                  'images/slika.png',
                  height: 200.0,
                ),
              ),
              const SizedBox(
                height: 40.0,
              ),
              const Text(
                'Name: Oak chair',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Hours: 10',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Materials: Oak',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              const Text(
                'Description: Lorem ipsum dolor sit amet, '
                'consectetur adipiscing elit, '
                'sed do eiusmod tempor incididunt '
                'ut labore et dolore magna aliqua.'
                ' Ut enim ad minim veniam, '
                'quis nostrud exercitation'
                ' ullamco laboris nisi ut aliquip '
                'ex ea commodo consequat.',
                style: TextStyle(fontSize: 20.0),
              ),
              const SizedBox(
                height: 10.0,
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Contact'))
            ],
          ),
        ));
  }
}
