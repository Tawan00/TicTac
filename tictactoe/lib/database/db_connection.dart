import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseConnection {
  String tableName = 'historyDB';

  setDatabase() async {
    var directory = await getDatabasesPath();
    var path = join(directory, 'db_history');
    var database =
        await openDatabase(path, version: 1, onCreate: _onCreatingDatabase);
    return database;
  }

  _onCreatingDatabase(Database database, int version) async {
    print('set database');
    await database.execute('CREATE TABLE $tableName(id INTEGER PRIMARY KEY , '
        'list TEXT ,'
        'result TEXT)');
  }
}
