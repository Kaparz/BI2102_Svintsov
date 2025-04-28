import 'package:flutter/material.dart';

class Machine {
  int water = 0;
  int coffeeBeans = 0;
  int milk = 0;
  double cash = 0;

  bool isAvailable() => water >= 50 && coffeeBeans >= 20;

  void makeCoffee() { 
    if (!isAvailable()) return;
    water -= 50;
    coffeeBeans -= 20;
    cash += 2.5;
  }

  String getStatus() {
    return '''
    Вода: $water мл
    Зёрна: $coffeeBeans г
    Молоко: $milk мл
    Касса: \$$cash
    ''';
  }
}

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кофемашина',
      theme: ThemeData(primarySwatch: Colors.brown),
      home: const CoffeeHomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CoffeeHomePage extends StatefulWidget {
  const CoffeeHomePage({super.key});

  @override
  State<CoffeeHomePage> createState() => _CoffeeHomePageState();
}

class _CoffeeHomePageState extends State<CoffeeHomePage> {
  final Machine machine = Machine();
  String status = '';

  void _makeEspresso() {
    setState(() {
      machine.makeCoffee();
      status = machine.isAvailable()
          ? 'Эспрессо готов!'
          : 'Недостаточно воды или зёрен';
    });
  }

  void _addResources() {
    setState(() {
      machine.water += 300;
      machine.coffeeBeans += 150;
      machine.milk += 100;
      status = 'Ресурсы добавлены';
    });
  }

  void _resetCash() {
    setState(() {
      machine.cash = 0;
      status = 'Касса обнулена';
    });
  }

  void _showStatus() {
    setState(() {
      status = machine.getStatus();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кофемашина')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text('Выберите действие:', 
                style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                  onPressed: _makeEspresso,
                  child: const Text('Эспрессо')),
                ElevatedButton(
                  onPressed: _addResources,
                  child: const Text('Пополнить')),
                ElevatedButton(
                  onPressed: _resetCash,
                  child: const Text('Обнулить')),
                ElevatedButton(
                  onPressed: _showStatus,
                  child: const Text('Статус')),
              ],
            ),
            const SizedBox(height: 20),
            Text(status, 
                style: const TextStyle(
                  fontSize: 18,
                  color: Colors.green,
                  fontWeight: FontWeight.w500
                ))
          ],
        ),
      ),
    );
  }
}
