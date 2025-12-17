import 'package:flutter/material.dart';
import '../../model/expense_model.dart';

class CategorySummary extends StatelessWidget {
  const CategorySummary({super.key, required this.expenses});

  final List<Expense> expenses;

  double _getCategoryTotal(Category category) {
    return expenses
        .where((expense) => expense.category == category)
        .fold(0.0, (sum, expense) => sum + expense.amount);
  }

  IconData _getCategoryIcon(Category category) {
    switch (category) {
      case Category.food:
        return Icons.free_breakfast;
      case Category.travel:
        return Icons.travel_explore;
      case Category.leisure:
        return Icons.holiday_village;
      case Category.work:
        return Icons.work;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: Category.values.map((category) {
          final total = _getCategoryTotal(category);
          return Column(
            children: [
              Text(
                '\$${total.toStringAsFixed(2)}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Icon(_getCategoryIcon(category), size: 28),
            ],
          );
        }).toList(),
      ),
    );
  }
}
