import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

enum ExpenseType {food, travel, leisure, work}

const categoryIcons = {
  ExpenseType.food: Icons.fastfood,
  ExpenseType.travel: Icons.flight,
  ExpenseType.leisure: Icons.movie,
  ExpenseType.work: Icons.work,
};

class Expense{
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final ExpenseType category;

  Expense({
    required this.title,
    required this.amount,
    required this.date,
    required this.category,
  }) : id = Uuid().v4();

  String get formattedDate{
    return DateFormat.yMd().format(date);
  }
}