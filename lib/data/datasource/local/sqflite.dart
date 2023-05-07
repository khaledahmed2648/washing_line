import 'dart:async';

import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
class SqlDb{
  static Database? _db;
  Future<Database?> get db async{
    if(_db==null){
      _db= await initialDb();
      return _db;
    }
    else{
      return _db;
    }
  }
  Future<Database> initialDb()async{
    String databasePath=await getDatabasesPath();
    String path=join('databasePath_onCreatedb');
    return await openDatabase(path,onCreate: _onCreate,version: 1);
  }


  FutureOr<void> _onCreate(Database db, int version) {
    db.execute(
      '''CREATE TABLE shop (
        "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
        "productId" INTEGER NOT NULL,
        "productName" varchar(255) NOT NULL,
        "productImage" TEXT NOT NULL,
        "productQuantity" INTEGER NOT NULL,
        "productPrice" varchar(255) NOT NULL
    );'''
    );
  }

  Future<List<Map<String,dynamic>>>readData(String sql)async{
    Database? myDb=await db;
    List<Map<String,dynamic>> response=await myDb!.rawQuery(sql);
    return response;
  }

  Future<int>insertData(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.rawInsert(sql);
    return response;
  }

  Future<int>updateData(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.rawUpdate(sql);
    return response;
  }


  Future<int>deleteData(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.rawDelete(sql);
    return response;
  }
  Future<int>deleteTable(String sql)async{
    Database? myDb=await db;
    int response=await myDb!.delete(sql);
    return response;
  }
  Future<bool>checkItem(String itemName,String itemValue)async{
    Database? myDb=await db;
    final response=await myDb!.rawQuery("SELECT * FROM 'shop' WHERE $itemName=$itemValue");
    return response.isNotEmpty;
  }

}