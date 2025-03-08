import 'package:flutter/material.dart';
import 'package:myacademicappointment/Components/DateComponent.dart';

class SetTimeComponent extends StatefulWidget {
  final int initialHour;
  final int initialMinute;
  final bool initialIsPM;
  static String scheduleTime = '';

  const SetTimeComponent({
    super.key,
    this.initialHour = 7,
    this.initialMinute = 0,
    this.initialIsPM = true,
  });

  @override
  // ignore: library_private_types_in_public_api
  _SetTimeComponentState createState() => _SetTimeComponentState();
}

class _SetTimeComponentState extends State<SetTimeComponent> {
  late int _hour;
  late int _minute;
  late bool _isPM;

  @override
  void initState() {
    super.initState();
    _hour = widget.initialHour;
    _minute = widget.initialMinute;
    _isPM = widget.initialIsPM;
  }

  void _incrementHour() {
    setState(() {
      _hour = (_hour % 12) + 1;
    });
  }

  void _decrementHour() {
    setState(() {
      _hour = (_hour - 2 + 12) % 12 + 1;
    });
  }

  void _incrementMinute() {
    setState(() {
      _minute = (_minute + 1) % 60;
    });
  }

  void _decrementMinute() {
    setState(() {
      _minute = (_minute - 1 + 60) % 60;
    });
  }

  void _toggleAmPm() {
    setState(() {
      _isPM = !_isPM;
    });
  }

  @override
  Widget build(BuildContext context) {
    SetTimeComponent.scheduleTime =
        '${_hour.toString().padLeft(2, '0')}:${_minute.toString().padLeft(2, '0')} ${_isPM ? 'PM' : 'AM'}';
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //For Time
        Container(
          margin: const EdgeInsets.only(left: 10, right: 10, top: 10),
          constraints: const BoxConstraints(minWidth: 190, minHeight: 100),

          //Time Show
          child: Column(
            children: [
              Row(
                mainAxisSize: MainAxisSize.min, // Keeps the content compact
                children: [
                  const Icon(Icons.access_time,
                      size: 20, color: Colors.black), // Icon
                  const SizedBox(width: 8), // Gap between icon and text
                  Text(
                    SetTimeComponent.scheduleTime,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              //Time set cart
              const SizedBox(height: 8),
              Container(
                margin: const EdgeInsets.only(left: 80, right: 80),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Column(
                  children: [
                    //Time & Hour Picker
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        // Hour controls
                        Column(
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.keyboard_arrow_up, size: 15),
                              onPressed: _incrementHour,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 24, minHeight: 24),
                            ),
                            Text(
                              _hour.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Inter',
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  size: 15),
                              onPressed: _decrementHour,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 24, minHeight: 24),
                            ),
                          ],
                        ),
                        const SizedBox(width: 8),
                        const Text(
                          ':',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            fontFamily: 'Inter',
                          ),
                        ),

                        // Minute controls
                        const SizedBox(width: 8),
                        Column(
                          children: [
                            IconButton(
                              icon:
                                  const Icon(Icons.keyboard_arrow_up, size: 15),
                              onPressed: _incrementMinute,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 24, minHeight: 24),
                            ),
                            Text(
                              _minute.toString().padLeft(2, '0'),
                              style: const TextStyle(
                                fontSize: 13,
                                fontWeight: FontWeight.w300,
                                fontFamily: 'Inter',
                              ),
                            ),
                            IconButton(
                              icon: const Icon(Icons.keyboard_arrow_down,
                                  size: 15),
                              onPressed: _decrementMinute,
                              padding: EdgeInsets.zero,
                              constraints: const BoxConstraints(
                                  minWidth: 24, minHeight: 24),
                            ),
                          ],
                        ),
                      ],
                    ),

                    //AM,PM set
                    const SizedBox(height: 8),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.arrow_left, size: 15),
                          onPressed: _toggleAmPm,
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(minWidth: 24, minHeight: 24),
                        ),
                        Text(
                          _isPM ? 'PM' : 'AM',
                          style: const TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w300,
                            fontFamily: 'Inter',
                          ),
                        ),
                        IconButton(
                          icon: const Icon(Icons.arrow_right, size: 15),
                          onPressed: _toggleAmPm,
                          padding: EdgeInsets.zero,
                          constraints:
                              const BoxConstraints(minWidth: 24, minHeight: 24),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),

        //Date
        const SetDateComponent(),
      ],
    );
  }
}
