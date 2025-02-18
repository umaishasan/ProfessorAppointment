import 'package:flutter/material.dart';

class SetDateComponent extends StatefulWidget {
  const SetDateComponent({super.key});
  static late String scheduleDate = '';

  @override
  // ignore: library_private_types_in_public_api
  _SetDateComponentState createState() => _SetDateComponentState();
}

class _SetDateComponentState extends State<SetDateComponent> {
  int day = 3;
  int month = 2;
  int year = 25;

  void _incrementValue(String type) {
    setState(() {
      switch (type) {
        case 'day':
          day = day < 31 ? day + 1 : 1;
          break;
        case 'month':
          month = month < 12 ? month + 1 : 1;
          break;
        case 'year':
          year = year < 99 ? year + 1 : 0;
          break;
      }
    });
  }

  void _decrementValue(String type) {
    setState(() {
      switch (type) {
        case 'day':
          day = day > 1 ? day - 1 : 31;
          break;
        case 'month':
          month = month > 1 ? month - 1 : 12;
          break;
        case 'year':
          year = year > 0 ? year - 1 : 99;
          break;
      }
    });
  }

  String _getMonthName(int month) {
    const months = [
      'January',
      'February',
      'March',
      'April',
      'May',
      'June',
      'July',
      'August',
      'September',
      'October',
      'November',
      'December'
    ];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    SetDateComponent.scheduleDate =
        "${day.toString().padLeft(2, '0')}  ${_getMonthName(month)}, 20$year";
    return Container(
      margin: const EdgeInsets.only(top: 25, left: 60, right: 60),
      constraints: const BoxConstraints(minWidth: 30, minHeight: 100),
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min, // Keeps the content compact
            children: [
              const Icon(Icons.calendar_month,
                  size: 20, color: Colors.black), // Icon
              const SizedBox(width: 8), // Gap between icon and text
              Text(
                SetDateComponent.scheduleDate,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                  color: Colors.black,
                ),
              ),
            ],
          ),

          //Date set cart
          Container(
            margin: const EdgeInsets.only(left: 60, right: 60),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _buildNumberSelector('day', day),
                const Text(
                  '/',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                _buildNumberSelector('month', month),
                const Text(
                  '/',
                  style: TextStyle(
                    fontFamily: 'Inter',
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: Colors.black,
                  ),
                ),
                _buildNumberSelector('year', year),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildNumberSelector(String type, int value) {
    return SizedBox(
      width: 28,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_up, size: 15),
            onPressed: () => _incrementValue(type),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          ),
          Text(
            value.toString().padLeft(2, '0'),
            style: const TextStyle(
              fontFamily: 'Inter',
              fontSize: 13,
              fontWeight: FontWeight.w300,
              color: Colors.black,
            ),
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_arrow_down, size: 15),
            onPressed: () => _decrementValue(type),
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 24, minHeight: 24),
          ),
        ],
      ),
    );
  }
}
