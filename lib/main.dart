import 'package:bill_tracker/BillListPage.dart';
import 'package:bill_tracker/Database.dart';
import 'package:flutter/material.dart';

void main() => runApp(new BillTracker());

class BillTracker extends StatelessWidget {
  Widget build(BuildContext context) {
    return FutureBuilder<BillAppDatabase>(
        future: BillAppDatabase().open(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            return new MaterialApp(title: 'Bill tracker', theme: ThemeData.dark(), home: BillListPage(asyncSnapshot.data.billRepository));
          }
          return Center(child: CircularProgressIndicator());
        });
  }
}
