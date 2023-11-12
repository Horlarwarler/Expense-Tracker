import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

enum Category { food, travel, leisure, work }

final formater = DateFormat.yMd();
final randomId = Uuid();

final CategoryIcons = {
  Category.food: Icons.food_bank,
  Category.travel: Icons.travel_explore,
  Category.leisure: Icons.movie,
  Category.work: Icons.work_rounded
};

class ExpenseItemModel {
  ExpenseItemModel({
    required this.name,
    required this.price,
    required this.category,
    required DateTime date,
  }) : date = formater.format(date);
  final String id = randomId.v4();
  final String name;
  final double price;
  final String date;
  final Category category;
}

class CategoryChartModel {
  CategoryChartModel({required this.category, required this.expenses});

  CategoryChartModel.filterByCategory(
      {required this.category, required List<ExpenseItemModel> allExpenses})
      : expenses = allExpenses.where(
          (element) {
            return element.category == category;
          },
        ).toList();

  final Category category;
  final List<ExpenseItemModel> expenses;

  int get categoryHeight {
    int sum = 0;
    for (final expense in expenses) {
      sum += 1;
    }
    return sum;
  }
}
