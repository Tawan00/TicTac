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
  static var omyFont = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.black, letterSpacing: 3, fontSize: 12));
  static var myFontWhite = GoogleFonts.pressStart2P(
      textStyle: TextStyle(color: Colors.white, letterSpacing: 3));
  TextEditingController numsize = TextEditingController();

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
                      'TIC TAC TOE',
                      style: myFontWhite.copyWith(fontSize: 25.0),
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
                      style: myFontWhite.copyWith(fontSize: 15.0),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(10),
                  child: Container(
                    padding:
                        EdgeInsets.only(top: 10.0, left: 50.0, right: 50.0),
                    child: TextField(
                      style: myFontWhite.copyWith(fontSize: 15.0),
                      controller: numsize,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        // labelText: '',
                      ),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {
                    if (numsize.text != "") {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                Home(numsize: int.parse((numsize.text)))),
                      );
                    } else if (numsize.text == "") {
                      _InputDialog();
                    }
                  },
                  child: Padding(
                    padding: EdgeInsets.only(top: 40.0, bottom: 30.0),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(25.0),
                      child: Container(
                        padding: EdgeInsets.all(30.0),
                        color: Colors.white,
                        child: Text(
                          'PLAY GAME',
                          style: myFontWhite.copyWith(color: Colors.black),
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
