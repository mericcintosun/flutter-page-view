import 'package:flutter/material.dart';

class PageViewPage extends StatefulWidget {
  final PageStorageKey<String> storageKey;

  const PageViewPage({super.key, required this.storageKey});

  @override
  State<PageViewPage> createState() => _PageViewPageState();
}

class _PageViewPageState extends State<PageViewPage> {
  final PageController _pageController = PageController();
  bool horizontalEksen = true;
  bool verticalEksen = false;
  bool isSnap = true;
  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: PageView(
            scrollDirection: horizontalEksen ?  Axis.horizontal :  Axis.vertical,
            pageSnapping: isSnap,
            onPageChanged: (index) {
              debugPrint('Page changed to $index');
            } ,
            children: [
              Container(
                height: 100,
                width: double.infinity,
                color: Colors.red,
                child: Center(
                  child: Text('Page 1'),
                ),
              ),
                 Container(
                height: 100,
                width: double.infinity,
                color: Colors.blue,
                child: Center(
                  child: Text('Page 2'),
                ),
              ),
                 Container(
                height: 100,
                width: double.infinity,
                color: Colors.green,
                child: Center(
                  child: Text('Page 3'),
                ),
              ),
            ],
          ),
        ),
        Expanded(
            child: Container(
          height: 100,
          width: double.infinity,
          color: Colors.grey,
          child: Column(
            children: [
              Row(
                children: [
                  Text("Yatay eksende çalış"),
                  Switch(value: horizontalEksen, onChanged: (value) {
                    setState(() {
                      horizontalEksen = value;
                    });
                  }), 
                  Text("Dikey eksende çalış"),
                  Switch(value: verticalEksen, onChanged: (value) {
                    setState(() {
                      verticalEksen = value;
                    });
                  }), 
                ],
              ),
              Row(
                children: [
                  Text("Sayfa sıkıştırma"),
                  Switch(value: isSnap, onChanged: (value) {
                    setState(() {
                      isSnap = value;
                    });
                  }),
                ],
              )
            ],
          ),
        )),
      ],
    );
  }
}
