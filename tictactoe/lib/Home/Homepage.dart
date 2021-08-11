import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool ohTurn = true;
  List<String> display = ['', '', '', '', '', '', '', '', ''];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[800],
      body: GridView.builder(
        itemCount: 9,
        gridDelegate:
            SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return GestureDetector(
            onTap: () {
              _tapped(index);
            },
            child: Container(
              decoration: BoxDecoration(
                border: Border.all(color: Colors.grey[700]),
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
    );
  }

  void _tapped(int index) {
    setState(() {
      if (ohTurn && display[index] == '') {
        display[index] = 'o';
      } else if (!ohTurn && display[index] == '') {
        display[index] = 'x';
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
    }
  }

  void _showWinDialog(String winner) {
    showDialog(
        context: context,
        builder: (BuildContext) {
          return AlertDialog(
            title: Text('WINNER IS  ' + winner),
          );
        });
  }
}
