class CoffeeMachineState {
  int water = 500; // мл
  int milk = 900;  // мл
  int beans = 200; // грамм
  int balance = 0;
  int cash = 0;

  void addWater() => water += 100;
  void addMilk() => milk += 100;
  void addBeans() => beans += 50;

  // Проверяет, достаточно ли ингредиентов для выбранного кофе
  bool hasEnoughIngredients(String coffeeType) {
    final needed = _getNeededIngredients(coffeeType);
    return water >= needed['water']! &&
           milk >= needed['milk']! &&
           beans >= needed['beans']! &&
           cash >= needed['cash']!;
  }

  // Списывает ингредиенты
  void useIngredients(String coffeeType) {
    final needed = _getNeededIngredients(coffeeType);
    water -= needed['water']!;
    milk -= needed['milk']!;
    beans -= needed['beans']!;
    balance += needed['cash']!;
    cash -= needed['cash']!;
  }

  Map<String, int> _getNeededIngredients(String coffeeType) {
    switch (coffeeType) {
      case 'Эспрессо':
        return {'water': 30, 'milk': 0, 'beans': 8, 'cash': 2 };
      case 'Капучино':
        return {'water': 30, 'milk': 100, 'beans': 8, 'cash': 4};
      case 'Латте':
        return {'water': 30, 'milk': 150, 'beans': 8, 'cash': 5};
      default:
        return {'water': 0, 'milk': 0, 'beans': 0, 'cash': 0};
    }
  }
}
