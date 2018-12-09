import 'package:bill_tracker/Bill.dart';
import 'package:sqflite/sqflite.dart';

class BillRepository {
  Database _database;

  BillRepository(this._database);

  Future<List<Bill>> getBills() async {
    var queryResult = await _database.query(Bill.tableName, where: "${Bill.columnDeleted} = 0");
    return queryResult.map((Map<String, dynamic> map) {
      return Bill.fromMap(map);
    }).toList();
  }

  Future<List<Bill>> getBillsToDelete() async {
    var queryResult = await _database.query(Bill.tableName, where: "${Bill.columnDeleted} = 1");
    return queryResult.map((Map<String, dynamic> map) {
      return Bill.fromMap(map);
    }).toList();
  }


  Future<List<Bill>> getBillsToSync() async {
    var queryResult = await _database.query(Bill.tableName, where: "${Bill.columnSynced} = 0");
    return queryResult.map((Map<String, dynamic> map) {
      return Bill.fromMap(map);
    }).toList();
  }

  Future save(String name, num price, String currency, int paymentDay) async {
    return await _database.insert(Bill.tableName, Bill(name, price, currency, paymentDay).toMap());
  }

  Future update(Bill bill, {bool sync = true}) async {
    bill.synced = !sync;
    return await _database.update(Bill.tableName, bill.toMap(), where: "${Bill.columnId} = ?", whereArgs: [bill.id]);
  }

  Future delete(Bill bill) async {
    bill.deleted = true;
    return update(bill, sync: false);
  }

  Future insertOrUpdate(Bill bill) async {
    return await _database.insert(Bill.tableName, bill.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }
}
