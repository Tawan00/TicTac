import 'package:flutter/material.dart';
import 'package:tictactoe/Home/Homepage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int Selectvalue;
  List<int> listItem = [3, 4, 5, 6, 7, 8];
  static var omyFont = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.black, letterSpacing: 3, fontSize: 12));
  static var FontWhite = GoogleFonts.pressStart2P(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3));
  static var ogFont = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.orange, letterSpacing: 3, fontSize: 12));
  TextEditingController tablesize = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[900],
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 120.0),
                  child: Container(
                    child: Text(
                      'GAME',
                      style: ogFont.copyWith(fontSize: 25.0),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: Text(
                      'TIC TAC TOE',
                      style: FontWhite.copyWith(fontSize: 25.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    child: Image.asset('lib/images/xoWhite.png'),
                    height: 150.0,
                    width: 150.0,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 50.0),
                  child: Container(
                    child: Text(
                      'TABLE SIZE',
                      style: FontWhite.copyWith(fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, bottom: 16.0, right: 50, left: 50),
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.white, width: 1),
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton(
                      hint: Text('SELECT SIZE TABLE',
                          style: FontWhite.copyWith(
                              color: Colors.white, fontSize: 7.0)),
                      dropdownColor: Colors.grey[600],
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.white,
                      ),
                      iconSize: 36,
                      isExpanded: true,
                      underline: SizedBox(),
                      style: omyFont.copyWith(color: Colors.white),
                      value: Selectvalue,
                      onChanged: (newValue) {
                        setState(() {
                          Selectvalue = newValue;
                          tablesize.text = newValue.toString();
                        });
                      },
                      items: listItem.map((valueItem) {
                        return DropdownMenuItem(
                          value: valueItem,
                          child: Text(valueItem.toString()),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (tablesize.text != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Home(numsize: int.parse((tablesize.text)))),
                      );
                    } else if (tablesize.text == "") {
                      _InputDialog();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 30.0, bottom: 30.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        color: Colors.white,
                        child: Text(
                          'PLAY',
                          style: FontWhite.copyWith(color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _InputDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('YOU NOT INPUT TABLE SIZE!!!'),
            actions: [
              FlatButton(
                child: Text(
                  'OK',
                  style: TextStyle(fontSize: 20),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }
}
