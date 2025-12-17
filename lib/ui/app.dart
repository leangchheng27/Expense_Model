import 'package:flutter/material.dart';
import 'expenses/expense.dart';
import 'expenses/category_summary.dart';
import 'expenses/expense_form.dart';
import '../model/expense_model.dart';
import '../data/expenses_data.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  final List<Expense> _expenses = List.from(dummyExpenses);

  void _addExpense(Expense expense) {
    setState(() {
      _expenses.add(expense);
    });
  }

  void _deleteExpense(Expense expense) {
    setState(() {
      _expenses.remove(expense);
    });
    
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Text('Expense deleted'),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: 'Undo',
          onPressed: () {
            setState(() {
              _expenses.add(expense); 
            });
          },
        ),
      ),
    );
  }

  void openAddExpenseOverlay(BuildContext context) {
    showModalBottomSheet(
      isScrollControlled: true,
      context: context,
      builder: (context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom + 16,
                top: 30,
                left: 16,
                right: 16,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Add new Expense',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  Container(
                    margin: const EdgeInsets.only(bottom: 20),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: const Text(
                        'Close',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                width: double.infinity,
                child: ExpenseForm(onAddExpense: _addExpense),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text('MyExpense App'),
        actions: [
          IconButton(
            icon: const Icon(Icons.add),
            onPressed: () => openAddExpenseOverlay(context),
          ),
        ],
      ),
      body: Column(
        children: [
          CategorySummary(expenses: _expenses),
          Expanded(
            child: _expenses.isEmpty
                ? Center(
                    child: Text(
                      'No expenses found. Start adding some!',
                      style: TextStyle(fontSize: 18, color: Colors.grey[600]),
                    ),
                  )
                : ExpensesView(
                    expenses: _expenses,
                    onDeleteExpense: _deleteExpense,
                  ),
          ),
        ],
      ),
    );
  }
}
