import 'package:flutter/material.dart';

class DemoBriday extends StatefulWidget {
  // 路由地址
  static const String routeName = '/demo_briday';
  const DemoBriday({super.key});

  @override
  createState() => _MySettingDetailsState();
}

class _MySettingDetailsState extends State<DemoBriday> {
  DateTime? _selectedDate; //生日默认值

  @override
  Widget build(BuildContext context) {
    String title = '修改详情';
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: Column(
        children: [
          _editBriday(context),
        ],
      ),
    );
  }

  Widget _editBriday(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        children: [
          InkWell(
            onTap: () {
              _selectDate(context);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey),
                borderRadius: BorderRadius.circular(5.0),
              ),
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    _selectedDate != null
                        ? '生日: ${_selectedDate?.toLocal()}'
                        : '选择生日',
                  ),
                  const Icon(Icons.calendar_today),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }
}
