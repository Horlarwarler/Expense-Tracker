import 'package:expense_tracker/chart_item.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/material.dart';

class Chart extends StatelessWidget {
  const Chart({required this.expenses, super.key});

  final List<ExpenseItemModel> expenses;
  @override
  Widget build(BuildContext context) {
    final foodCount = CategoryChartModel.filterByCategory(
            category: Category.food, allExpenses: expenses)
        .categoryHeight;
    final travel = CategoryChartModel.filterByCategory(
            category: Category.travel, allExpenses: expenses)
        .categoryHeight;
    final leisure = CategoryChartModel.filterByCategory(
            category: Category.leisure, allExpenses: expenses)
        .categoryHeight;
    final work = CategoryChartModel.filterByCategory(
            category: Category.work, allExpenses: expenses)
        .categoryHeight;
    var totalFraction = 0.0;
    var countList = [foodCount, travel, leisure, work];

    final Map<IconData, int> categoryCountMap = Map();
    categoryCountMap.addAll({
      CategoryIcons[Category.food]!: foodCount,
      CategoryIcons[Category.travel]!: travel,
      CategoryIcons[Category.leisure]!: leisure,
      CategoryIcons[Category.work]!: work
    });

    for (var element in countList) {
      if (element > totalFraction) {
        totalFraction = element.toDouble();
      }
    }
    return Card(
      child: SizedBox(
        height: 150,
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 10),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              for (final item in categoryCountMap.entries)
                Expanded(
                  child: ChartItem(
                    fractionSize:
                        item.value == 0 ? 0 : item.value / totalFraction,
                    iconData: item.key,
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
