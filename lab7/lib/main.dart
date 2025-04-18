import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Навигация и передача данных',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      // Определяем маршруты
      routes: {
        '/': (context) => const FirstScreen(),
        '/second': (context) => const SecondScreen(),
      },
    );
  }
}

// Первый экран
class FirstScreen extends StatelessWidget {
  const FirstScreen({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Возвращение значения'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                // Переход на второй экран
                final result = await Navigator.pushNamed(context, '/second');
                if (result != null) {
                  // Показать всплывающее уведомление с результатом
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Вы выбрали: $result'),
                    ),
                  );
                }
              },
              child: const Text('Перейти к выбору'),
            ),
          ],
        ),
      ),
    );
  }
}

// Второй экран
class SecondScreen extends StatelessWidget {
  const SecondScreen({Key? key}) : super(key: key);

  @override 
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Выберите любой вариант'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                // Возвращаем "Да" на первый экран
                Navigator.pop(context, 'Да');
              },
              child: const Text('Да'),
            ),
            const SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                // Возвращаем "Нет" на первый экран
                Navigator.pop(context, 'Нет');
              },
              child: const Text('Нет'),
            ),
          ],
        ),
      ),
    );
  }
}
