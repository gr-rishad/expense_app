import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function addTx;
  NewTransaction(this.addTx);

  final titleController = TextEditingController();
  final amountController = TextEditingController();

  void submitData() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      // Scaffold.of(context).showSnackBar(SnackBar(content: Text('Something Went Wrong !'),),);
      return;
    }

    addTx(
      enteredTitle,
      enteredAmount,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      child: Container(
        //margin: EdgeInsets.only(bottom: 10),
        padding: EdgeInsets.all(10),
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
            FlatButton(
              onPressed: submitData,
              //() {
              // print(inputTitle);
              //print(titleController.text);
              // },
              child: Text('Add Transaction'),
              textColor: Colors.purple,
            ),
          ],
        ),
      ),
    );
  }
}
