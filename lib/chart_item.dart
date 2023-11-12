import 'package:flutter/material.dart';

class ChartItem extends StatelessWidget {
  const ChartItem(
      {required this.fractionSize, required this.iconData, super.key});

  final double fractionSize;
  final IconData iconData;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Align(
            alignment: Alignment.bottomCenter,
            child: FractionallySizedBox(
              heightFactor: fractionSize,
              widthFactor: 1,
              child: Card(
                color: Theme.of(context).colorScheme.primary,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(8),
                      topRight: Radius.circular(8)),
                ),
              ),
            ),
          ),
        ),
        Icon(
          iconData,
          color: Theme.of(context).colorScheme.primary,
        )
      ],
    );
  }
}
