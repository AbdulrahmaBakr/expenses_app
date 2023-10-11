import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';

const uuid = Uuid();

final FormDate = DateFormat().add_yMEd();

enum Category { food, traverl, work, entertainmint }
//handle icons
const categoryIcons = {
  Category.food: Icons.lunch_dining,
  Category.traverl: Icons.flight_land,
  Category.work: Icons.work_history_sharp,
  Category.entertainmint: Icons.travel_explore,
};

class Expense {
  final String id;
  final String title;
  final double amount;
  final DateTime date;
  final Category category;
//handle format date
  String get formatDate {
    return FormDate.format(date);
  }

  Expense(
      {required this.category,
      required this.title,
      required this.amount,
      required this.date})
      : id = uuid.v4();
}

 