import 'package:flutter/material.dart';
import 'package:getuiflut/getuiflut.dart';

class Demo03 extends StatefulWidget {
  // 路由地址
  static const String routeName = '/demo_03';
  const Demo03({super.key});

  @override
  createState() => _DemoState();
}

class _DemoState extends State<Demo03> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('demo03'),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () async {
          //7357e1989baea209fac718fcd02c8fac
          print(await Getuiflut.getClientId);
          Getuiflut().bindAlias('2', '1');
          // Getuiflut().bindAlias('2', '2');
        },
      ),
    );
  }
}
