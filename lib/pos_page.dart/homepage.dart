import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:snack/model.dart';
import 'package:snack/pos_page.dart/orders.dart';
import 'package:snack/crud_page/food_read.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<Snack> item = [];
  int totalHarga = 0;
  List<Snack> selectedItems = [];

  Future<void> loadSnack() async {
    final response = await http.get(
        Uri.parse('https://apigenerator.dronahq.com/api/g7s7P925/TestAlan'));

    if (response.statusCode == 200) {
      final jsonData = jsonDecode(response.body) as List<dynamic>;
      item = jsonData.map((e) => Snack.fromJson(e)).toList();
      setState(() {});
    }
  }

  @override
  void initState() {
    super.initState();
    loadSnack();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 226, 226, 226),
      appBar: AppBar(
        title: const Text('SNACK APP'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () => Get.to(() => const ReadFood()),
          )
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: item.isEmpty
                ? const Center(
                    child: CircularProgressIndicator(),
                  )
                : ListView.builder(
                    itemCount: item.length,
                    itemBuilder: (context, index) {
                      final food = item[index];
                      return Padding(
                        padding: const EdgeInsets.only(
                          left: 5.0,
                          right: 5.0,
                        ),
                        child: Card(
                          elevation: 5.0,
                          child: ListTile(
                            leading: Image.network(
                              food.picture,
                              height: 100.0,
                              width: 50.0,
                              fit: BoxFit.cover,
                            ),
                            title: Text(food.name),
                            subtitle: Text('Rp ${food.price} / porsi'),
                            trailing: ElevatedButton(
                              child: const Text('Order'),
                              onPressed: () {
                                setState(() {
                                  totalHarga += int.parse(food.price);
                                  selectedItems.add(food);
                                });
                              },
                            ),
                          ),
                        ),
                      );
                    },
                  ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Container(
              height: 70.0,
              width: double.infinity,
              decoration: BoxDecoration(
                  color: Colors.white, border: Border.all(color: Colors.blue)),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        const Icon(
                          Icons.shopping_basket,
                          color: Colors.blue,
                          size: 35.0,
                        ),
                        const SizedBox(width: 10.0),
                        Text(
                          'Rp. $totalHarga',
                          style: const TextStyle(fontSize: 18.0),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      child: const Text('Charge'),
                      onPressed: () {
                        Get.to(
                            () => YourOrderPage(selectedItems: selectedItems));
                      },
                    )
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
