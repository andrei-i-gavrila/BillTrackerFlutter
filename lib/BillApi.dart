import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:bill_tracker/Bill.dart';
import 'package:http/http.dart' as http;


class BillApi {

  static const baseUrl = "https://bills.codespace.ro/api";

  Future<List<Bill>> getBills() async {
    var url = Uri.parse(baseUrl + "/bills");

    try {
      var response = await http.get(url);
      if (response.statusCode != 200) {
        print(response.body);
        return null;
      }
      Iterable bills = jsonDecode(response.body);
      return bills.map((billModel) => Bill.fromJsonMap(billModel)).toList();
    } catch (e) {
      print(e.toString());
      return null;
    }
  }

  Future<bool> saveBill(Bill bill) async {
    var url = Uri.parse(baseUrl + "/bills");

    try {
      var client = http.Client();
      var response = await client.post(url, headers: {'Content-Type': 'application/json'}, body: jsonEncode(bill.toJsonMap()));
      return response.statusCode == 200;
    } catch (e) {
      print(e.toString());
      return false;
    }
  }

  Future<bool> deleteBill(Bill bill) async {
    var url = Uri.parse(baseUrl + "/bills/" + bill.id.toString());

    try {
      var response = await http.delete(url);
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

}