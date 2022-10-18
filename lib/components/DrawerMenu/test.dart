import 'package:flutter/material.dart';

class Testy extends StatefulWidget {
  const Testy({super.key});

  @override
  State<Testy> createState() => _TestyState();
}

class _TestyState extends State<Testy> {
  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
        headerSliverBuilder: (context, value) {
          return [
            SliverAppBar(
              title: Text('AppBar'),
              pinned: true,
              floating: true,
              bottom: TabBar(
                tabs: [
                  Tab(icon: Icon(Icons.call), text: 'Call'),
                  Tab(icon: Icon(Icons.message), text: 'Message'),
                ],
              ),
            ),
          ];
        },
        body: TabBarView(
          children: [
            FlutterLogo(),
            FlutterLogo(),
          ],
        ),
      ),
    );
  }
}
