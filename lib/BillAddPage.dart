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
    return Column(
      children: <Widget>[
        Expanded(child: TextField(controller: _nameController)),
        Expanded(child: TextField(controller: _priceController)),
        Expanded(
            child: DropdownButton(
          items: [DropdownMenuItem(child: Text("RON"), value: "RON"), DropdownMenuItem(child: Text("EUR"), value: "EUR")],
          onChanged: (String value) {
            _currency = value;
          },
        )),
        Expanded(child: TextField(controller: _paymentDayController)),
        Expanded(
            child: RaisedButton(
                child: Text("Save"),
                onPressed: () {
                  widget._billRepository.save(_nameController.value.toString(), num.parse(_priceController.value.toString()), _currency, int.parse(_paymentDayController.value.toString())).then((_) {
                    Navigator.push(context, MaterialPageRoute(builder: (context) {}));
                  });
                }))
      ],
    );
  }
}
