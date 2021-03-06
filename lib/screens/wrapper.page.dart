import 'package:flutter/material.dart';

import 'Library/library.page.dart';
import 'Home/home.page.dart';

class Wrapper extends StatefulWidget {
  @override
  _WrapperState createState() => _WrapperState();
}

class _WrapperState extends State<Wrapper> with TickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    final _body = Container(
      width: MediaQuery.of(context).size.width,
      height: MediaQuery.of(context).size.height,
      alignment: Alignment.center,
      child: TabBarView(
        children: [
          HomePage(),
          LibraryPage(),
        ],
      ),
    );
    final _bottomNavigationBar = TabBar(
      tabs: [
        Tab(
          icon: new Icon(Icons.home_outlined),

        ),
        Tab(
          icon: new Icon(Icons.library_books_outlined)
        ),
      ],
      labelColor: Colors.white,
      unselectedLabelColor: Colors.white38,
      automaticIndicatorColorAdjustment: true,
      indicatorSize: TabBarIndicatorSize.label,
      // indicatorPadding: EdgeInsets.all(5.0),
      indicatorColor: Colors.white,
    );

    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: _body,
          bottomNavigationBar: _bottomNavigationBar,
          backgroundColor: Theme.of(context).accentColor
      ),
    );
  }
}
