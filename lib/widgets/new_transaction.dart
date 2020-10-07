import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class NewTransaction extends StatefulWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  @override
  _NewTransactionState createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();
  final amountController = TextEditingController();
  DateTime _selectedDate;

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (amountController.text.isEmpty) {
      return;
    }

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Something Went Wrong !'),),);
      return;
    }

    widget.addTx(
      enteredTitle,
      enteredAmount,
      _selectedDate,
    );

    Navigator.of(context).pop();
  }

  void _presentDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2019),
      lastDate: DateTime.now(),
    ).then(
      (pickedDate) {
        if (pickedDate == null) {
          return;
        }
        setState(() {
          _selectedDate = pickedDate;
        });
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        child: Container(
          //margin: EdgeInsets.only(bottom: 10),
          padding: EdgeInsets.only(
            top: 10,
            right: 10,
            left: 10,
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              TextField(
                // onChanged: (val) {
                //   inputTitle = val;
                // },
                controller: titleController,
                decoration: InputDecoration(labelText: 'Title'),
                onSubmitted: (_) => submitData(),
              ),
              TextField(
                // onChanged: (val) => inputAmount = val,
                controller: amountController,
                decoration: InputDecoration(labelText: 'Amount'),
                keyboardType: TextInputType.number,
                onSubmitted: (_) => submitData(),
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        _selectedDate == null
                            ? 'No Data Choosen !'
                            : 'Picked Date: ${DateFormat.yMd().format(_selectedDate)}',
                      ),
                    ),
                    FlatButton(
                      textColor: Theme.of(context).primaryColor,
                      child: Text(
                        'Choose Date',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onPressed: _presentDatePicker,
                    ),
                  ],
                ),
              ),
              RaisedButton(
                onPressed: submitData,
                //() {
                // print(inputTitle);
                //print(titleController.text);
                // },
                color: Theme.of(context).primaryColor,

                child: Text('Add Transaction'),
                textColor: Theme.of(context).textTheme.button.color,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
