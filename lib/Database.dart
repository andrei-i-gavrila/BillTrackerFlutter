import 'package:bill_tracker/Bill.dart';
import 'package:bill_tracker/BillRepository.dart';
import 'package:sqflite/sqflite.dart';

final String dbPath = "billTracker.db";
final int databaseVersion = 1;

class BillAppDatabase {
  Database _database;
  BillRepository billRepository;

  BillAppDatabase();

  Future open() async {
    _database = await openDatabase(dbPath, version: databaseVersion, onCreate: (
      Database db,
      int version,
    ) async {
      await db.execute('''
          create table ${Bill.tableName} (
             ${Bill.columnId} integer primary key autoincrement,
             ${Bill.columnName} text not null,
             ${Bill.columnPrice} real not null,
             ${Bill.columnCurrency} text not null
             ${Bill.columnPaymentDay} integer not null      
          )''');
    });

    billRepository = BillRepository(_database);
  }
}
