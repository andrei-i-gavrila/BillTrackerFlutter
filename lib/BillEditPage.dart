import 'package:bill_tracker/Bill.dart';
import 'package:bill_tracker/BillRepository.dart';
import 'package:flutter/material.dart';

class BillEditPage extends StatefulWidget {
  final BillRepository _billRepository;
  final Bill _bill;

  BillEditPage(this._billRepository, this._bill);

  @override
  BillEditPageState createState() {
    return new BillEditPageState();
  }
}

class BillEditPageState extends State<BillEditPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _currency = "RON";
  final TextEditingController _paymentDayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _nameController.text = widget._bill.name;
    _priceController.text = widget._bill.price.toString();
    _paymentDayController.text = widget._bill.paymentDay.toString();
    _currency = widget._bill.currency;
    return Scaffold(
        appBar: AppBar(title: Text("Edit bill")),
        body: Column(children: [
          Row(children: [Expanded(child: TextField(controller: _nameController))]),
          Row(children: []),
          Row(children: [
            Expanded(child: TextField(controller: _priceController)),
            DropdownButton(
              value: _currency,
              items: [DropdownMenuItem(child: Text("RON"), value: "RON"), DropdownMenuItem(child: Text("EUR"), value: "EUR")],
              onChanged: (String value) {
                setState(() {
                  _currency = value;
                });
              },
            )
          ]),
          Row(children: [Expanded(child: TextField(controller: _paymentDayController))]),
          Row(children: [
            Expanded(
                child: RaisedButton(
                    child: Text("Save"),
                    onPressed: () {
                      widget._bill.name = _nameController.text;
                      widget._bill.price = num.parse(_priceController.text);
                      widget._bill.currency = _currency;
                      widget._bill.paymentDay = int.parse(_paymentDayController.text);

                      widget._billRepository.update(widget._bill).then((_) {
                        Navigator.pop(context);
                      });
                    }))
          ]),
          Row(children: [
            Expanded(
                child: RaisedButton(
                    child: Text("Delete"),
                    onPressed: () {
                      widget._billRepository.delete(widget._bill).then((_) => Navigator.pop(context));
                    }))
          ])
        ]));
  }
}
