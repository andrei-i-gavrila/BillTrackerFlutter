import 'dart:async';

import 'package:bill_tracker/BillListPage.dart';
import 'package:bill_tracker/BillRepository.dart';
import 'package:bill_tracker/Database.dart';
import 'package:bill_tracker/ServerSyncService.dart';
import 'package:connectivity/connectivity.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void main() => runApp(new BillTracker());

class BillTracker extends StatefulWidget {

  @override
  BillTrackerState createState() {
    return new BillTrackerState();
  }
}

class BillTrackerState extends State<BillTracker> {
  Timer _backgroundSync;
  BillRepository _billRepository;

  Widget build(BuildContext context) {
    return FutureBuilder<BillAppDatabase>(
        future: BillAppDatabase().open(),
        builder: (context, asyncSnapshot) {
          if (asyncSnapshot.connectionState == ConnectionState.done) {
            _billRepository = asyncSnapshot.data.billRepository;
            setupSync();
            return new MaterialApp(title: 'Bill tracker', theme: ThemeData.light(), home: BillListPage(_billRepository));
          }
          return Center(child: CircularProgressIndicator());
        });
  }

  void setupSync() {
    var synchronizer = ServerSynchronizer(_billRepository);

    Connectivity().onConnectivityChanged.listen((state) {
      if (state == ConnectivityResult.none && _backgroundSync != null) {
        _backgroundSync.cancel();
        _backgroundSync = null;
        Fluttertoast.showToast(
            msg: "There is currently no connection. All server actions will be stored locally and resumed when possible!",
            toastLength: Toast.LENGTH_LONG,
            gravity: ToastGravity.CENTER,
            backgroundColor: Colors.red,
            textColor: Colors.white
        );
      }
      if (state != ConnectivityResult.none && _backgroundSync == null) {
        synchronizer.run();
        _backgroundSync = Timer.periodic(Duration(seconds: 90), (timer) {
          synchronizer.run();
        });
      }
    });
  }



  @override
  void dispose() {
    _backgroundSync.cancel();
    super.dispose();
  }


}
