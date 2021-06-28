// @dart=2.9
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class JourneyItemView extends StatefulWidget {
  const JourneyItemView({Key key}) : super(key: key);

  @override
  _JourneyItemViewState createState() => _JourneyItemViewState();
}

Size _size;
DateTime _selectedDate;

class _JourneyItemViewState extends State<JourneyItemView> {
  @override
  void initState() {
    _selectedDate = DateTime.now();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _size = MediaQuery.of(context).size;
    return Container(
      width: _size.width,
      height: _size.height * 0.2,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: _size.width,
              height: _size.height * 0.2,
              child: Stack(
                children: [
                  InkWell(
                    onTap: () async {
                      final DateTime datePicked = await showDatePicker(
                        context: context,
                        initialDate: _selectedDate,
                        firstDate: DateTime(2010),
                        lastDate: DateTime(2050),
                      );
                      if (datePicked != null && datePicked != _selectedDate) {
                        setState(() {
                          _selectedDate = datePicked;
                        });
                      }
                    },
                    child: Container(
                      width: _size.width * 0.2,
                      height: _size.width * 0.2,
                      margin: EdgeInsets.all(_size.width * 0.01),
                      decoration: BoxDecoration(
                          color: Colors.amber[600], shape: BoxShape.circle),
                      child: Center(
                          child: Text(
                        DateFormat('dd/MM').format(_selectedDate),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      )),
                    ),
                  ),
                  Positioned(
                    top: -_size.width * 0.02,
                    left: _size.width * 0.22,
                    child: Container(
                      width: _size.width * 0.8,
                      height: _size.height * 0.2,
                      child: ListView.builder(
                        itemCount: 2,
                        itemBuilder: (context, index) {
                          return Row(
                            children: [
                              Checkbox(
                                value: false,
                                onChanged: (value) {},
                              ),
                              Text('Xuất phát')
                            ],
                          );
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              width: _size.width,
              height: _size.height * 0.2,
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }
}
