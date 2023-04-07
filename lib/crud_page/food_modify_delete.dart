import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:snack/model.dart';

class DetailFood extends StatefulWidget {
  const DetailFood({super.key});

  @override
  State<DetailFood> createState() => _DetailFoodState();
}

class _DetailFoodState extends State<DetailFood> {
  Snack food = Get.arguments;

  @override
  Widget build(BuildContext context) {
    TextEditingController code = TextEditingController(text: food.foodCode);
    TextEditingController name = TextEditingController(text: food.name);
    TextEditingController price = TextEditingController(text: food.price);
    TextEditingController url = TextEditingController(text: food.picture);

    return Scaffold(
      appBar: AppBar(
        title: const Text('DETAIL FOOD'),
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
              child: const Text('UPDATE FOOD'),
              onPressed: () async {
                var time = DateTime.now();
                var idnya = food.id;
                var headers = {
                  'Content-Type': 'application/json',
                  'Accept': 'application/json'
                };
                var request = http.Request(
                    'PUT',
                    Uri.parse(
                        'https://apigenerator.dronahq.com/api/g7s7P925/TestAlan/$idnya'));
                request.body = jsonEncode({
                  "food_code": code.text,
                  "name": name.text,
                  "picture": url.text,
                  "price": price.text,
                  "picture_ori": "",
                  "created_at": time.toString(),
                  "id": idnya,
                });
                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {
                  Get.back();
                  print('Success: update food to API');
                } else {
                  Get.back();
                  print('Error: update food to API');
                }
              },
            ),
            ElevatedButton(
              style: ButtonStyle(
                backgroundColor: MaterialStateProperty.all<Color>(Colors.red),
              ),
              child: const Text('DELETE FOOD'),
              onPressed: () async {
                var idnya = food.id;
                var headers = {'Accept': 'application/json'};
                var request = http.Request(
                    'DELETE',
                    Uri.parse(
                        'https://apigenerator.dronahq.com/api/g7s7P925/TestAlan/$idnya'));

                request.headers.addAll(headers);

                http.StreamedResponse response = await request.send();

                if (response.statusCode == 200) {
                  Get.back();
                  print('Success: delete food in API');
                } else {
                  Get.back();
                  print('Error: delete food in API');
                }
              },
            )
          ],
        ),
      ),
    );
  }
}
