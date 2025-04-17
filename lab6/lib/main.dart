import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Калькулятор площади',
      theme: ThemeData(
        primarySwatch: Colors.green,
      ),
      home: const AreaCalculator(),
    );
  }
}

class AreaCalculator extends StatefulWidget {
  const AreaCalculator({Key? key}) : super(key: key);

  @override
  _AreaCalculatorState createState() => _AreaCalculatorState();
}

class _AreaCalculatorState extends State<AreaCalculator> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  String _result = '';

  void _calculateArea() {
    if (_formKey.currentState!.validate()) {
      double width = double.parse(_widthController.text);
      double height = double.parse(_heightController.text);
      double area = width * height;

      setState(() {
        _result = 'S = $width × $height = $area';
      });

      // Всплывающее уведомление при успешном вычислении
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Форма успешно заполнена'),
          backgroundColor: Colors.green,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Калькулятор площади'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Ширина
              TextFormField(
                controller: _widthController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Ширина'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите ширину';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите числовое значение';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Высота
              TextFormField(
                controller: _heightController,
                keyboardType: TextInputType.number,
                decoration: const InputDecoration(labelText: 'Высота'),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Введите высоту';
                  }
                  if (double.tryParse(value) == null) {
                    return 'Введите числовое значение';
                  }
                  return null;
                },
              ),
              const SizedBox(height: 16),
              // Кнопка для вычисления площади
              ElevatedButton(
                onPressed: _calculateArea,
                child: const Text('Вычислить'),
              ),
              const SizedBox(height: 16),
              // Результат
              Text(
                _result,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
