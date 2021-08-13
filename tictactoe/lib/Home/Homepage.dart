import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Home extends StatefulWidget {
  int numsize;
  Home({this.numsize});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool ohTurn = true;
  int xoSize;
  String display1 = '';
  List<String> display = [];

  //List<String> display = ['', '', '', '', '', '', '', '', ''];
  @override
  void initState() {
    super.initState();
    xoSize = widget.numsize * widget.numsize;
    for (int i = 0; i < xoSize; i++) {
      // display = [i.toString()];
      // print(display);
      display.add(display1);
    }

    print(display);
    // print(display1);
  }

  static var omyFont = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.orange, letterSpacing: 3, fontSize: 12));
  static var myFontWhite = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.white, letterSpacing: 3, fontSize: 12));

  int oScore = 0;
  int xScore = 0;
  int oCount = 0;
  int xCount = 0;
  int filledBoxes = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      appBar: AppBar(
        backgroundColor: Colors.grey[800],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
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
          Expanded(
            flex: widget.numsize,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: GridView.builder(
                itemCount: display.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.numsize),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _tapped(index);
                      // print(index);
                      // print(display.length);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          display[index],
                          //index.toString(),
                          style: TextStyle(color: Colors.white, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Container(
            child: Column(
              children: [
                Text(
                  '${widget.numsize} x ${widget.numsize}',
                  style: myFontWhite,
                ),
                FlatButton(
                  onPressed: () {
                    _showDrawDialog();
                  },
                  child: Text(
                    'HISTORY PLAY!',
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
      _checkWinner();
    });
  }

  // void _checkWinner2() {
  //   int x = 0;
  //   List<int> addOX = [];
  //   for (int i = 0; i < display.length; i++) {
  //     if (display[i] == 'o') {
  //       oCount += 1;
  //       xCount = 0;
  //       if (oCount == widget.numsize) {
  //         _showWinDialog(display[i]);
  //         oCount = 0;
  //         print('O WIN');
  //         addOX.add(i);
  //         break;
  //       }
  //     }
  //     if (display[i] == 'x') {
  //       xCount += 1;
  //       oCount = 0;
  //       if (xCount == widget.numsize) {
  //         _showWinDialog(display[i]);
  //         xCount = 0;
  //         print('X WIN');
  //         addOX.add(i);
  //         break;
  //       }
  //     }
  //   }
  // }

  void _checkWinner() {
    for (int i = 0; i < display.length; i++) {
      ///////////3*3
      if (this.widget.numsize == 3) {
        if (i == 0 || i == 3 || i == 6) {
          if (display[i] != '' &&
              display[i] == display[i + 1] &&
              display[i + 2] == display[i + 1]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 1 || i == 2) {
          if (display[i] != '' &&
              display[i] == display[i + this.widget.numsize] &&
              display[i + this.widget.numsize] ==
                  display[i + (this.widget.numsize + this.widget.numsize)]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 2) {
          if (display[i] != '' &&
              display[i] == display[i + this.widget.numsize + 1] &&
              display[i + this.widget.numsize + 1] ==
                  display[
                      (this.widget.numsize + 1) + (this.widget.numsize + 1)]) {
            _showWinDialog(display[i]);
          }
          if (display[i] != '' &&
              display[i] == display[i + this.widget.numsize - 1] &&
              display[i + this.widget.numsize - 1] ==
                  display[i +
                      (this.widget.numsize - 1) +
                      (this.widget.numsize - 1)]) {
            _showWinDialog(display[i]);
          }
        }
      }

//////////// 4*4
      if (this.widget.numsize == 4) {
        if (i == 0 || i == 4 || i == 8 || i == 12) {
          if (display[i] != '' &&
              display[i] == display[i + 1] && /////////แนวนอน
              display[i + 1] == display[i + 2] &&
              display[i + 2] == display[i + 3]) {
            _showWinDialog(display[i]);
          }
        }

        if (i == 0 || i == 1 || i == 2 || i == 3) {
          if (display[i] != '' &&
              display[i] == display[i + this.widget.numsize] &&
              display[i + this.widget.numsize] ==
                  display[i + (this.widget.numsize * 2)] && /////แนวตั้ง
              display[i + (this.widget.numsize * 2)] ==
                  display[i + (this.widget.numsize * 3)]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 3) {
          if (display[i] != '' &&
              display[i] == display[i + this.widget.numsize + 1] &&
              display[i + this.widget.numsize + 1] ==
                  display[(this.widget.numsize + 1) * 2] &&
              display[(this.widget.numsize + 1) * 2] ==
                  display[(this.widget.numsize + 1) * 3]) {
            _showWinDialog(display[i]); ////แนวทะแยง
          }
          if (display[i] != '' &&
              display[i] == display[i + this.widget.numsize - 1] &&
              display[i + this.widget.numsize - 1] ==
                  display[i + (this.widget.numsize - 1) * 2] &&
              display[i + (this.widget.numsize - 1) * 2] ==
                  display[i + (this.widget.numsize - 1) * 3]) {
            _showWinDialog(display[i]);
          }
        }
      }
      //////////// 5*5
      if (this.widget.numsize == 5) {
        if (i == 0 || i == 5 || i == 10 || i == 15 || i == 20) {
          if (display[i] != '' &&
              display[i] == display[i + 1] && /////////แนวนอน
              display[i + 1] == display[i + 2] &&
              display[i + 2] == display[i + 3] &&
              display[i + 3] == display[i + 4]) {
            _showWinDialog(display[i]);
          }
        }

        if (i == 0 || i == 1 || i == 2 || i == 3 || i == 4) {
          if (display[i] != '' &&
              display[i] == display[i + this.widget.numsize] &&
              display[i + this.widget.numsize] ==
                  display[i + (this.widget.numsize * 2)] && /////แนวตั้ง
              display[i + (this.widget.numsize * 2)] ==
                  display[i + (this.widget.numsize * 3)] &&
              display[i + (this.widget.numsize * 3)] ==
                  display[i + (this.widget.numsize * 4)]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 4) {
          if (display[i] != '' &&
              display[i] == display[i + this.widget.numsize + 1] &&
              display[i + this.widget.numsize + 1] ==
                  display[(this.widget.numsize + 1) * 2] &&
              display[(this.widget.numsize + 1) * 2] ==
                  display[(this.widget.numsize + 1) * 3] &&
              display[(this.widget.numsize + 1) * 3] ==
                  display[(this.widget.numsize + 1) * 4]) {
            _showWinDialog(display[i]); ////แนวทะแยง
          }
          if (display[i] != '' &&
              display[i] == display[i + this.widget.numsize - 1] &&
              display[i + this.widget.numsize - 1] ==
                  display[i + (this.widget.numsize - 1) * 2] &&
              display[i + (this.widget.numsize - 1) * 2] ==
                  display[i + (this.widget.numsize - 1) * 3] &&
              display[i + (this.widget.numsize - 1) * 3] ==
                  display[i + (this.widget.numsize - 1) * 4]) {
            _showWinDialog(display[i]);
          }
        }
      }
    }

////////////Draw
    if (filledBoxes == display.length) {
      _showDrawDialog();
    }
  }

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
