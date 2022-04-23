import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:example/model/functionality_data.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MyCustomBottomNavigationBar extends StatefulWidget {
  const MyCustomBottomNavigationBar({Key key}) : super(key: key);

  @override
  _MyCustomBottomNavigationBarState createState() =>
      _MyCustomBottomNavigationBarState();
}

class _MyCustomBottomNavigationBarState
    extends State<MyCustomBottomNavigationBar> {
  @override
  Widget build(BuildContext context) {
    return Consumer<FunctionalityData>(
      builder: (context, data, child) => BottomAppBar(
        child: CurvedNavigationBar(
          onTap: (value) {
            setState(() {
              data.changeIndexValue(value);
            });
          },
          index: data.currentIndex,
          backgroundColor: const Color.fromRGBO(3, 83, 151, 1),
          items: const [
            Icon(Icons.storage),
            Icon(Icons.home),
            Icon(Icons.library_books),
          ],
        ),
      ),
    );
  }
}
