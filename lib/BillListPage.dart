import 'package:flutter/material.dart';

class BillListPage extends StatelessWidget {


  Widget build(BuildContext context) {
    return new Scaffold(
      body: ListView(
        children: <Widget>[],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddBillPage,
        child: new Icon(Icons.add),
      ),
    );
  }

  void _goToAddBillPage() {
  }
}
