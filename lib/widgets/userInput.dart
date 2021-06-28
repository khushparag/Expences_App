import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class UserInput extends StatefulWidget {
  final Function addItem;

  UserInput(this.addItem);

  @override
  _UserInputState createState() => _UserInputState();
}

class _UserInputState extends State<UserInput> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();

  DateTime? _selectedDate;

  addItemInList() {
    final titleText = _titleController.text;
    if (_amountController.text.isEmpty) {
      return;
    }

    final amount = double.parse(_amountController.text);
    if (titleText.isEmpty || amount <= 0 || _selectedDate == null) {
      return;
    }
    print('date is : $_selectedDate');
    widget.addItem(_titleController.text, double.parse(_amountController.text),
        _selectedDate);
    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(2020),
            lastDate: DateTime.now())
        .then((pickedDate) {
      if (pickedDate == null) {
        return;
      }
      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final _selectedDate = this._selectedDate;
    return Card(
      borderOnForeground: true,
      elevation: 10,
      color: Colors.white,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      child: Container(
        padding: EdgeInsets.all(4),
        width: double.infinity,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              TextField(
                decoration: InputDecoration(
                    labelText: 'Item',
                    floatingLabelBehavior: FloatingLabelBehavior.auto),
                style: TextStyle(color: Colors.purple),
                controller: _titleController,
                onSubmitted: (_) => addItemInList(),
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                onSubmitted: (_) => addItemInList(),
              ),
              Container(
                margin: EdgeInsets.all(10),
                width: double.infinity,
                child: Row(
                  children: [
                    _selectedDate == null
                        ? Text('Please select a date first')
                        : Text(DateFormat.yMd().format(_selectedDate)),
                    Expanded(
                        child: TextButton(
                            onPressed: () {
                              _displayDatePicker();
                            },
                            child: Text('Choose Date')))
                  ],
                ),
              ),
              ElevatedButton(onPressed: addItemInList, child: Text('Add Item'))
            ],
          ),
        ),
      ),
    );
  }
}
