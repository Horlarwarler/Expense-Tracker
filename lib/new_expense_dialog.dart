import 'dart:io';

import 'package:expense_tracker/custom_text_field.dart';
import 'package:expense_tracker/models/expense_item.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

final formater = DateFormat.yMd();

class NewExpenseDialog extends StatefulWidget {
  const NewExpenseDialog({required this.onAddExpense, super.key});
  final void Function(ExpenseItemModel expense) onAddExpense;
  @override
  State<StatefulWidget> createState() {
    return _NewExpenseDialogState();
  }
}

DateTime? selectedDate;

class _NewExpenseDialogState extends State<NewExpenseDialog> {
  final _titleTextEditingController = TextEditingController();
  final _amountTextEditingController = TextEditingController();

  void pickDate() async {
    final todayDate = DateTime.now();
    final firstDate = DateTime(todayDate.year - 1);
    final lastDate = DateTime(todayDate.year + 1);

    final pickedDate = await showDatePicker(
      context: context,
      initialDate: todayDate,
      firstDate: firstDate,
      lastDate: lastDate,
    );
    if (pickedDate != null) {
      setState(() {
        selectedDate = pickedDate;
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  var categorySelected = Category.food;

  void onCategorySelected(Category? category) {
    if (category == null) return;
    setState(() {
      categorySelected = category;
    });
  }

  void dismissDialog() {
    Navigator.pop(context);
  }

  void _showDialog() {
    if (Platform.isIOS) {
      showCupertinoDialog(
          context: context,
          builder: (ctx) {
            return CupertinoAlertDialog(
              title: Text("Error Occurs",
                  style: Theme.of(context).textTheme.titleLarge),
              content: Text("Unable to add content, check input field",
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      color:
                          Theme.of(context).colorScheme.onSecondaryContainer)),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: const Text("Cancel"))
              ],
            );
          });
    } else {
      showDialog(
        context: context,
        builder: (
          builder,
        ) {
          return AlertDialog(
            title: Text("Error Occurs",
                style: Theme.of(context).textTheme.titleLarge),
            content: Text("Unable to add content, check input field",
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                    color: Theme.of(context).colorScheme.onSecondaryContainer)),
            actions: [
              TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: const Text("Cancel"))
            ],
          );
        },
      );
    }
  }

  void saveNewExpense() {
    final titleIsValid = _titleTextEditingController.text.trim().isNotEmpty;
    final amountToDouble = double.tryParse(_amountTextEditingController.text);

    final amountIsValid = amountToDouble != null && amountToDouble > 0;
    final dateIsValid = selectedDate != null;

    if (!titleIsValid || !dateIsValid || !amountIsValid) {
      _showDialog();
      return;
    }
    final expenseItemModel = ExpenseItemModel(
        name: _titleTextEditingController.text,
        price: amountToDouble,
        category: categorySelected,
        date: selectedDate!);
    widget.onAddExpense(expenseItemModel);
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final keyboardSpace = MediaQuery.of(context).viewInsets.bottom;

    final dropDownMenuItems = Category.values.map((category) {
      return DropdownMenuItem(
        key: ValueKey(category),
        value: category,
        child: Text(
          category.name.toUpperCase(),
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      );
    }).toList();
    return LayoutBuilder(builder: ((context, constraints) {
      final width = constraints.maxWidth;
      //final isLandscape = w
      return SizedBox(
        height: double.infinity,
        //width: ,
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.fromLTRB(20, 20, 20, 20 + keyboardSpace),
            child: Column(
              children: [
                if (width > 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: CustomTextField(
                          50,
                          editingController: _titleTextEditingController,
                          label: "Title",
                          keyboardType: TextInputType.name,
                        ),
                      ),
                      SizedBox(
                        width: 30,
                      ),
                      Expanded(
                        child: TextField(
                          controller: _amountTextEditingController,
                          decoration: InputDecoration(
                            prefixText: "\$",
                            prefixStyle: Theme.of(context).textTheme.bodySmall,
                            hintText: "20.00",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.4)),
                            label: Text(
                              "Amount",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.bodyMedium,
                          autofocus: true,
                        ),
                      ),
                    ],
                  )
                else
                  CustomTextField(
                    50,
                    editingController: _titleTextEditingController,
                    label: "Title",
                    keyboardType: TextInputType.name,
                  ),
                if (width > 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: categorySelected,
                        //style: Theme.of(context).textTheme.bodyLarge,
                        items: dropDownMenuItems,
                        onChanged: onCategorySelected,
                      ),
                      const Spacer(),
                      Text(
                        selectedDate == null
                            ? "Select Date"
                            : formater.format(selectedDate!),
                        style: GoogleFonts.lato(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: pickDate,
                        icon: const Icon(Icons.calendar_month),
                      )
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        child: TextField(
                          controller: _amountTextEditingController,
                          decoration: InputDecoration(
                            prefixText: "\$",
                            prefixStyle: Theme.of(context).textTheme.bodySmall,
                            hintText: "20.00",
                            hintStyle: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .textTheme
                                        .bodyMedium!
                                        .color!
                                        .withOpacity(0.4)),
                            label: Text(
                              "Amount",
                              style: Theme.of(context).textTheme.labelSmall,
                            ),
                          ),
                          keyboardType: TextInputType.number,
                          style: Theme.of(context).textTheme.bodyMedium,
                          autofocus: true,
                        ),
                      ),
                      const Spacer(),
                      Text(
                        selectedDate == null
                            ? "Select Date"
                            : formater.format(selectedDate!),
                        style: GoogleFonts.lato(
                            fontSize: 12, fontWeight: FontWeight.normal),
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      IconButton(
                        onPressed: pickDate,
                        icon: const Icon(Icons.calendar_month),
                      )
                    ],
                  ),
                if (width > 600)
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Spacer(),
                      TextButton(
                        onPressed: dismissDialog,
                        style: TextButton.styleFrom(),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.lato(fontSize: 10),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: saveNewExpense,
                        style: TextButton.styleFrom(),
                        child: Text(
                          "Save",
                          style: GoogleFonts.lato(fontSize: 12),
                        ),
                      )
                    ],
                  )
                else
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      DropdownButton(
                        value: categorySelected,
                        //style: Theme.of(context).textTheme.bodyLarge,
                        items: dropDownMenuItems,
                        onChanged: onCategorySelected,
                      ),
                      const Spacer(),
                      TextButton(
                        onPressed: dismissDialog,
                        style: TextButton.styleFrom(),
                        child: Text(
                          "Cancel",
                          style: GoogleFonts.lato(fontSize: 10),
                        ),
                      ),
                      ElevatedButton(
                        onPressed: saveNewExpense,
                        style: TextButton.styleFrom(),
                        child: Text(
                          "Save",
                          style: GoogleFonts.lato(fontSize: 12),
                        ),
                      )
                    ],
                  )
              ],
            ),
          ),
        ),
      );
    }));
  }
}
