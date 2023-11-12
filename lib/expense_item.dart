import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpenseItem extends StatelessWidget {
  const ExpenseItem({required this.expenseItemModel, super.key});

  final ExpenseItemModel expenseItemModel;
  @override
  Widget build(BuildContext context) {
    return Card(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              expenseItemModel.name,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall!
                  .copyWith(fontWeight: FontWeight.bold),
              textAlign: TextAlign.right,
            ),
            const SizedBox(
              height: 5,
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  "\$${expenseItemModel.price.toStringAsFixed(2)}",
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.start,
                ),
                const Spacer(),
                Icon(
                  CategoryIcons[expenseItemModel.category],
                  size: 28,
                  color: Theme.of(context).cardTheme.surfaceTintColor,
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(
                  expenseItemModel.date,
                  style: Theme.of(context).textTheme.bodySmall,
                  textAlign: TextAlign.right,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
