import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

class AddFood extends StatefulWidget {
  const AddFood({super.key});

  @override
  State<AddFood> createState() => _AddFoodState();
}

class _AddFoodState extends State<AddFood> {
  TextEditingController code = TextEditingController();
  TextEditingController name = TextEditingController();
  TextEditingController price = TextEditingController();
  TextEditingController url = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('ADD FOOD'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          children: [
            TextField(
              controller: code,
              decoration: const InputDecoration(
                labelText: 'Food Code',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: name,
              decoration: const InputDecoration(
                labelText: 'Food Name',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: price,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(
                labelText: 'Price',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            TextField(
              controller: url,
              decoration: const InputDecoration(
                labelText: 'URL Picture',
                border: OutlineInputBorder(),
              ),
            ),
            const SizedBox(height: 10.0),
            ElevatedButton(
              child: const Text('ADD FOOD'),
              onPressed: () async {
                var headers = {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json'
                };

// Make a request to get the current highest id in the API
                var idResponse = await http.get(
                  Uri.parse(
                      'https://apigenerator.dronahq.com/api/g7s7P925/TestAlan?_sort=id&_order=desc&_limit=1'),
                  headers: headers,
                );

                var currentId = 0;

// If the request was successful, use the current highest id
// Otherwise, default to 0
                if (idResponse.statusCode == 200) {
                  var idJson = jsonDecode(idResponse.body);
                  if (idJson.isNotEmpty) {
                    currentId = idJson[0]['id'];
                  }
                }

                var time = DateTime.now();
                var request = http.Request(
                    'POST',
                    Uri.parse(
                        'https://apigenerator.dronahq.com/api/g7s7P925/TestAlan'));
                request.body = jsonEncode({
                  "food_code": code.text,
                  "name": name.text,
                  "picture": url.text,
                  "price": price.text,
                  "picture_ori": "",
                  "created_at": time.toString(),
                  "id":
                      currentId + 1, // Set the id to the current highest id + 1
                });
                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {
                  Get.back();
                  print('Success: add food to API');
                } else {
                  Get.back();
                  print('Error: add food to API');
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
