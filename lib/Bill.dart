class Bill {
  static final tableName = 'Bill';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnPrice = 'price';
  static final columnCurrency = 'currency';
  static final columnPaymentDay = 'paymentDay';
  static final columnSynced = "synced";
  static final columnDeleted = "deleted";

  int id;
  String name;
  num price;
  String currency;
  int paymentDay;
  bool deleted;
  bool synced;

  Bill(this.name, this.price, this.currency, this.paymentDay) {
    synced = false;
    deleted = false;
  }

  Bill.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    price = map[columnPrice];
    currency = map[columnCurrency];
    paymentDay = map[columnPaymentDay];
    deleted = map[columnDeleted] == 1;
    synced = map[columnSynced] == 1;
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnPrice: price,
      columnCurrency: currency,
      columnPaymentDay: paymentDay,
      columnSynced: synced ? 1 : 0,
      columnDeleted: deleted ? 1 : 0
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }

  Bill.fromJsonMap(Map<String, dynamic> map) {
    id = map['id'];
    name = map['name'];
    price = map['price'];
    currency = map['currency'];
    paymentDay = map['day_of_month'];
    synced = true;
    deleted = false;
  }

  Map<String, dynamic> toJsonMap() {
    var map = <String, dynamic>{
      'name': name,
      'price': price,
      'currency': currency,
      'day_of_month': paymentDay,
      'fixed_price': '1'
    };
    if (id != null) {
      map['id'] = id;
    }
    return map;
  }
}
