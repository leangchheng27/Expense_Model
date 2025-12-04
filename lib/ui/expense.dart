import 'package:flutter/material.dart';
import '../model/expense_model.dart';

class Expenses extends StatefulWidget {
  const Expenses({super.key});

  @override
  State<Expenses> createState() => _ExpensesState();
}

class _ExpensesState extends State<Expenses> {
  final List<Expense> _registeredExpenses = [
    Expense(
      title: 'Flutter Course',
      amount: 19.99,
      date: DateTime.now(),
      category: ExpenseType.work,
    ),
    Expense(
      title: 'Dart App',
      amount: 15.69,
      date: DateTime.now(),
      category: ExpenseType.leisure,
    ),
    Expense(
      title: 'JS App',
      amount: 15.69,
      date: DateTime.now(),
      category: ExpenseType.leisure,
    ),
    Expense(
      title: 'C App',
      amount: 15.69,
      date: DateTime.now(),
      category: ExpenseType.leisure,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[100],
      appBar: AppBar(
        backgroundColor: Colors.blue[700],
        title: const Text('Ronan-The-Best Expenses App'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.add),
            tooltip: 'Add Button',
            onPressed: () {
              addOnClicked(context);
            },
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              padding: const EdgeInsets.all(15.0),
              itemCount: _registeredExpenses.length,
              itemBuilder: (context, index) =>
                  ExpenseItem(expense: _registeredExpenses[index]),
            ),
          ),
        ],
      ),
    );
  }

  void addOnClicked(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 500,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              mainAxisSize: MainAxisSize.min,
              children: <Widget>[
                const Text('Add New Expense'),
                const SizedBox(height: 20),
                MyCustomForm(onAddExpense: _addExpense)
              ],
            ),
          ),
        );
      },
    );
  }

  void _addExpense(Expense newExpense) {
    setState(() {
      _registeredExpenses.add(newExpense);
    });
    Navigator.pop(context);
  }
}


class ExpenseItem extends StatelessWidget {
  final Expense expense;

  const ExpenseItem({super.key, required this.expense});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    expense.title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    '\$${expense.amount.toStringAsFixed(2)}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ),
            Row(
              children: [
                Icon(categoryIcons[expense.category], size: 24),
                const SizedBox(width: 10),
                Text(
                  expense.formattedDate,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}


// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  final Function(Expense) onAddExpense;

  const MyCustomForm({super.key, required this.onAddExpense});

  @override
  State<MyCustomForm> createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  @override
  void dispose() {
    titleController.dispose();
    amountController.dispose();
    super.dispose();
  }

  void _submitExpense() {
    if (titleController.text.isEmpty || amountController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    final newExpense = Expense(
      title: titleController.text,
      amount: double.parse(amountController.text),
      date: DateTime.now(),
      category: ExpenseType.work,
    );

    widget.onAddExpense(newExpense);
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Title
          TextField(
            controller: titleController,
            decoration: InputDecoration(
              hintText: 'Title',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 16),
          // Amount
          TextField(
            controller: amountController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Price',
              border: OutlineInputBorder(),
            ),
          ),
          const SizedBox(height: 24),
          // Submit Button
          Center(
            child: ElevatedButton(
              onPressed: _submitExpense,
              child: const Text('Add Expense'),
            ),
          ),
        ],
      ),
    );
  }
}