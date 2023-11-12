import 'package:expense_tracker/chart.dart';
import 'package:expense_tracker/expense_item.dart';
import 'package:expense_tracker/expenses_list.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:expense_tracker/new_expense_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpensesTracker extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _ExpensesTrackerState();
  }
}

class _ExpensesTrackerState extends State<ExpensesTracker> {
  var expenses = [
    ExpenseItemModel(
      category: Category.food,
      name: "Buy Flutter",
      price: 20.0,
      date: DateTime.now(),
    ),
    ExpenseItemModel(
      category: Category.food,
      name: "Buy Flutter",
      price: 20.0,
      date: DateTime.now(),
    ),
    ExpenseItemModel(
      category: Category.leisure,
      name: "Buy Flutter",
      price: 20.0,
      date: DateTime.now(),
    ),
    ExpenseItemModel(
      category: Category.travel,
      name: "Buy Flutter",
      price: 20.0,
      date: DateTime.now(),
    ),
  ];
  Widget? mainContent;
  void _onAddButtonClick() {
    showModalBottomSheet(
      useSafeArea: true,
      isScrollControlled: true,
      context: context,
      builder: (ctx) {
        return NewExpenseDialog(
          onAddExpense: addExpense,
        );
      },
    );
  }

  void onDismissItem(ExpenseItemModel expenseItemModel) {
    final index = expenses.indexOf(expenseItemModel);
    expenses.remove(expenseItemModel);
    setState(() {});
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text("Item ${expenseItemModel.name} deleted"),
        duration: const Duration(seconds: 3),
        action: SnackBarAction(
          label: "Undo",
          onPressed: () {
            setState(() {
              expenses.insert(index, expenseItemModel);
            });
          },
        ),
      ),
    );
  }

  void addExpense(ExpenseItemModel expense) {
    setState(() {
      expenses.add(expense);
    });
  }

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    if (expenses.isEmpty) {
      mainContent = const Center(
        child: Text(
          "List is Empty try adding items",
          style: TextStyle(color: Colors.white, fontSize: 16),
        ),
      );
    } else {
      mainContent = height > width
          ? Column(
              children: [
                Chart(expenses: expenses),
                ExpensesList(
                  expenses: expenses,
                  onDismissItem: onDismissItem,
                )
              ],
            )
          : Row(
              children: [
                Expanded(child: Chart(expenses: expenses)),
                ExpensesList(
                  expenses: expenses,
                  onDismissItem: onDismissItem,
                )
              ],
            );
    }
    return Scaffold(
        appBar: AppBar(
          title: Text(
            "Flutter Expenses Tracker",
            style: GoogleFonts.lato(fontSize: 16, color: Colors.white),
            textAlign: TextAlign.start,
          ),
          actions: [
            IconButton(
              onPressed: _onAddButtonClick,
              icon: const Icon(
                Icons.add,
                color: Colors.white,
              ),
            ),
          ],
        ),
        body: mainContent);
  }
}
