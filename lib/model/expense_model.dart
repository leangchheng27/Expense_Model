import 'package:uuid/uuid.dart';
const uuid = Uuid();

enum Category { food, travel, leisure, work}
 
class Expense {
  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = uuid.v4();

  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
}

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