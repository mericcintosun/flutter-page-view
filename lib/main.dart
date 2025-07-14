import 'package:flutter/material.dart';
import 'package:generalsections/widgets/list.dart';
import 'package:generalsections/widgets/pageview.dart';
import 'package:generalsections/widgets/expansion.dart';
import 'package:generalsections/widgets/settings.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(debugShowCheckedModeBanner: false, home: MyProject());
  }
}

class MyProject extends StatefulWidget {
  const MyProject({super.key});

  @override
  State<MyProject> createState() => _MyProjectState();
}

class _MyProjectState extends State<MyProject> {
  final PageStorageKey<String> keyList = const PageStorageKey('keyList');
  final PageStorageKey<String> keyExpansion = const PageStorageKey(
    'keyExpansion',
  );
  final PageStorageKey<String> keyPageView = const PageStorageKey(
    'keyPageView',
  );

  late List<Widget> pages;
  int bottomIndex = 0;

  @override
  void initState() {
    super.initState();
    pages = [
      ListPage(storageKey: keyList),
      PageViewPage(storageKey: keyPageView),
      ExpansionPage(storageKey: keyExpansion),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Design Tools'),
        backgroundColor: Colors.blue,
        foregroundColor: Colors.white,
      ),
      body: IndexedStack(index: bottomIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomIndex,
        selectedItemColor: Colors.blue,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list), label: 'List'),
          BottomNavigationBarItem(
            icon: Icon(Icons.pageview),
            label: 'PageView',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.expand_more),
            label: 'Expansion',
          ),
        ],
        onTap: (index) {
          setState(() {
            bottomIndex = index;
          });
        },
      ),
    );
  }
}
