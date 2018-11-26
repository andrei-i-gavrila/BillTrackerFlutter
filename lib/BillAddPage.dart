import 'package:bill_tracker/BillRepository.dart';
import 'package:flutter/material.dart';

class BillAddPage extends StatefulWidget {
  final BillRepository _billRepository;

  BillAddPage(this._billRepository);

  @override
  BillAddPageState createState() {
    return new BillAddPageState();
  }
}

class BillAddPageState extends State<BillAddPage> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();
  String _currency = "RON";
  final TextEditingController _paymentDayController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text("Add bill")),
        body: Column(children: [
          Row(children: [Expanded(child: TextField(controller: _nameController))]),
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
                      widget._billRepository.save(_nameController.value.text, num.parse(_priceController.value.text), _currency, int.parse(_paymentDayController.value.text)).then((_) {
                        Navigator.pop(context);
                      });
                    }))
          ])
        ]));
  }
}
