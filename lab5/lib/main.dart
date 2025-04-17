import 'package:flutter/material.dart';
import 'dart:math';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Lists Demo',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const ListsHome(),
    );
  }
}

class ListsHome extends StatelessWidget {
  const ListsHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Lists Demo'),
          bottom: const TabBar(
            tabs: [
              Tab(text: 'Простой список'),
              Tab(text: 'Бесконечный список'),
              Tab(text: '2^N список'),
            ],
          ),
        ),
        body: const TabBarView(
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
  const SimpleList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      children: const [
        Text('0000'),
        Divider(),
        Text('0001'),
        Divider(),
        Text('0010'),
      ],
    );
  }
}

// Бесконечный список со строками
class InfiniteList extends StatelessWidget {
  const InfiniteList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: null, // Бесконечный список
      itemBuilder: (context, index) {
        return Column(
          children: [
            ListTile(
              title: Text('Строка ${index + 1}'),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}

// Бесконечный список с возведением числа 2 в степень
class InfiniteMathList extends StatelessWidget {
  const InfiniteMathList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: null, // Бесконечный список
      itemBuilder: (context, index) {
        BigInt value = BigInt.from(2).pow(index + 1); // Вычисление 2^N
        return Column(
          children: [
            ListTile(
              title: Text('2^${index + 1} = $value'),
            ),
            const Divider(),
          ],
        );
      },
    );
  }
}
