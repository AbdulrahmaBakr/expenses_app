import 'package:expenses_app/model/expense_model.dart';
import 'package:flutter/material.dart';

class Expeses extends StatelessWidget {
  const Expeses({
    super.key,
    required this.expense,
    required this.removeExpenses,
  });

  final List<Expense> expense;
  final void Function(Expense expense) removeExpenses;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        itemCount: expense.length,
        itemBuilder: (context, index) => Dismissible(
          key: ValueKey(expense[index]),
          onDismissed: (direction) => removeExpenses(expense[index]),
          child: Card(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: Column(
                children: [
                  Text(expense[index].title),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('\$ ${expense[index].amount.toStringAsFixed(2)}'),
                      Row(
                        children: [
                          Icon(categoryIcons[expense[index].category]),
                          const SizedBox(
                            width: 10,
                          ),
                          Text(expense[index].formatDate),
                        ],
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
