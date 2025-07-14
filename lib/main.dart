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
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Enterprise PageView Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyProject(),
    );
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
      EnterprisePageViewWidget(storageKey: keyPageView),
      ExpansionPage(storageKey: keyExpansion),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Enterprise Design Tools'),
        backgroundColor: const Color(0xFF1A237E),
        foregroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: IndexedStack(index: bottomIndex, children: pages),
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        currentIndex: bottomIndex,
        selectedItemColor: const Color(0xFF1A237E),
        unselectedItemColor: Colors.grey,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Lists'),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_carousel),
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
