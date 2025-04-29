import 'package:flutter/material.dart';
import '../coffee_machine_state.dart';

class SettingsPage extends StatelessWidget {
  final CoffeeMachineState coffeeMachineState;

  const SettingsPage({super.key, required this.coffeeMachineState});

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
          Text('Вода: ${coffeeMachineState.water} мл'),
          ElevatedButton(onPressed: () {
            coffeeMachineState.addWater();
          }, child: const Text('Добавить воду')),
          const SizedBox(height: 16),
          Text('Молоко: ${coffeeMachineState.milk} мл'),
          ElevatedButton(onPressed: () {
            coffeeMachineState.addMilk();
          }, child: const Text('Добавить молоко')),
          const SizedBox(height: 16),
          Text('Зерна: ${coffeeMachineState.beans} г'),
          ElevatedButton(onPressed: () {
            coffeeMachineState.addBeans();
          }, child: const Text('Добавить зерна')),
        ],
      ),
    );
  }
}
