import 'package:flutter/material.dart';

class ExpansionPage extends StatefulWidget {
  final PageStorageKey<String> storageKey;

  const ExpansionPage({super.key, required this.storageKey});

  @override
  State<ExpansionPage> createState() => _ExpansionPageState();
}

class _ExpansionPageState extends State<ExpansionPage> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      key: widget.storageKey,
      padding: const EdgeInsets.all(8.0),
      itemCount: 10,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.only(bottom: 8.0),
          child: ExpansionTile(
            title: Text(
              "Item ${index + 1}",
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            leading: const Icon(Icons.ac_unit, color: Colors.blue),
            backgroundColor: Colors.grey.shade50,
            collapsedBackgroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            collapsedShape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8),
              side: BorderSide(color: Colors.grey.shade300),
            ),
            children: [
              Container(
                height: 200.0,
                width: double.infinity,
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  color: index % 2 == 0
                      ? Colors.orange.shade200
                      : Colors.blue.shade200,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        index % 2 == 0 ? Icons.sunny : Icons.water_drop,
                        size: 40,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        "Content for Item ${index + 1}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
