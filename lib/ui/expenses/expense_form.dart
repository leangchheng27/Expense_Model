import 'package:flutter/material.dart';
import '../../model/expense_model.dart';
import 'package:flutter/services.dart';

class ExpenseForm extends StatefulWidget {
  const ExpenseForm({super.key, required this.onAddExpense});

  final void Function(Expense expense) onAddExpense;

  @override
  State<ExpenseForm> createState() => _ExpenseFormState();
}

class _ExpenseFormState extends State<ExpenseForm> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  Category _selectedCategory = Category.food;

  @override
  void dispose() {
    _titleController.dispose();
    _amountController.dispose();
    super.dispose();
  }
  void _submitExpense() {
    final enteredAmount = double.tryParse(_amountController.text);
    final amountIsInvalid = enteredAmount == null || enteredAmount <= 0;

    if (_titleController.text.trim().isEmpty || amountIsInvalid) {
      showDialog(
        context: context,
        builder: (ctx) => AlertDialog(
          title: const Text('Invalid input'),
          content: const Text('Please enter a valid title and amount.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('OK'),
            ),
          ],
        ),
      );
      return;
    }

    final newExpense = Expense(
      title: _titleController.text,
      amount: enteredAmount,
      date: DateTime.now(),
      category: _selectedCategory,
    );

    widget.onAddExpense(newExpense);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        TextField(
          controller: _titleController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Title',
            hintText: 'Enter expense title',
          ),
        ),
        const SizedBox(height: 16),
        TextField(
          controller: _amountController,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Amount',
            hintText: 'Enter amount',
            prefixText: '\$ ',
          ),
          keyboardType: TextInputType.number,
          inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        ),
        const SizedBox(height: 16),
        DropdownButtonFormField<Category>(
          initialValue: _selectedCategory,
          decoration: InputDecoration(
            border: OutlineInputBorder(),
            labelText: 'Category',
          ),
          items: Category.values.map((category) {
            return DropdownMenuItem(
              value: category,
              child: Text(category.name.toUpperCase()),
            );
          }).toList(),
          onChanged: (value) {
            if (value != null) {
              setState(() {
                _selectedCategory = value;
              });
            }
          },
        ),
        const SizedBox(height: 64),
         SizedBox(
          width: double.infinity,
          child: ElevatedButton(
            onPressed: _submitExpense,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.blue[700],
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: const Text(
              'Add Expense',
              style: TextStyle(fontSize: 16, color: Colors.white),
            ),
        ),
        )
        
      ],
    );
  }
}