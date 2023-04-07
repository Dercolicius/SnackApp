import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:snack/crud_page/food_add.dart';
import 'package:snack/crud_page/food_modify_delete.dart';
import 'package:snack/model.dart';
import 'package:http/http.dart' as http;

class ReadFood extends StatefulWidget {
  const ReadFood({super.key});

  @override
  State<ReadFood> createState() => _ReadFoodState();
}

class _ReadFoodState extends State<ReadFood> {
  List<Snack> item = [];

  readFood() async {
    final response = await http.get(
        Uri.parse('https://apigenerator.dronahq.com/api/g7s7P925/TestAlan/'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      item = jsonData.map((e) => Snack.fromJson(e)).toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    readFood();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('FOODLIST'),
        centerTitle: true,
      ),
      body: item.isEmpty
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: item.length,
              itemBuilder: (context, index) {
                final food = item[index];
                return ListTile(
                  leading: Image.network(
                    food.picture,
                    height: 50.0,
                    width: 50.0,
                    fit: BoxFit.cover,
                  ),
                  title: Text(food.name),
                  subtitle: Text('Rp ${food.price} / porsi'),
                  trailing: ElevatedButton(
                    child: const Text('Detail'),
                    onPressed: () {
                      Get.to(() => const DetailFood(), arguments: food);
                    },
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const AddFood()));
        },
      ),
    );
  }
}
