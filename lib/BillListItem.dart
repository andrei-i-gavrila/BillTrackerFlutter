import 'package:bill_tracker/Bill.dart';
import 'package:flutter/material.dart';

class BillListItem extends StatelessWidget {
  final Bill _bill;

  BillListItem(this._bill);

  @override
  Widget build(BuildContext context) {
    return new Row(
      children: <Widget>[
        Expanded(child: Text(_bill.name, textAlign: TextAlign.left)),
        Expanded(child: Text(_bill.price.toStringAsFixed(1) + _bill.currency, textAlign: TextAlign.right))
      ],
    );
  }
}
