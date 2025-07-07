import 'package:flutter/material.dart';
import 'package:alpaca/config/app_config.dart';
import 'package:alpaca/widgets/widget_button.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart' as path_;

class DemoSqflite extends StatefulWidget {
  // 路由地址
  static const String routeName = '/demo_sqflite';
  const DemoSqflite({super.key});

  @override
  createState() => _DemoState();
}

class _DemoState extends State<DemoSqflite> {
  TextEditingController controller = TextEditingController();

  void setValue(String value) {
    String date = DateTime.now().toString();
    controller.text = '$date\n$value';
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('数据库操作'),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            WidgetButton(
              label: '结构=查询',
              onTap: () async {
                Database db = await _initDB();
                var cursor = await db.rawQuery('PRAGMA table_info(chat_phone)');
                setValue(cursor.toString());
                await db.close();
              },
            ),
            WidgetButton(
              label: '结构=清空',
              onTap: () async {
                // Database db = await _initDB();
                // String sql = 'DROP TABLE IF EXISTS t1';
                // await db.execute(sql);
                // setValue('删除成功');
                // await db.close();
              },
            ),
            WidgetButton(
              label: '结构=更新',
              onTap: () async {
                Database db = await _initDB();
                // String sql1 = 'DROP TABLE IF EXISTS chat_phone;';
                // await db.execute(sql1);
                String sql = 'CREATE TABLE chat_phone (phone TEXT, token TEXT)';
                await db.execute(sql);
                setValue('更新成功');
                db.close();
              },
            ),
            WidgetButton(
              label: '数据=查询',
              onTap: () async {
                Database db = await _initDB();
                // 查询
                List<Map<String, dynamic>> dataList = await db.query(
                  'chat_his',
                  columns: [
                    'chatId',
                    'badger',
                  ],
                  where: 'chatId = ?',
                  whereArgs: [1780434496923394049],
                );
                await db.update(
                  'chat_his',
                  {'badger': 'Y'},
                  where: 'chatId = ? and msgId = ?',
                  whereArgs: [
                    1780434496923394049,
                    '(SELECT MAX(msgId) FROM chat_his where chatId = 1780434496923394049)'
                  ],
                  conflictAlgorithm: ConflictAlgorithm.ignore,
                );
                // 查询
                dataList = await db.query(
                  'chat_his',
                  columns: [
                    'chatId',
                    'badger',
                  ],
                  where: 'chatId = ? ',
                  whereArgs: [1780434496923394049],
                );
                setValue(dataList.toString());
                db.close();
              },
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                controller: controller,
                maxLines: 7,
                readOnly: true,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // 初始化
  Future<Database> _initDB() async {
    String databasesPath = await getDatabasesPath();
    return await openDatabase(
      path_.join(databasesPath, AppConfig.dbName),
    );
  }
}
