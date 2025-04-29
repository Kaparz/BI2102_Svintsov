import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'coffee_machine_state.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: MainPage(coffeeMachineState: CoffeeMachineState()),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MainPage extends StatefulWidget {
  final CoffeeMachineState coffeeMachineState;

  const MainPage({super.key, required this.coffeeMachineState});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
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
        body: TabBarView(
          children: [
            CoffeeHomePage(coffeeMachineState: widget.coffeeMachineState),
            SettingsPage(coffeeMachineState: widget.coffeeMachineState),
          ],
        ),
      ),
    );
  }
}
