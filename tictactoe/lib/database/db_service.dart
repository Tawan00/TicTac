import 'package:sqflite/sqflite.dart';
import 'package:tictactoe/database/db_connection.dart';

class DBService {
  DatabaseConnection _databaseConnection;
  String tableName = 'historyDB';

  DBService() {
    _databaseConnection = DatabaseConnection();
  }
  static Database _database;

  Future<Database> get database async {
    if (_database != null) return _database;
    _database = await _databaseConnection.setDatabase();
    return _database;
  }

  readData() async {
    var connection = await database;
    return await connection.query(tableName);
  }

  insertData(data) async {
    var connection = await database;
    return await connection.insert(tableName, data);
  }

  deleteData(historyId) async {
    var connection = await database;
    return await connection.delete(tableName);
  }
}
