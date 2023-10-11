import 'dart:developer';

import 'package:expenses_app/model/expense_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class AddExpense extends StatefulWidget {
  const AddExpense({
    super.key,
    required this.addnewExpenses,
  });

  final void Function(Expense expense) addnewExpenses;

  @override
  State<AddExpense> createState() => _AddExpenseState();
}

class _AddExpenseState extends State<AddExpense> {
  var titleController = TextEditingController();
  var amountController = TextEditingController();
  DateTime? datePicker;
  Category currentCategory = Category.entertainmint;
  var format = DateFormat().add_yMEd();

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    amountController.dispose();
  }

  void validation() {
    final double? amount = double.tryParse(amountController.text);
    final bool isAmountValid = amount == null || amount <= 0;
    if (titleController.text.trim().isEmpty ||
        isAmountValid ||
        datePicker == null) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Error'),
            content: const Text('Empty Field || amount = 0 || date is null '),
            actions: [
              TextButton(
                style: TextButton.styleFrom(
                  textStyle: Theme.of(context).textTheme.labelLarge,
                ),
                child: const Text('Disable'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    } else {
      //to use fun initilaize in other class use widget ;
      widget.addnewExpenses(
        Expense(
            category: currentCategory,
            title: titleController.text,
            amount: double.tryParse(amountController.text)!,
            date: datePicker!),
      );
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
          child: TextField(
            controller: titleController,
            maxLength: 30,
            decoration: const InputDecoration(
              label: Text('Title'),
              border: OutlineInputBorder(),
              hintText: 'Add new Expense',
            ),
          ),
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextField(
                  controller: amountController,
                  keyboardType: TextInputType.number,
                  inputFormatters: <TextInputFormatter>[
                    FilteringTextInputFormatter.digitsOnly
                  ],
                  decoration: const InputDecoration(
                    label: Text('Amount'),
                    border: OutlineInputBorder(),
                    hintText: 'Add amount',
                    prefixText: '\$ ',
                  ),
                ),
              ),
            ),
            Expanded(
              child: Column(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(datePicker == null
                          ? 'No Selecte Date'
                          : format.format(datePicker!)),
                      IconButton(
                        icon: const Icon(Icons.calendar_today_rounded),
                        tooltip: 'pick date you want',
                        onPressed: () {
                          final now = DateTime.now();
                          showDatePicker(
                            context: context,
                            firstDate:
                                DateTime(now.year - 1, now.month, now.day),
                            lastDate: now,
                            initialDate: now,
                          ).then((value) {
                            setState(() {
                              datePicker = value;
                            });
                          });
                        },
                      ),
                      DropdownButton(
                          value: currentCategory,
                          items: Category.values
                              .map(
                                (e) => DropdownMenuItem(
                                  value: e,
                                  child: Text(e.name),
                                ),
                              )
                              .toList(),
                          onChanged: (value) {
                            setState(() {
                              if (value == null) {
                                return;
                              }
                              currentCategory = value;
                            });
                          }),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
        const SizedBox(
          height: 30,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton.icon(
              onPressed: () {
                validation();
              },
              icon: const Icon(Icons.add_box),
              label: const Text('Add'),
            ),
            const SizedBox(
              width: 10,
            ),
            ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(Icons.cancel_rounded),
                label: const Text('cancel')),
          ],
        )
      ],
    );
  }
}
