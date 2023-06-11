import 'package:flutter/material.dart';

class AdvertisementDetails extends StatelessWidget {
  final Map<String, dynamic>? data;
  const AdvertisementDetails({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    print(data);
    return Scaffold(
        appBar: AppBar(
          title: const Text('Advertisement details'),
          centerTitle: true,
        ),
        body: Padding(
          padding: const EdgeInsets.fromLTRB(40.0, 50.0, 40.0, 0.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "User: " + data!['user'],
                style: TextStyle(fontSize: 22.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'Title: ' + data!['title'],
                style: TextStyle(fontSize: 22.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Description:',
                style: TextStyle(fontSize: 22.0),
              ),
              const Text(
                'Lorem ipsum dolor sit amet, '
                'consectetur adipiscing elit, '
                'sed do eiusmod tempor incididunt '
                'ut labore et dolore magna aliqua.'
                ' Ut enim ad minim veniam, '
                'quis nostrud exercitation'
                ' ullamco laboris nisi ut aliquip '
                'ex ea commodo consequat. Duis aute '
                'irure dolor in reprehenderit in '
                'voluptate velit esse cillum dolore eu '
                'fugiat nulla pariatur. Excepteur sint '
                'occaecat cupidatat non proident, sunt '
                'in culpa qui officia deserunt '
                'mollit anim id est laborum.',
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(onPressed: () {}, child: const Text('Contact'))
            ],
          ),
        ));
  }
}
