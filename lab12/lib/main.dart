import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const MainPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2, // Количество вкладок
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Кофемашина'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.coffee), text: 'Главная'),
              Tab(icon: Icon(Icons.settings), text: 'Настройки'),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            CoffeeHomePage(), // Страница с кофемашиной
            SettingsPage(), // Страница с настройками
          ],
        ),
      ),
    );
  }
}
