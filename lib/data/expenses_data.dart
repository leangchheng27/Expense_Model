import '../model/expense_model.dart';

List<Expense> dummyExpenses = [
  Expense(
    title: 'Flutter Course',
    amount: 19.99,
    date: DateTime.now(),
    category: Category.work,
  ),
  Expense(
    title: 'Cinema',
    amount: 15.69,
    date: DateTime.now(),
    category: Category.leisure,
  ),
  Expense(
    title: 'Groceries',
    amount: 82.12,
    date: DateTime.now(),
    category: Category.food,
  ),  
  Expense(
    title: 'New Shoes',
    amount: 69.99,
    date: DateTime.now(),
    category: Category.travel,
  ),
];