import 'package:carpenter_app/screens/query_screen.dart';
import 'package:flutter/material.dart';

class AdvertisementDetails extends StatelessWidget {
  final Map<String, dynamic> data;
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
                "User: ${data!['user']}",
                style: TextStyle(fontSize: 22.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              Text(
                'Title: ${data!['title']}',
                style: TextStyle(fontSize: 22.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              const Text(
                'Description:',
                style: TextStyle(fontSize: 22.0),
              ),
              Text(
                data!['description'],
                style: TextStyle(fontSize: 16.0),
              ),
              const SizedBox(
                height: 20.0,
              ),
              ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const QueryScreen()));
                  },
                  child: const Text('Contact'))
            ],
          ),
        ));
  }
}
