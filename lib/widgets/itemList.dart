import 'package:demo_app/models/transaction.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../models/transaction.dart';

class ItemList extends StatelessWidget {
  final List<Transaction> userTransactions;
  final Function deleteItem;
  ItemList(this.userTransactions, this.deleteItem);
  @override
  Widget build(BuildContext context) {
    return Container(
        height: 300,
        child: userTransactions.isEmpty
            ? Column(
                children: [
                  Text('no transactions availabe yet'),
                  SizedBox(height: 30),
                  Container(
                      height: 200,
                      child: Image.asset('assets/images/waiting.png',
                          fit: BoxFit.fill))
                ],
              )
            : ListView.builder(
                itemBuilder: (ctx, index) {
                  return Card(
                      elevation: 10,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5)),
                      shadowColor: Colors.black,
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundColor: Theme.of(context).primaryColor,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: FittedBox(
                              child: Text(
                                '\$${userTransactions[index].amount}',
                                style: Theme.of(ctx).textTheme.headline6,
                              ),
                            ),
                          ),
                        ),
                        title: Text(
                          '${userTransactions[index].title}',
                          style: Theme.of(ctx).textTheme.headline6,
                        ),
                        subtitle: Text(
                            '${DateFormat().add_yMd().format(userTransactions[index].date)}'),
                        trailing: IconButton(
                          icon: Icon(Icons.delete),
                          color: Theme.of(context).errorColor,
                          onPressed: () {
                            deleteItem(userTransactions[index].id);
                          },
                        ),
                      ));
                },
                itemCount: userTransactions.length,
              ));
  }
}
