import 'package:flutter/material.dart';
import '../async_methods.dart';
import '../coffee_machine_state.dart';

class CoffeeHomePage extends StatefulWidget {
  final CoffeeMachineState coffeeMachineState;

  const CoffeeHomePage({super.key, required this.coffeeMachineState});

  @override
  State<CoffeeHomePage> createState() => _CoffeeHomePageState();
}

class _CoffeeHomePageState extends State<CoffeeHomePage> {
  String selectedCoffee = '';
  bool isMakingCoffee = false;
  String _cashInput = '';

  Future<void> _makeCoffee() async {
    if (selectedCoffee.isEmpty) {
      _showSnackBar('Выберите кофе!');
      return;
    }

    if (!widget.coffeeMachineState.hasEnoughIngredients(selectedCoffee)) {
      _showSnackBar('Недостаточно ингредиентов!');
      return;
    }

    setState(() {
      isMakingCoffee = true;
    });

    await heatWater();
    await brewCoffee();
    await frothMilk();
    await mixCoffeeAndMilk();

    widget.coffeeMachineState.useIngredients(selectedCoffee);

    _showSnackBar('$selectedCoffee готово!');

    setState(() {
      isMakingCoffee = false;
    });
  }

  void _addMoney(int amount) {
    setState(() {
      widget.coffeeMachineState.cash += amount;
    });
  }

  void _selectCoffee(String coffee) {
    setState(() {
      selectedCoffee = coffee;
    });
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(message)));
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
          CoffeeSelectionButton(
            coffeeName: 'Эспрессо',
            onSelect: () => _selectCoffee('Эспрессо'),
            isSelected: selectedCoffee == 'Эспрессо',
          ),
          CoffeeSelectionButton(
            coffeeName: 'Капучино',
            onSelect: () => _selectCoffee('Капучино'),
            isSelected: selectedCoffee == 'Капучино',
          ),
          CoffeeSelectionButton(
            coffeeName: 'Латте',
            onSelect: () => _selectCoffee('Латте'),
            isSelected: selectedCoffee == 'Латте',
          ),
          const SizedBox(height: 20),
          ElevatedButton(
            onPressed: isMakingCoffee ? null : _makeCoffee,
            child: const Text('Приготовить кофе'),
          ),
          const SizedBox(height: 20),
          Text('Наличка: \$${widget.coffeeMachineState.cash.toStringAsFixed(2)}'),
          // В build методе, заменяем старый TextField этим кодом:
Row(
  children: [
    Expanded(
      child: TextField(
        decoration: const InputDecoration(
          labelText: 'Введите сумму для пополнения',
          suffixIcon: Icon(Icons.attach_money),
        ),
        keyboardType: TextInputType.numberWithOptions(decimal: true),
        onChanged: (value) {
          _cashInput = value;
        },
        controller: TextEditingController(text: _cashInput),
      ),
    ),
    const SizedBox(width: 8),
    ElevatedButton(
      onPressed: () {
        if (_cashInput.isNotEmpty) {
          final parsed = double.tryParse(_cashInput);
          if (parsed != null && parsed > 0) {
            widget.coffeeMachineState.addMoney(parsed.toInt());
            setState(() {
              _cashInput = '';
            });
          } else {
            _showSnackBar('Введите корректную сумму');
          }
        } else {
          _showSnackBar('Введите сумму');
        }
      },
      child: const Icon(Icons.add),
    ),
  ],
),
          const SizedBox(height: 20),
          Text('Вода: ${widget.coffeeMachineState.water} мл'),
          Text('Молоко: ${widget.coffeeMachineState.milk} мл'),
          Text('Зерна: ${widget.coffeeMachineState.beans} г'),
          Text('Баланс: ${widget.coffeeMachineState.balance} \$')
        ],
      ),
    );
  }
}

class CoffeeSelectionButton extends StatelessWidget {
  final String coffeeName;
  final VoidCallback onSelect;
  final bool isSelected;

  const CoffeeSelectionButton({
    super.key,
    required this.coffeeName,
    required this.onSelect,
    required this.isSelected,
  });

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: onSelect,
      style: ElevatedButton.styleFrom(
        backgroundColor: isSelected ? Colors.brown[800] : Colors.brown,
      ),
      child: Text(coffeeName),
    );
  }
}
