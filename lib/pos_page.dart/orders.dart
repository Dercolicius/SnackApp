import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:snack/model.dart';
import 'package:snack/crud_page/food_read.dart';

class YourOrderPage extends StatefulWidget {
  final List<Snack> selectedItems;
  const YourOrderPage(
      {Key? key, required this.selectedItems})
      : super(key: key);

  @override
  _YourOrderPageState createState() => _YourOrderPageState();
}

class _YourOrderPageState extends State<YourOrderPage> {
  TextEditingController uangDibayar = TextEditingController();

  @override
  Widget build(BuildContext context) {
    int getTotalHarga() {
      int total = 0;
      for (var item in widget.selectedItems) {
        total += int.parse(item.price);
      }
      return total;
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('PESANAN'),
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
            child: ListView.builder(
              itemCount: widget.selectedItems.length,
              itemBuilder: (context, index) {
                final item = widget.selectedItems[index];
                return Padding(
                  padding: const EdgeInsets.only(
                    left: 5.0,
                    right: 5.0,
                  ),
                  child: Card(
                    elevation: 5.0,
                    child: ListTile(
                      leading: Image.network(
                        item.picture,
                        height: 50.0,
                        width: 50.0,
                        fit: BoxFit.cover,
                      ),
                      title: Text(item.name),
                      subtitle: Text('Rp ${item.price}'),
                      trailing: ElevatedButton(
                        child: const Text('Hapus'),
                        onPressed: () {
                          setState(() {
                            widget.selectedItems.removeAt(index);
                          });
                          getTotalHarga();
                        },
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Column(
            children: [
              Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'TOTAL : ',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        '${getTotalHarga()}',
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'UANG DIBAYAR : ',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Center(
                      child: TextField(
                        controller: uangDibayar,
                        keyboardType: TextInputType.number,
                        textAlign: TextAlign.center,
                        decoration: const InputDecoration(
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        'KEMBALIAN : ',
                        style: TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    height: 50,
                    width: MediaQuery.of(context).size.width / 2,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.grey,
                        width: 1.0,
                      ),
                      borderRadius: const BorderRadius.all(
                        Radius.circular(5.0),
                      ),
                    ),
                    child: Center(
                      child: Text(
                        uangDibayar.text.isEmpty
                            ? ''
                            : '${int.parse(uangDibayar.text) - getTotalHarga()}',
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              ElevatedButton(
                child: const Text('Cetak Struk'),
                onPressed: () {},
              )
            ],
          ),
        ],
      ),
    );
  }
}
