import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DatePickerScreen extends StatefulWidget {
  @override
  _DatePickerScreenState createState() => _DatePickerScreenState();
}

class _DatePickerScreenState extends State<DatePickerScreen> {

  DateTime _dateTime = DateTime.now();

  String getDateTimeFormatted(){
    return DateFormat().addPattern("EEEE dd/MM/yyyy HH:mm:ss").format(_dateTime);
    //return DateFormat.yMMMMEEEEd().format(_dateTime);
  }

  Future<TimeOfDay> getTimePicker(BuildContext context){
    return showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
        useRootNavigator: true
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('DatePicker Example'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () async {
              showDatePicker(
                  context: context,
                  initialDate: _dateTime == null ? DateTime.now() : _dateTime,
                  firstDate: DateTime(1900),
                  lastDate: DateTime(2030)
              ).then((value){
                setState(() {
                  _dateTime = value;
                });
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.access_time),
            onPressed: () async {
              TimeOfDay time = await getTimePicker(context);
              print(time);
            },
          )
        ],
      ),
      body: Center(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(20.0),
          child: Column (
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text(_dateTime != null ? getDateTimeFormatted() : DateTime.now().toString(), style: TextStyle(fontSize: 20.0)
              )
            ],
          ),
        ),
      ),
    );
  }

}
