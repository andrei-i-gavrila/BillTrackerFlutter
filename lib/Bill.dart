class Bill {
  static final tableName = 'Bill';
  static final columnId = '_id';
  static final columnName = 'name';
  static final columnPrice = 'price';
  static final columnCurrency = 'currency';
  static final columnPaymentDay = 'paymentDay';

  int id;
  String name;
  num price;
  String currency;
  int paymentDay;

  Bill(this.name, this.price, this.currency, this.paymentDay);

  Bill.fromMap(Map<String, dynamic> map) {
    id = map[columnId];
    name = map[columnName];
    price = map[columnPrice];
    currency = map[columnCurrency];
    paymentDay = map[columnPaymentDay];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      columnName: name,
      columnPrice: price,
      columnCurrency: currency,
      columnPaymentDay: paymentDay
    };
    if (id != null) {
      map[columnId] = id;
    }
    return map;
  }
}
