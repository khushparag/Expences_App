import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final double amount;
  final String weekDay;
  final double fractionOfTotalSpending;

  ChartBar(this.amount, this.weekDay, this.fractionOfTotalSpending);
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        FittedBox(child: Text('\$${amount.toStringAsFixed(0)}')),
        SizedBox(
          height: 6,
        ),
        Container(
            height: 70,
            width: 15,
            child: Stack(
              children: [
                Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      border:
                          Border.all(color: Color.fromRGBO(220, 220, 220, 1))),
                ),
                FractionallySizedBox(
                  heightFactor: fractionOfTotalSpending,
                  child: Container(
                    decoration: BoxDecoration(
                      color: Theme.of(context).primaryColor,
                      border:
                          Border.all(color: Color.fromRGBO(220, 220, 220, 1)),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                )
              ],
            )),
        SizedBox(height: 6),
        Text(weekDay)
      ],
    );
  }
}
