import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class ExpensesList extends StatefulWidget {
  const ExpensesList(
      {required this.expenses, required this.onDismissItem, super.key});

  final List<ExpenseItemModel> expenses;
  final void Function(ExpenseItemModel expense) onDismissItem;
  @override
  State<StatefulWidget> createState() {
    return _ExpensesListState();
  }
}

class _ExpensesListState extends State<ExpensesList> {
  @override
  Widget build(BuildContext context) {
    final expenses = widget.expenses;
    return Expanded(
      child: ListView.builder(
        itemCount: expenses.length,
        itemBuilder: (context, index) {
          final item = expenses[index];
          return Dismissible(
            key: UniqueKey(),
            onDismissed: (direction) {
              widget.onDismissItem(item);
            },
            child: ExpenseItem(expenseItemModel: item),
          );
        },
      ),
    );
  }
}
