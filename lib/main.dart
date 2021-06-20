import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'transaction.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatelessWidget {
  final List<Transaction> _transactions = [
    Transaction(amount: 50, date: DateTime.now(), id: 't1', title: 'shoes'),
    Transaction(amount: 66, date: DateTime.now(), id: 't2', title: 'Laptop')
  ];

  Widget displayGraph() {
    return Container(
      width: double.infinity,
      child: Card(
        color: Colors.amber,
        elevation: 15,
        shadowColor: Colors.blue,
        child: Text('Graphs'),
      ),
    );
  }

  Widget displayItemList() {
    return Column(children: [
      ..._transactions.map((tx) {
        return Card(
            shadowColor: Colors.black,
            child: Row(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2),
                  ),
                  padding: EdgeInsets.all(5),
                  child: Text(
                    '\$ ${tx.amount}',
                    style: TextStyle(
                        color: Colors.purple, fontWeight: FontWeight.bold),
                  ),
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      tx.title,
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 12,
                          color: Colors.purple),
                      textAlign: TextAlign.left,
                    ),
                    Text(
                      DateFormat.yMMMd().format(tx.date),
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 8,
                          color: Colors.grey),
                      textAlign: TextAlign.left,
                    )
                  ],
                )
              ],
            ));
      }).toList()
    ]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Expences App')),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [displayGraph(), displayItemList()],
      ),
    );
  }
}
