import 'package:expenses_app/model/expense_model.dart';
import 'package:expenses_app/widget/add_expense.dart';
import 'package:expenses_app/widget/expenses.dart';
import 'package:flutter/material.dart';

class ExpensesScreen extends StatefulWidget {
  const ExpensesScreen({super.key});

  @override
  State<ExpensesScreen> createState() => _ExpensesWidgetState();
}

class _ExpensesWidgetState extends State<ExpensesScreen> {
  final List<Expense> expense = [
    Expense(
      category: Category.food,
      title: 'fish',
      amount: 23,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.traverl,
      title: 'assiut',
      amount: 250,
      date: DateTime.now(),
    ),
    Expense(
      category: Category.work,
      title: 'flutter',
      amount: 300,
      date: DateTime.now(),
    ),
  ];

  //funcation to add new expense
  void _addExpense(Expense addExpense) {
    setState(() {
      expense.add(addExpense);
    });
  }

  void _removeExpense(Expense addExpense) {
    setState(() {
      expense.remove(addExpense);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        elevation: 0,
        foregroundColor: Colors.blue,
        backgroundColor: Colors.transparent,
        centerTitle: true,
        title: const Text('Expenses'),
        actions: [
          IconButton(
            onPressed: () {
              showModalBottomSheet(
                isScrollControlled: true,
                context: context,
                builder: (e) => Padding(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: AddExpense(addnewExpenses: _addExpense),
                ),
              );
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [Expeses(expense: expense, removeExpenses: _removeExpense)],
        ),
      ),
    );
  }
}
