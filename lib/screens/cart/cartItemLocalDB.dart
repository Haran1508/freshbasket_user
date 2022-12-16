import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class IteminDB {
  int count;
  int pcode;
  int id;
  static final columns = ['id', 'count', 'pcode'];
  IteminDB({required this.id, required this.count, required this.pcode});

  Map<String, dynamic> toMap() {
    return {
      'count': count,
      'pcode': pcode,
      'id': id,
    };
  }

  factory IteminDB.fromMap(Map<String, dynamic> map) {
    return IteminDB(
      count: map['count']?.toInt() ?? 0,
      pcode: map['pcode']?.toInt() ?? 0,
      id: map['id']?.toInt() ?? 0,
    );
  }

  String toJson() => json.encode(toMap());

  factory IteminDB.fromJson(String source) =>
      IteminDB.fromMap(json.decode(source));
}

class LocalDBProvider extends GetxService {
  RxList iteminDBs = [].obs;

  fetchAll() async {
    iteminDBs.value = await SQLiteDbProvider.db.getAllIteminDBs();
  }

  insertItem() async {}

  @override
  void onInit() {
    fetchAll();
    super.onInit();
  }
}

class SQLiteDbProvider {
  SQLiteDbProvider._();
  static final SQLiteDbProvider db = SQLiteDbProvider._();
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await initDB();
    return _database!;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "IteminDB.db");
    await deleteDatabase(path);
    return await openDatabase(path, version: 1, onOpen: (db) {},
        onCreate: (Database db, int version) async {
      await db.execute("CREATE TABLE Items ("
          "id INTEGER PRIMARY KEY,"
          "pcode INTEGER,"
          "count INTEGER"
          ")");
      // await db.execute(
      //     "INSERT INTO Items ('id', 'pcode', 'count') values (1, 2, 8)");
      // await db.execute(
      //     "INSERT INTO Items ('id', 'pcode', 'count') values (2, 3, 4)");
    });
  }

  Future<List<IteminDB>> getAllIteminDBs() async {
    final db = await database;
    List<Map> results =
        await db.query("Items", columns: IteminDB.columns, orderBy: "id ASC");
    List<IteminDB> iteminDBs = [];
    results.forEach((result) {
      IteminDB iteminDB = IteminDB.fromMap(result as Map<String, dynamic>);
      iteminDBs.add(iteminDB);
    });
    return iteminDBs;
  }

  //  Future<IteminDB> getIteminDBById(int id) async {
  //     final db = await database;
  //     var result = await db.query("IteminDB", where: "id = ", whereArgs: [id]);
  //     return result.isNotEmpty ? IteminDB.fromMap(result.first as Map<String, dynamic>) : Null;
  //  }
  insert(IteminDB iteminDB) async {
    final db = await database;
    var maxIdResult =
        await db.rawQuery("SELECT MAX(id)+1 as last_inserted_id FROM Items");
    var id = maxIdResult.first["last_inserted_id"];
    var result = await db.rawInsert("INSERT Into Items (id, pcode, count)"
        " VALUES ($id, ${iteminDB.pcode}, ${iteminDB.count})");
    return result;
  }

  update(IteminDB iteminDB) async {
    final db = await database;
    var result = await db.update("IteminDB", iteminDB.toMap(),
        where: "id = ?", whereArgs: [IteminDB.columns]);
    return result;
  }

  delete(int id) async {
    final db = await database;
    db.delete("IteminDB", where: "id = ?", whereArgs: [id]);
  }
}

class DataTableScreen extends StatefulWidget {
  const DataTableScreen({Key? key}) : super(key: key);

  @override
  _DataTableScreenState createState() => _DataTableScreenState();
}

class _DataTableScreenState extends State<DataTableScreen> {
  List<IteminDB> itemList = [];
  var randomGenerator = Random();

  @override
  void initState() {
    initDb();
    super.initState();
  }

  addItem(int cnt, int pcode) async {
    IteminDB newItem = IteminDB(id: 0, count: cnt, pcode: pcode);
    await SQLiteDbProvider.db.insert(newItem);
  }

  initDb() async {
    var item = await SQLiteDbProvider.db.getAllIteminDBs();
    itemList.clear();
    item.forEach((element) {
      itemList.add(element);
    });
    await initDb();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("List"),
        actions: [
          TextButton(
            onPressed: () async {
              await addItem(1, 2);
            },
            child: Text("Add Item"),
          )
        ],
      ),
      body: ListView.builder(
        itemCount: itemList.length,
        itemBuilder: (context, index) {
          return ListTile(
            title: Text(
                "Item Code ${itemList[index].pcode}  => Count is ${itemList[index].count}"),
          );
        },
      ),
    );
  }
}
