import 'package:flutter/material.dart';

class ListPage extends StatefulWidget {
  final PageStorageKey<String> storageKey;

  const ListPage({super.key, required this.storageKey});

  @override
  State<ListPage> createState() => _ListPageState();
}

class _ListPageState extends State<ListPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: widget.storageKey,
      padding: const EdgeInsets.all(8.0),
      itemBuilder: (context, index) {
        return Container(
          height: 280.0,
          margin: const EdgeInsets.only(bottom: 16.0),
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: Colors.black,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(10),
            color: index % 2 == 0
                ? Colors.orange.shade200
                : Colors.blue.shade200,
            child: Center(
              child: Text(
                "Item $index",
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
