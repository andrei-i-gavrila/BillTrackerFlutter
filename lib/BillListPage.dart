import 'package:bill_tracker/Bill.dart';
import 'package:bill_tracker/BillAddPage.dart';
import 'package:bill_tracker/BillEditPage.dart';
import 'package:bill_tracker/BillListItem.dart';
import 'package:bill_tracker/BillRepository.dart';
import 'package:flutter/material.dart';

class BillListPage extends StatefulWidget {
  final BillRepository _billRepository;

  BillListPage(this._billRepository);

  @override
  BillListPageState createState() {
    return new BillListPageState();
  }
}

class BillListPageState extends State<BillListPage> {
  Widget build(BuildContext context) {
    return new Scaffold(
      body: FutureBuilder(
        future: widget._billRepository.getBills(),
        builder: (context, AsyncSnapshot<List<Bill>> asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            if (asyncSnapshot.hasError) {
              throw asyncSnapshot.error;
            } else {
              return createListView(asyncSnapshot.data);
            }
          }
          return Text("Loading...");
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _goToAddBillPage,
        child: new Icon(Icons.add),
      ),
    );
  }

  void _goToAddBillPage() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BillAddPage(widget._billRepository)),
    );
  }

  Widget createListView(List<Bill> bills) {
    return ListView.builder(
      itemCount: bills.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          child: BillListItem(bills[index]),
          onTap: () => _navigateToEditPage(bills[index]),
        );
      },
    );
  }

  _navigateToEditPage(Bill bill) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => BillEditPage(widget._billRepository, bill)),
    );
  }
}
