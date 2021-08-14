import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:tictactoe/Home/historyplay.dart';
import 'package:tictactoe/database/db_service.dart';
import 'package:tictactoe/model/history_Model.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class Home extends StatefulWidget {
  int tablesize;
  Home({this.tablesize});
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool OxTurn = true;
  int xoSize;
  String display1 = '';
  List<String> display = [];

  @override
  void initState() {
    super.initState();
    xoSize = widget.tablesize * widget.tablesize;
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
  String win = 'WINNER';
  String tie = 'DRAW';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.teal[50],
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            CupertinoIcons.arrowtriangle_left_fill,
            color: Colors.grey,
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 15.0,
          ),
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player O',
                          style: omyFont.copyWith(color: Colors.black)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(oScore.toString(),
                          style: omyFont.copyWith(
                              color: Colors.black, fontSize: 15)),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30, right: 30),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('Player X',
                          style: omyFont.copyWith(color: Colors.black)),
                      SizedBox(
                        height: 10,
                      ),
                      Text(xScore.toString(),
                          style: omyFont.copyWith(
                              color: Colors.black, fontSize: 15)),
                    ],
                  ),
                ),
              ],
            ),
          ),
          Expanded(
            flex: widget.tablesize,
            child: Padding(
              padding: const EdgeInsets.only(top: 80, left: 20, right: 20),
              child: GridView.builder(
                itemCount: display.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: widget.tablesize),
                itemBuilder: (BuildContext context, int index) {
                  return GestureDetector(
                    onTap: () {
                      _press(index);
                      // print(index);
                      // print(display.length);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Center(
                        child: Text(
                          display[index],
                          // index.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 40),
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: SizedBox.fromSize(
        size: Size.square(80),
        child: FloatingActionButton(
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => historyPlay()));
          },
          child: Icon(
            CupertinoIcons.doc_text_search,
            size: 40.0,
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
          height: 70.0,
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

  void _press(int index) {
    setState(() {
      if (OxTurn && display[index] == '') {
        display[index] = 'o';
        filledBoxes += 1;
      } else if (!OxTurn && display[index] == '') {
        display[index] = 'x';
        filledBoxes += 1;
      }
      OxTurn = !OxTurn;
      _checkWinner();
    });
  }

  void _checkWinner() {
    for (int i = 0; i < display.length; i++) {
      ///////////3*3
      if (this.widget.tablesize == 3) {
        if (i == 0 || i == 3 || i == 6) {
          if (display[i] != '' &&
              display[i] == display[i + 1] &&
              display[i + 2] == display[i + 1]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 1 || i == 2) {
          if (display[i] != '' &&
              display[i] == display[i + this.widget.tablesize] &&
              display[i + widget.tablesize] ==
                  display[i + (widget.tablesize * 2)]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 2) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize + 1] &&
              display[i + widget.tablesize + 1] ==
                  display[(widget.tablesize + 1) * 2]) {
            _showWinDialog(display[i]);
          } else if (display[i] != '' &&
              display[i] == display[i + widget.tablesize - 1] &&
              display[i + widget.tablesize - 1] ==
                  display[i + (widget.tablesize - 1) * 2]) {
            _showWinDialog(display[i]);
          }
        }
      }

//////////// 4*4
      if (this.widget.tablesize == 4) {
        if (i == 0 || i == 4 || i == 8 || i == 12) {
          if (display[i] != '' &&
              display[i] == display[i + 1] &&
              display[i + 1] == display[i + 2] &&
              display[i + 2] == display[i + 3]) {
            _showWinDialog(display[i]);
          }
        }

        if (i == 0 || i == 1 || i == 2 || i == 3) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize] &&
              display[i + widget.tablesize] ==
                  display[i + (widget.tablesize * 2)] &&
              display[i + (widget.tablesize * 2)] ==
                  display[i + (widget.tablesize * 3)]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 3) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize + 1] &&
              display[i + widget.tablesize + 1] ==
                  display[(widget.tablesize + 1) * 2] &&
              display[(widget.tablesize + 1) * 2] ==
                  display[(widget.tablesize + 1) * 3]) {
            _showWinDialog(display[i]); ////แนวทะแยง
          } else if (display[i] != '' &&
              display[i] == display[i + widget.tablesize - 1] &&
              display[i + widget.tablesize - 1] ==
                  display[i + (widget.tablesize - 1) * 2] &&
              display[i + (widget.tablesize - 1) * 2] ==
                  display[i + (widget.tablesize - 1) * 3]) {
            _showWinDialog(display[i]);
          }
        }
      }
      //////////// 5*5
      if (this.widget.tablesize == 5) {
        if (i == 0 || i == 5 || i == 10 || i == 15 || i == 20) {
          if (display[i] != '' &&
              display[i] == display[i + 1] &&
              display[i + 1] == display[i + 2] &&
              display[i + 2] == display[i + 3] &&
              display[i + 3] == display[i + 4]) {
            _showWinDialog(display[i]);
          }
        }

        if (i == 0 || i == 1 || i == 2 || i == 3 || i == 4) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize] &&
              display[i + widget.tablesize] ==
                  display[i + (widget.tablesize * 2)] &&
              display[i + (widget.tablesize * 2)] ==
                  display[i + (widget.tablesize * 3)] &&
              display[i + (widget.tablesize * 3)] ==
                  display[i + (widget.tablesize * 4)]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 4) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize + 1] &&
              display[i + widget.tablesize + 1] ==
                  display[(widget.tablesize + 1) * 2] &&
              display[(widget.tablesize + 1) * 2] ==
                  display[(widget.tablesize + 1) * 3] &&
              display[(widget.tablesize + 1) * 3] ==
                  display[(widget.tablesize + 1) * 4]) {
            _showWinDialog(display[i]); ////แนวทะแยง
          } else if (display[i] != '' &&
              display[i] == display[i + widget.tablesize - 1] &&
              display[i + widget.tablesize - 1] ==
                  display[i + (widget.tablesize - 1) * 2] &&
              display[i + (widget.tablesize - 1) * 2] ==
                  display[i + (widget.tablesize - 1) * 3] &&
              display[i + (widget.tablesize - 1) * 3] ==
                  display[i + (widget.tablesize - 1) * 4]) {
            _showWinDialog(display[i]);
          }
        }
      }

      //////////// 6*6
      if (this.widget.tablesize == 6) {
        if (i == 0 || i == 6 || i == 12 || i == 18 || i == 24 || i == 30) {
          if (display[i] != '' &&
              display[i] == display[i + 1] &&
              display[i + 1] == display[i + 2] &&
              display[i + 2] == display[i + 3] && ////////แนวตั้ง
              display[i + 3] == display[i + 4] &&
              display[i + 4] == display[i + 5]) {
            _showWinDialog(display[i]);
          }
        }

        if (i == 0 || i == 1 || i == 2 || i == 3 || i == 4 || i == 5) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize] &&
              display[i + widget.tablesize] ==
                  display[i + (widget.tablesize * 2)] && /////แนวนอน
              display[i + (widget.tablesize * 2)] ==
                  display[i + (widget.tablesize * 3)] &&
              display[i + (widget.tablesize * 3)] ==
                  display[i + (widget.tablesize * 4)] &&
              display[i + (widget.tablesize * 4)] ==
                  display[i + (widget.tablesize * 5)]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 5) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize + 1] &&
              display[i + widget.tablesize + 1] ==
                  display[(widget.tablesize + 1) * 2] &&
              display[(widget.tablesize + 1) * 2] ==
                  display[(widget.tablesize + 1) * 3] &&
              display[(widget.tablesize + 1) * 3] ==
                  display[(widget.tablesize + 1) * 4] &&
              display[(widget.tablesize + 1) * 4] ==
                  display[(widget.tablesize + 1) * 5]) {
            _showWinDialog(display[i]); ////แนวทะแยง
          } else if (display[i] != '' &&
              display[i] == display[i + widget.tablesize - 1] &&
              display[i + widget.tablesize - 1] ==
                  display[i + (widget.tablesize - 1) * 2] &&
              display[i + (widget.tablesize - 1) * 2] ==
                  display[i + (widget.tablesize - 1) * 3] &&
              display[i + (widget.tablesize - 1) * 3] ==
                  display[i + (widget.tablesize - 1) * 4] &&
              display[i + (widget.tablesize - 1) * 4] ==
                  display[i + (widget.tablesize - 1) * 5]) {
            _showWinDialog(display[i]);
          }
        }
      }
      ////////// 7*7
      if (this.widget.tablesize == 7) {
        if (i == 0 ||
            i == 7 ||
            i == 14 ||
            i == 21 ||
            i == 28 ||
            i == 35 ||
            i == 42) {
          if (display[i] != '' &&
              display[i] == display[i + 1] &&
              display[i + 1] == display[i + 2] &&
              display[i + 2] == display[i + 3] && ////////แนวตั้ง
              display[i + 3] == display[i + 4] &&
              display[i + 4] == display[i + 5] &&
              display[i + 5] == display[i + 6]) {
            _showWinDialog(display[i]);
          }
        }

        if (i == 0 ||
            i == 1 ||
            i == 2 ||
            i == 3 ||
            i == 4 ||
            i == 5 ||
            i == 6) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize] &&
              display[i + widget.tablesize] ==
                  display[i + (widget.tablesize * 2)] && /////แนวนอน
              display[i + (widget.tablesize * 2)] ==
                  display[i + (widget.tablesize * 3)] &&
              display[i + (widget.tablesize * 3)] ==
                  display[i + (widget.tablesize * 4)] &&
              display[i + (widget.tablesize * 4)] ==
                  display[i + (widget.tablesize * 5)] &&
              display[i + (widget.tablesize * 5)] ==
                  display[i + (widget.tablesize * 6)]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 6) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize + 1] &&
              display[i + widget.tablesize + 1] ==
                  display[(widget.tablesize + 1) * 2] &&
              display[(widget.tablesize + 1) * 2] ==
                  display[(widget.tablesize + 1) * 3] &&
              display[(widget.tablesize + 1) * 3] ==
                  display[(widget.tablesize + 1) * 4] &&
              display[(widget.tablesize + 1) * 4] ==
                  display[(widget.tablesize + 1) * 5] &&
              display[(widget.tablesize + 1) * 5] ==
                  display[(widget.tablesize + 1) * 6]) {
            _showWinDialog(display[i]); ////แนวทะแยง
          } else if (display[i] != '' &&
              display[i] == display[i + widget.tablesize - 1] &&
              display[i + widget.tablesize - 1] ==
                  display[i + (widget.tablesize - 1) * 2] &&
              display[i + (widget.tablesize - 1) * 2] ==
                  display[i + (widget.tablesize - 1) * 3] &&
              display[i + (widget.tablesize - 1) * 3] ==
                  display[i + (widget.tablesize - 1) * 4] &&
              display[i + (widget.tablesize - 1) * 4] ==
                  display[i + (widget.tablesize - 1) * 5] &&
              display[i + (widget.tablesize - 1) * 5] ==
                  display[i + (widget.tablesize - 1) * 6]) {
            _showWinDialog(display[i]);
          }
        }
      }
      //////8*8
      if (this.widget.tablesize == 8) {
        if (i == 0 ||
            i == 9 ||
            i == 17 ||
            i == 25 ||
            i == 33 ||
            i == 41 ||
            i == 49 ||
            i == 57) {
          if (display[i] != '' &&
              display[i] == display[i + 1] &&
              display[i + 1] == display[i + 2] &&
              display[i + 2] == display[i + 3] && ////////แนวตั้ง
              display[i + 3] == display[i + 4] &&
              display[i + 4] == display[i + 5] &&
              display[i + 5] == display[i + 6] &&
              display[i + 6] == display[i + 7]) {
            _showWinDialog(display[i]);
          }
        }

        if (i == 0 ||
            i == 1 ||
            i == 2 ||
            i == 3 ||
            i == 4 ||
            i == 5 ||
            i == 6 ||
            i == 7) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize] &&
              display[i + widget.tablesize] ==
                  display[i + (widget.tablesize * 2)] && /////แนวนอน
              display[i + (widget.tablesize * 2)] ==
                  display[i + (widget.tablesize * 3)] &&
              display[i + (widget.tablesize * 3)] ==
                  display[i + (widget.tablesize * 4)] &&
              display[i + (widget.tablesize * 4)] ==
                  display[i + (widget.tablesize * 5)] &&
              display[i + (widget.tablesize * 5)] ==
                  display[i + (widget.tablesize * 6)] &&
              display[i + (widget.tablesize * 6)] ==
                  display[i + (widget.tablesize * 7)]) {
            _showWinDialog(display[i]);
          }
        }
        if (i == 0 || i == 7) {
          if (display[i] != '' &&
              display[i] == display[i + widget.tablesize + 1] &&
              display[i + widget.tablesize + 1] ==
                  display[(widget.tablesize + 1) * 2] &&
              display[(widget.tablesize + 1) * 2] ==
                  display[(widget.tablesize + 1) * 3] &&
              display[(widget.tablesize + 1) * 3] ==
                  display[(widget.tablesize + 1) * 4] &&
              display[(widget.tablesize + 1) * 4] ==
                  display[(widget.tablesize + 1) * 5] &&
              display[(widget.tablesize + 1) * 5] ==
                  display[(widget.tablesize + 1) * 6] &&
              display[(widget.tablesize + 1) * 6] ==
                  display[(widget.tablesize + 1) * 7]) {
            _showWinDialog(display[i]); ////แนวทะแยง
          } else if (display[i] != '' &&
              display[i] == display[i + widget.tablesize - 1] &&
              display[i + widget.tablesize - 1] ==
                  display[i + (widget.tablesize - 1) * 2] &&
              display[i + (widget.tablesize - 1) * 2] ==
                  display[i + (widget.tablesize - 1) * 3] &&
              display[i + (widget.tablesize - 1) * 3] ==
                  display[i + (widget.tablesize - 1) * 4] &&
              display[i + (widget.tablesize - 1) * 4] ==
                  display[i + (widget.tablesize - 1) * 5] &&
              display[i + (widget.tablesize - 1) * 5] ==
                  display[i + (widget.tablesize - 1) * 6] &&
              display[i + (widget.tablesize - 1) * 6] ==
                  display[i + (widget.tablesize - 1) * 7]) {
            _showWinDialog(display[i]);
          }
        }
      }
    } /////////////loop
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
            title: Center(
                child: Text(
              'DRAW',
              style: omyFont.copyWith(color: Colors.black),
            )),
            actions: [
              FlatButton(
                child: Text(
                  'Play Again!',
                  style: omyFont.copyWith(color: Colors.blue, fontSize: 10),
                ),
                onPressed: () {
                  DBService service = new DBService();
                  HistoryModel history = new HistoryModel();
                  history.list = tie.toString();
                  history.result = tie.toString();
                  var data = history.historyMap();
                  service.insertData(data);
                  // print("message" + this.tie);
                  // print("winner is" + tie.toString());
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
            title: Center(
                child: Text(
              'WINNER!   ' + winner,
              style: omyFont.copyWith(color: Colors.black),
            )),
            actions: [
              FlatButton(
                child: Text(
                  'Play Again!',
                  style: omyFont.copyWith(color: Colors.blue, fontSize: 10),
                ),
                onPressed: () {
                  DBService service = new DBService();
                  HistoryModel history = new HistoryModel();
                  history.list = this.win;
                  history.result = winner.toString();
                  var data = history.historyMap();
                  service.insertData(data);
                  // print("message" + this.win);
                  // print("winner is" + winner.toString());
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
