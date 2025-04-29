import 'package:flutter/material.dart';

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

// Класс кофемашины
class Machine {
  int water = 300;
  int coffeeBeans = 150;
  int milk = 100;
  double cash = 0;

  bool isAvailable(CoffeeType type) {
    return water >= type.water &&
           coffeeBeans >= type.beans &&
           milk >= type.milk;
  }

  void makeCoffeeByType(CoffeeType type) {
    if (!isAvailable(type)) return;
    water -= type.water;
    coffeeBeans -= type.beans;
    milk -= type.milk;
    cash += type.price;
  }

  void fillResources({int beans = 0, int milk = 0, int water = 0}) {
    this.water += water;
    this.coffeeBeans += beans;
    this.milk += milk;
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

// Класс типа кофе
class CoffeeType {
  final int water;
  final int beans;
  final int milk;
  final double price;

  CoffeeType({required this.water, required this.beans, required this.milk, required this.price});
}

// Примеры кофе
final espresso = CoffeeType(water: 50, beans: 20, milk: 0, price: 2.5);
final cappuccino = CoffeeType(water: 100, beans: 25, milk: 50, price: 3.5);
final americano = CoffeeType(water: 120, beans: 20, milk: 0, price: 3.0);

class CoffeeHomePage extends StatefulWidget {
  const CoffeeHomePage({super.key});
  @override
  State<CoffeeHomePage> createState() => _CoffeeHomePageState();
}

class _CoffeeHomePageState extends State<CoffeeHomePage> {
  final Machine machine = Machine();
  String status = '';

  void _makeCoffee(CoffeeType type, String name) {
    setState(() {
      if (machine.isAvailable(type)) {
        machine.makeCoffeeByType(type);
        status = '$name приготовлен!';
      } else {
        status = 'Недостаточно ресурсов для $name';
      }
    });
  }

  void _addResources() {
    setState(() {
      machine.fillResources(beans: 150, milk: 100, water: 300);
      status = 'Ресурсы пополнены';
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
            Text('Выберите действие:', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 16),
            Wrap(
              spacing: 10,
              runSpacing: 10,
              children: [
                ElevatedButton(
                    onPressed: () => _makeCoffee(espresso, 'Эспрессо'),
                    child: const Text('Эспрессо')),
                ElevatedButton(
                    onPressed: () => _makeCoffee(cappuccino, 'Капучино'),
                    child: const Text('Капучино')),
                ElevatedButton(
                    onPressed: () => _makeCoffee(americano, 'Американо'),
                    child: const Text('Американо')),
                ElevatedButton(
                    onPressed: _addResources,
                    child: const Text('Пополнить ресурсы')),
                ElevatedButton(
                    onPressed: _resetCash,
                    child: const Text('Обнулить деньги')),
                ElevatedButton(
                    onPressed: _showStatus,
                    child: const Text('Показать статус')),
              ],
            ),
            const SizedBox(height: 20),
            Text(
              status,
              style: const TextStyle(fontSize: 18, color: Colors.green),
            ),
          ],
        ),
      ),
    );
  }
}
