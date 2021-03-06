import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/Home/Homepage.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:cupertino_icons/cupertino_icons.dart';
import 'package:tictactoe/Home/historyplay.dart';
import 'package:tictactoe/Home/size_helper.dart';

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
        primaryTextTheme: GoogleFonts.pressStart2PTextTheme(
          Theme.of(context)
              .primaryTextTheme, // ถ้าไม่ใส่ มันจะตั้งค่า Default ทุกอย่างตาม ThemeData.light().textTheme
        ),
        textTheme: GoogleFonts.pressStart2PTextTheme(
          Theme.of(context).textTheme,
        ),
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
      textStyle: TextStyle(color: Colors.black, letterSpacing: 3));
  static var ogFont = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.orange, letterSpacing: 3, fontSize: 12));
  TextEditingController tablesize = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double w = displayWidth(context) * 0.9;
    double h = displayHeight(context) -
        MediaQuery.of(context).padding.top -
        kToolbarHeight;
    return Scaffold(
      backgroundColor: Colors.teal[50],
      body: ListView(
        children: [
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: 60),
                  child: Container(
                    child: Text(
                      'GAME',
                      style: ogFont.copyWith(fontSize: w * 0.08),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: Container(
                    child: Text(
                      'TIC TAC TOE',
                      style: FontWhite.copyWith(fontSize: w * 0.08),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30),
                  child: Container(
                    child: Image.asset('lib/images/logo.png'),
                    height: h * 0.3,
                    width: w * 0.7,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 30, bottom: 20),
                  child: Container(
                    child: Text(
                      'TABLE SIZE',
                      style: FontWhite.copyWith(fontSize: w * 0.06),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      top: 16.0, bottom: 16.0, right: 50, left: 50),
                  child: Container(
                    padding: EdgeInsets.only(left: 16.0, right: 16.0),
                    decoration: BoxDecoration(
                        border:
                            Border.all(color: Colors.black, width: w * 0.01),
                        borderRadius: BorderRadius.circular(15)),
                    child: DropdownButton(
                      hint: Text('SELECT SIZE TABLE',
                          style: FontWhite.copyWith(
                              color: Colors.black, fontSize: w * 0.02)),
                      dropdownColor: Colors.white,
                      icon: Icon(
                        Icons.arrow_drop_down,
                        color: Colors.black,
                      ),
                      iconSize: w * 0.08,
                      isExpanded: true,
                      underline: SizedBox(),
                      style: omyFont.copyWith(color: Colors.black),
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
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox.fromSize(
        size: Size.square(h * 0.13),
        child: FloatingActionButton(
          onPressed: () {
            if (tablesize.text != "") {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) =>
                        Home(tablesize: int.parse((tablesize.text)))),
              );
            } else if (tablesize.text == "") {
              _InputDialog();
            }
          },
          child: Icon(
            CupertinoIcons.game_controller,
            size: h * 0.09,
            color: Colors.white,
          ),
          backgroundColor: Colors.green[400],
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        notchMargin: 15.0,
        color: Colors.transparent,
        elevation: 25.0,
        clipBehavior: Clip.antiAlias,
        child: Container(
          height: h * 0.09,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(80.0),
                topRight: Radius.circular(80.0),
              ),
              color: Colors.greenAccent),
        ),
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
