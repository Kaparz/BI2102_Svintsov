import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lists Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ListsHome(),
    );
  }
}

class ListsHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: Text('Lists Demo'),
          bottom: TabBar(
            tabs: [
              Tab(text: 'Simple List'),
              Tab(text: 'Infinite List'),
              Tab(text: 'Math List'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            SimpleList(),
            InfiniteList(),
            InfiniteMathList(),
          ],
        ),
      ),
    );
  }
}

// Простой список
class SimpleList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(
      children: <Widget>[
        ListTile(title: Text('Элемент 1')),
        ListTile(title: Text('Элемент 2')),
        ListTile(title: Text('Элемент 3')),
      ],
    );
  }
}

// Бесконечный список со строками
class InfiniteList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: null, // бесконечный список
      itemBuilder: (context, i) {
        return ListTile(title: Text('Строка ${i + 1}'));
      },
    );
  }
}

// Бесконечный список с возведением числа 2 в степень
class InfiniteMathList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: null, // бесконечный список
      itemBuilder: (context, i) {
        return ListTile(title: Text('2^${i + 1} = ${pow(2, i + 1)}'));
      },
    );
  }
}