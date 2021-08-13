import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class body extends StatefulWidget {
  @override
  _bodyState createState() => _bodyState();
}

class _bodyState extends State<body> with TickerProviderStateMixin {
  TabController _tabController;
  int oScore = 0;
  int xScore = 0;
  int oCount = 0;
  int xCount = 0;
  int filledBoxes = 0;
  int sizetable = 0;
  bool ohTurn = true;
  int xoSize;
  String display1 = '';
  List<String> display = [];

  static var omyFont = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.orange, letterSpacing: 3, fontSize: 12));
  static var myFontWhite = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 12));

  @override
  void initState() {
    super.initState();
    xoSize = sizetable * sizetable;
    for (int i = 0; i < xoSize; i++) {
      // display = [i.toString()];
      // print(display);
      display.add(display1);
    }
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: const <Widget>[
            Tab(
              text: '3 X 3',
            ),
            Tab(
              text: '4 X 4',
            ),
            Tab(
              text: '5 X 5',
            ),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          _buildbody(sizetable = 3, this.display),
          _buildbody(sizetable = 4, this.display),
          _buildbody(sizetable = 5, this.display)
        ],
      ),
    );
  }

  Widget _buildbody(int size, List<String> display) {
    return Container(
      color: Colors.grey[800],
      child: Column(
        children: [
          // SizedBox(
          //   height: 15.0,
          // ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player O', style: myFontWhite),
                      SizedBox(
                        height: 10,
                      ),
                      Text(oScore.toString(), style: omyFont),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player X', style: myFontWhite),
                      SizedBox(
                        height: 10,
                      ),
                      Text(xScore.toString(), style: omyFont),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Expanded(
          //   flex: size,
          //   child: Padding(
          //     padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
          //     child: GridView.builder(
          //       itemCount: 9,
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //           crossAxisCount: size),
          //       itemBuilder: (BuildContext context, int index) {
          //         return GestureDetector(
          //           onTap: () {
          //             _tapped(index);
          //             // print(index);
          //             // print(display.length);
          //           },
          //           child: Container(
          //             decoration: BoxDecoration(
          //               border: Border.all(color: Colors.white),
          //             ),
          //             child: Center(
          //               child: Text(
          //                 display[index],
          //                 //index.toString(),
          //                 style: TextStyle(color: Colors.white, fontSize: 40),
          //               ),
          //             ),
          //           ),
          //         );
          //       },
          //     ),
          //   ),
          // ),
          Container(
            child: Column(
              children: [
                Text(
                  '${sizetable} x ${sizetable}',
                  style: myFontWhite,
                ),
                FlatButton(
                  onPressed: () {
                    _showDrawDialog();
                  },
                  child: Text(
                    display.toString(),
                    style: omyFont,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && display[index] == '') {
        display[index] = 'o';
        filledBoxes += 1;
      } else if (!ohTurn && display[index] == '') {
        display[index] = 'x';
        filledBoxes += 1;
      }
      ohTurn = !ohTurn;
      //_checkWinner();
    });
  }

  // void _checkWinner() {
  //   for (int i = 0; i < display.length; i++) {
  //     ///////////3*3
  //     if (this.widget.numsize == 3) {
  //       if (i == 0 || i == 3 || i == 6) {
  //         if (display[i] != '' &&
  //             display[i] == display[i + 1] &&
  //             display[i + 2] == display[i + 1]) {
  //           _showWinDialog(display[i]);
  //         }
  //       }
  //       if (i == 0 || i == 1 || i == 2) {
  //         if (display[i] != '' &&
  //             display[i] == display[i + this.widget.numsize] &&
  //             display[i + this.widget.numsize] ==
  //                 display[i + (this.widget.numsize + this.widget.numsize)]) {
  //           _showWinDialog(display[i]);
  //         }
  //       }
  //       if (i == 0 || i == 2) {
  //         if (display[i] != '' &&
  //             display[i] == display[i + this.widget.numsize + 1] &&
  //             display[i + this.widget.numsize + 1] ==
  //                 display[
  //                     (this.widget.numsize + 1) + (this.widget.numsize + 1)]) {
  //           _showWinDialog(display[i]);
  //         }
  //         if (display[i] != '' &&
  //             display[i] == display[i + this.widget.numsize - 1] &&
  //             display[i + this.widget.numsize - 1] ==
  //                 display[i +
  //                     (this.widget.numsize - 1) +
  //                     (this.widget.numsize - 1)]) {
  //           _showWinDialog(display[i]);
  //         }
  //       }
  //     }
  //   }
  // }

  void _showDrawDialog() {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('DRAW'),
            actions: [
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.pop(context);
                },
              )
            ],
          );
        });
  }

  void _showWinDialog(String winner) {
    showDialog(
        barrierDismissible: false,
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('WINNER IS  ' + winner),
            actions: [
              FlatButton(
                child: Text('Play Again!'),
                onPressed: () {
                  _clearBoard();
                  Navigator.pop(context);
                },
              )
            ],
          );
        });

    if (winner == 'o') {
      oScore += 1;
    } else if (winner == 'x') {
      xScore += 1;
    }
  }

  void _clearBoard() {
    setState(() {
      for (int i = 0; i < display.length; i++) {
        display[i] = '';
      }
    });
    filledBoxes = 0;
    xCount = 0;
    oCount = 0;
  }
}
