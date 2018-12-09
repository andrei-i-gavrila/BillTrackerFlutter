import 'package:bill_tracker/BillApi.dart';
import 'package:bill_tracker/BillRepository.dart';

class ServerSynchronizer {

  var _api = BillApi();

  BillRepository _repository;

  ServerSynchronizer(this._repository);

  void run() async {
    print("Syncing");
    await deleteBills();
    await sendUpdates();
    await receiveUpdates();
  }

  Future receiveUpdates() async {
    var bills = await _api.getBills();
    print("receiving updates: ");
    print(bills.map((bill) => bill.toMap()).toList());
    for (var bill in bills) {
      _repository.insertOrUpdate(bill);
    }
  }

  Future sendUpdates() async {
    print("sending updates");
    var bills = await _repository.getBillsToSync();
    print(bills.map((bill) => bill.toMap()).toList());
    for (var bill in bills) {
      if (await _api.saveBill(bill)) {
        _repository.update(bill, sync: false);
      }
    }
  }

  Future deleteBills() async {
    print("deleting remoetes");
    var bills = await _repository.getBillsToDelete();
    print(bills.map((bill) => bill.toMap()).toList());
    for (var bill in bills) {
      if (await _api.deleteBill(bill)) {
        _repository.delete(bill);
      }
    }
  }
}