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
  List<String> display = [];
  //List<String> display = ['', '', '', '', '', '', '', '', ''];
  @override
  void initState() {
    super.initState();
    xoSize = widget.numsize * widget.numsize;
    for (int i = 0; i < xoSize; i++) {
      // display = [i.toString()];
      // print(display);
      display.add(i.toString());
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
            // Navigator.of(context).push(MaterialPageRoute(
            //     builder: (context) => HomePage(
            //           username: this.widget.username,
            //         )));
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
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.white),
                      ),
                      child: Center(
                        child: Text(
                          display[index],
                          // index.toString(),
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
                  'TIC TAC TOE',
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

  void _checkWinner() {
    if (display[0] == display[1] &&
        display[0] == display[2] &&
        display[0] != '') {
      _showWinDialog(display[0]);
    }
    if (display[3] == display[4] &&
        display[3] == display[5] &&
        display[3] != '') {
      _showWinDialog(display[3]);
    }
    if (display[6] == display[7] &&
        display[6] == display[8] &&
        display[6] != '') {
      _showWinDialog(display[6]);
    }
    if (display[0] == display[3] &&
        display[0] == display[6] &&
        display[0] != '') {
      _showWinDialog(display[0]);
    }
    if (display[1] == display[4] &&
        display[1] == display[7] &&
        display[1] != '') {
      _showWinDialog(display[1]);
    }
    if (display[2] == display[5] &&
        display[2] == display[8] &&
        display[2] != '') {
      _showWinDialog(display[2]);
    }
    if (display[6] == display[4] &&
        display[6] == display[2] &&
        display[6] != '') {
      _showWinDialog(display[6]);
    }
    if (display[0] == display[4] &&
        display[0] == display[8] &&
        display[0] != '') {
      _showWinDialog(display[0]);
    } else if (filledBoxes == 9) {
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
      for (int i = 0; i < 9; i++) {
        display[i] = '';
      }
    });
    filledBoxes = 0;
  }
}
