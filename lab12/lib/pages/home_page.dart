import 'package:flutter/material.dart';
import '../async_methods.dart'; // Импортируем асинхронные методы

class CoffeeHomePage extends StatefulWidget {
  const CoffeeHomePage({super.key});

  @override
  State<CoffeeHomePage> createState() => _CoffeeHomePageState();
}

class _CoffeeHomePageState extends State<CoffeeHomePage> {
  String status = 'Готов к приготовлению';

  // Асинхронные методы для приготовления кофе
  Future<void> _makeCoffee() async {
    setState(() {
      status = 'Нагреваю воду...';
    });
    await heatWater(); // Вызываем асинхронный метод

    setState(() {
      status = 'Завариваю кофе...';
    });
    await brewCoffee(); // Вызываем асинхронный метод

    setState(() {
      status = 'Взбиваю молоко...';
    });
    await frothMilk(); // Вызываем асинхронный метод

    setState(() {
      status = 'Смешиваю кофе с молоком...';
    });
    await mixCoffeeAndMilk(); // Вызываем асинхронный метод

    setState(() {
      status = 'Кофе готово!';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Выберите кофе:',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _makeCoffee,
            child: const Text('Приготовить кофе'),
          ),
          const SizedBox(height: 20),
          Text(
            status,
            style: const TextStyle(fontSize: 18, color: Colors.green),
          ),
        ],
      ),
    );
  }
}
