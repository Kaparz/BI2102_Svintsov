import 'dart:async';

Future<void> heatWater() async {
  print('Нагрев воды...');
  await Future.delayed(Duration(seconds: 3));
  print('Вода нагрета.');
}

Future<void> brewCoffee() async {
  print('Завариваем кофе...');
  await Future.delayed(Duration(seconds: 5));
  print('Кофе заварен.');
}

Future<void> frothMilk() async {
  print('Взбиваем молоко...');
  await Future.delayed(Duration(seconds: 5));
  print('Молоко взбито.');
}

Future<void> mixCoffeeAndMilk() async {
  print('Смешиваем кофе и молоко...');
  await Future.delayed(Duration(seconds: 3));
  print('Кофе с молоком готов.');
}
