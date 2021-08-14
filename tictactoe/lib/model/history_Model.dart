import 'package:flutter/material.dart';

class HistoryModel {
  int id;
  String list;
  String result;

  // HistoryModel({this.id, this.list, this.result});

  historyMap() {
    var mapping = Map<String, dynamic>();
    mapping['id'] = id;
    mapping['list'] = list;
    mapping['result'] = result;

    return mapping;
  }
}
