import 'package:flutter/material.dart';
import '../coffee_machine_state.dart';

class SettingsPage extends StatefulWidget {
  final CoffeeMachineState coffeeMachineState;

  const SettingsPage({super.key, required this.coffeeMachineState});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  // Поля ввода
  String waterInput = '';
  String milkInput = '';
  String beansInput = '';

  void _addResources() {
    // Вода
    if (waterInput.isNotEmpty) {
      final amount = int.tryParse(waterInput);
      if (amount != null && amount > 0) {
        widget.coffeeMachineState.addWaterCustom(amount);
      }
    }

    // Молоко
    if (milkInput.isNotEmpty) {
      final amount = int.tryParse(milkInput);
      if (amount != null && amount > 0) {
        widget.coffeeMachineState.addMilkCustom(amount);
      }
    }

    // Зерна
    if (beansInput.isNotEmpty) {
      final amount = int.tryParse(beansInput);
      if (amount != null && amount > 0) {
        widget.coffeeMachineState.addBeansCustom(amount);
      }
    }

    // Очистка полей после добавления
    setState(() {
      waterInput = '';
      milkInput = '';
      beansInput = '';
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Ресурсы добавлены')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Настройки кофемашины',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),

          // Поле для воды
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Вода (мл)'),
            onChanged: (value) => waterInput = value,
            controller: TextEditingController(text: waterInput),
          ),

          const SizedBox(height: 16),

          // Поле для молока
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Молоко (мл)'),
            onChanged: (value) => milkInput = value,
            controller: TextEditingController(text: milkInput),
          ),

          const SizedBox(height: 16),

          // Поле для зёрен
          TextField(
            keyboardType: TextInputType.number,
            decoration: const InputDecoration(labelText: 'Зерна (г)'),
            onChanged: (value) => beansInput = value,
            controller: TextEditingController(text: beansInput),
          ),

          const SizedBox(height: 24),

          // Одна общая кнопка
          ElevatedButton.icon(
            onPressed: _addResources,
            icon: const Icon(Icons.add),
            label: const Text('Добавить всё'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.brown,
            ),
          ),
        ],
      ),
    );
  }
}
