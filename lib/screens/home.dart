

import 'dart:ui';

import 'package:covidninja/services/reminder.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_switch/flutter_switch.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:vibration/vibration.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => HomeScreenState();
}


class HomeScreenState extends State<HomeScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _reminderMinutes = TextEditingController();
  final TextEditingController _lon = TextEditingController();
  final TextEditingController _lat = TextEditingController();
  bool _isReminderOn = true;
  List<String> _types = ['10','20', '30', '60'];

  ReminderService reminderService = ReminderService();

  @override
  void initState() {
    super.initState();
    _reminderMinutes.text = '10';
    _lat.text = '27.7189° N';
    _lon.text = '85.3195° E';
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: EdgeInsets.only(
        top: 40, bottom: 20, left: 16, right: 16),
    child: Form(
    key: _formKey,
    child: ListView(children: [

    Row(
    mainAxisAlignment:
    MainAxisAlignment.spaceBetween,
    children: <Widget>[
       Expanded(
        flex: 10, // 20%
        child: Text("Home address",style: TextStyle(
            fontFamily: 'RobotoMono',
            ))
      )]),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 10, // 20%
            child: TextField(
              controller: _lat,
              decoration: InputDecoration(
                prefixIcon: Icon(
                    Icons.location_on_outlined),
                labelText: 'Latitude',
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.lightBlue[900]),
                ),
              ),
            ),
          )
        ],
      ),
      SizedBox(
        height: 15,
      ),
      Row(
        mainAxisAlignment:
        MainAxisAlignment.spaceBetween,
        children: <Widget>[
          Expanded(
            flex: 10, // 20%
            child: TextField(
              controller: _lon,
              decoration: InputDecoration(
                labelText: 'Longitude',
                prefixIcon: Icon(
                    Icons.location_on_outlined),
                border: OutlineInputBorder(
                  borderSide: BorderSide(
                      color: Colors.lightBlue[900]),
                ),
              ),
            ),
          )
        ]
      ),
      SizedBox(
        height: 15,
      ),
        Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: <Widget>[
            Expanded(
            flex: 6, // 20%
            child:_thingsTypeField(context)
            ),
              Expanded(
                  flex: 4, // 20%
                  child: SizedBox()),
              ]
        ),
      SizedBox(
        height: 25,
      ),
      Row(
          mainAxisAlignment:
          MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Expanded(
                flex: 3, // 20%
                child:Text('Reminder')),
            Container(
              child:
            Expanded(
              flex: 7, // 20%
              child: FlutterSwitch(
                width: 125.0,
                height: 40.0,
                activeColor: Colors.lightBlue[900],
                valueFontSize: 25.0,
                toggleSize: 45.0,
                value: _isReminderOn,
                borderRadius: 30.0,
                showOnOff: true,
                onToggle: (val) {
                  setState(() {
                    _isReminderOn = val;
                  });
                },
              )
            ))

          ]
      ),
      SizedBox(
        height: 30,
      ),
        Row(
            mainAxisAlignment:
            MainAxisAlignment.spaceBetween,
            children: <Widget>[
      Expanded(
          flex: 10, // 20%
          child: OutlinedButton(
            child: Text(
              'Save',
            ),
            style: OutlinedButton.styleFrom(
              padding: EdgeInsets.all(18),
              shape: RoundedRectangleBorder(
                side: BorderSide(
                    color: Colors.lightBlue[900]),
              ),
              primary: Colors.white,
              backgroundColor:
              Colors.lightBlue[900],
            ),
            onPressed: () {
              reminderService.update(_lat.text,
                  _lon.text,
                  int.parse(_reminderMinutes.text),
                  _isReminderOn);

              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: const Text('Done'),
                  duration: const Duration(milliseconds: 1500),
                  width: 280.0, // Width of the SnackBar.
                  padding: const EdgeInsets.symmetric(
                    horizontal: 8.0, // Inner padding for SnackBar content.
                  ),
                  behavior: SnackBarBehavior.floating,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
              );

            },
          ))])
    ])
    )
    );
  }

  Widget _thingsTypeField(BuildContext context) {
    return TypeAheadFormField(
      textFieldConfiguration: TextFieldConfiguration(
        controller: _reminderMinutes,
        autofocus: true,
        style: DefaultTextStyle.of(context).style.copyWith(),
        decoration: InputDecoration(
          labelText: 'Reminder in every minutes?',
          prefixIcon: Icon(Icons.arrow_drop_down_circle_outlined),
          border: OutlineInputBorder(
            borderSide: BorderSide(color: Colors.lightBlue[900]),
          ),
        ),
      ),
      itemBuilder: (BuildContext context, itemData) {
        return ListTile(
          title: Text(
            itemData,
          ),
        );
      },
      suggestionsCallback: (pattern) {
        return _types.where((element) =>
           element.toLowerCase().contains(pattern.toLowerCase()));
      },
      onSuggestionSelected: (String v) {
        _reminderMinutes.text = v ;
      },
      validator: (value) {
        if (value.isEmpty) {
          return 'Remind in every ?';
        }
        return null;
      },
    );
  }
}