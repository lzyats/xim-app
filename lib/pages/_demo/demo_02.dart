import 'package:flutter/material.dart';
import 'package:tdesign_flutter/tdesign_flutter.dart';

class Demo02 extends StatefulWidget {
  // 路由地址
  static const String routeName = '/demo_02';
  const Demo02({super.key});

  @override
  createState() => _DemoState();
}

class _DemoState extends State<Demo02> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('滑动操作'),
      ),
      body: Column(
        children: [
          _buildSwiperCell(context),
        ],
      ),
    );
  }

  Widget _buildSwiperCell(BuildContext context) {
    // 屏幕宽度
    var screenWidth = MediaQuery.of(context).size.width;
    var list = [
      {'id': '2', 'title': '左滑操作', 'note': '辅助信息'},
      {'id': '2', 'title': '左滑操作', 'note': '辅助信息'},
      {'id': '2', 'title': '左滑操作', 'note': '辅助信息'},
      {'id': '2', 'title': '左滑操作', 'note': '辅助信息'},
      {'id': '2', 'title': '左滑操作', 'note': '辅助信息'},
      {'id': '2', 'title': '左滑操作', 'note': '辅助信息'},
      {'id': '2', 'title': '左滑操作', 'note': '辅助信息'},
      {'id': '2', 'title': '左滑操作', 'note': '辅助信息'},
      {'id': '2', 'title': '左滑操作', 'note': '辅助信息'},
    ];
    final cellLength = ValueNotifier<int>(list.length);
    return ValueListenableBuilder(
      valueListenable: cellLength,
      builder: (BuildContext context, value, Widget? child) {
        return TDCellGroup(
          cells: list
              .map(
                (e) => TDCell(
                  title: e['title'],
                  note: e['note'],
                  description: e['description'],
                ),
              )
              .toList(),
          builder: (context, cell, index) {
            return TDSwipeCell(
              slidableKey: ValueKey(list[index]['id']),
              groupTag: 'test',
              onChange: (direction, open) {
                print('打开方向：$direction');
                print('打开转态$open');
              },
              right: TDSwipeCellPanel(
                extentRatio: 180 / screenWidth,
                dragDismissible: true,
                onDismissed: (context) {
                  list.removeAt(index);
                  cellLength.value = list.length;
                },
                children: [
                  TDSwipeCellAction(
                    flex: 2,
                    backgroundColor: TDTheme.of(context).errorColor6,
                    label: '取消免打扰',
                    onPressed: (context) {
                      print('点击action');
                      print(TDSwipeCell.of(context));
                      print(TDSwipeCellInherited.of(context)?.controller);
                      list.removeAt(index);
                      cellLength.value = list.length;
                    },
                  ),
                  TDSwipeCellAction(
                    flex: 1,
                    backgroundColor: TDTheme.of(context).errorColor6,
                    label: '免打扰',
                    onPressed: (context) {
                      print('点击action');
                      print(TDSwipeCell.of(context));
                      print(TDSwipeCellInherited.of(context)?.controller);
                      list.removeAt(index);
                      cellLength.value = list.length;
                    },
                  ),
                ],
                confirms: [
                  TDSwipeCellAction(
                    backgroundColor: TDTheme.of(context).errorColor6,
                    label: '确认删除1',
                    confirmIndex: const [0],
                    onPressed: (context) {
                      print('点击action');
                      print(TDSwipeCell.of(context));
                      print(TDSwipeCellInherited.of(context)?.controller);
                      list.removeAt(index);
                      cellLength.value = list.length;
                    },
                  ),
                  TDSwipeCellAction(
                    backgroundColor: TDTheme.of(context).errorColor6,
                    label: '确认删除2',
                    confirmIndex: const [1],
                    onPressed: (context) {
                      print('点击action');
                      print(TDSwipeCell.of(context));
                      print(TDSwipeCellInherited.of(context)?.controller);
                      list.removeAt(index);
                      cellLength.value = list.length;
                    },
                  ),
                ],
              ),
              left: TDSwipeCellPanel(
                extentRatio: 180 / screenWidth,
                dragDismissible: true,
                onDismissed: (context) {
                  list.removeAt(index);
                  cellLength.value = list.length;
                },
                children: [
                  TDSwipeCellAction(
                    flex: 2,
                    backgroundColor: TDTheme.of(context).errorColor6,
                    label: '取消免打扰',
                    onPressed: (context) {
                      print('点击action');
                      print(TDSwipeCell.of(context));
                      print(TDSwipeCellInherited.of(context)?.controller);
                      list.removeAt(index);
                      cellLength.value = list.length;
                    },
                  ),
                  TDSwipeCellAction(
                    flex: 1,
                    backgroundColor: TDTheme.of(context).errorColor6,
                    label: '免打扰',
                    onPressed: (context) {
                      print('点击action');
                      print(TDSwipeCell.of(context));
                      print(TDSwipeCellInherited.of(context)?.controller);
                      list.removeAt(index);
                      cellLength.value = list.length;
                    },
                  ),
                ],
              ),
              cell: cell,
            );
          },
        );
      },
    );
  }
}
