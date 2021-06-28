import 'package:demo_app/widgets/chart.dart';
import 'package:demo_app/widgets/itemList.dart';
import 'package:flutter/material.dart';
import './models/transaction.dart';
import './widgets/userInput.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
          primarySwatch: Colors.deepOrange,
          accentColor: Colors.deepOrangeAccent,
          fontFamily: 'Quicksand',
          textTheme: ThemeData.light().textTheme.copyWith(
              headline6: TextStyle(
                  fontFamily: 'OpenSans',
                  fontSize: 15,
                  fontWeight: FontWeight.bold)),
          appBarTheme: AppBarTheme(
              textTheme: ThemeData.light().textTheme.copyWith(
                  headline6: TextStyle(
                      fontFamily: 'OpenSans',
                      fontWeight: FontWeight.bold,
                      fontSize: 20)))),
      debugShowCheckedModeBanner: false,
      home: _MyHomePage(),
    );
  }
}

class _MyHomePage extends StatefulWidget {
  @override
  __MyHomePageState createState() => __MyHomePageState();
}

class __MyHomePageState extends State<_MyHomePage> {
  final List<Transaction> _transactions = [];
  // final Function addItem;

  // addItemInList() {
  //   final titleText = _titleController.text;
  //   final amount = double.parse(_amountController.text);
  //   if (titleText.isEmpty || amount <= 0) {
  //     return;
  //   }
  //   addItem(_titleController.text, double.parse(_amountController.text));
  // }

  void _addItemInList(String item, double amount, DateTime selectedDate) {
    final newTx = Transaction(
        amount: amount,
        date: selectedDate,
        id: DateTime.now().toString(),
        title: item);
    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteItem(String id) {
    setState(() {
      _transactions.removeWhere((element) => element.id == id);
    });
  }

  void startUserInput(BuildContext ctx) {
    showModalBottomSheet(
        context: ctx,
        builder: (_) {
          return UserInput(_addItemInList);
        });
  }

  List<Transaction> get _recentTransactions {
    return _transactions.where((tx) {
      return tx.date.isAfter(DateTime.now().subtract(Duration(days: 7)));
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Expences App'),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                startUserInput(context);
              },
              icon: Icon(Icons.add))
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Chart(_recentTransactions),
            ItemList(_transactions, _deleteItem)
          ],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          startUserInput(context);
        },
        child: Icon(Icons.add),
      ),
    );
    // backgroundColor: Colors.lightBlue);
  }
}
