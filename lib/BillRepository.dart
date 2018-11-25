import 'package:bill_tracker/Bill.dart';
import 'package:sqflite/sqflite.dart';

class BillRepository {
  Database _database;

  BillRepository(this._database);

  Future<List<Bill>> getBills() async {
    return await _database.query(Bill.tableName).then((List<Map<String, dynamic>> maps) async {
      return maps.map((Map<String, dynamic> map) {
        return Bill.fromMap(map);
      });
    });
  }

  Future save(String name, num price, String currency, int paymentDay) async {
    return await _database.insert(Bill.tableName, Bill(name, price, currency, paymentDay).toMap());
  }

  Future update(Bill bill) async {
    return await _database.update(Bill.tableName, bill.toMap(), where: "${Bill.columnId} = ?", whereArgs: [bill.id]);
  }

  Future delete(Bill bill) async {
    return await _database.delete(Bill.tableName, where: "${Bill.columnId} = ?", whereArgs: [bill.id]);
  }
}
