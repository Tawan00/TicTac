import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:tictactoe/database/db_service.dart';
import 'package:tictactoe/model/history_Model.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cupertino_icons/cupertino_icons.dart';

class historyPlay extends StatefulWidget {
  @override
  _historyPlayState createState() => _historyPlayState();
}

class _historyPlayState extends State<historyPlay> {
  @override
  void initState() {
    super.initState();
    getAllData();
  }

  List<HistoryModel> historyList = List<HistoryModel>();
  static var FontWhite = GoogleFonts.pressStart2P(
      textStyle:
          TextStyle(color: Colors.black, letterSpacing: 3, fontSize: 12));
  getAllData() async {
    historyList = List<HistoryModel>();
    var service = DBService();
    var historys = await service.readData();
    historys.forEach((his) {
      setState(() {
        var hisModel = HistoryModel();
        hisModel.id = his['id'];
        hisModel.list = his['list'];
        hisModel.result = his['result'];
        historyList.add(hisModel);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal[50],
      appBar: AppBar(
        backgroundColor: Colors.teal[50],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'HISTORY PLAY',
          style: FontWhite.copyWith(color: Colors.black),
        ),
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
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 45),
        child: ListView.builder(
            itemCount: historyList.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return Card(
                color: Colors.cyanAccent[100],
                child: ListTile(
                  leading: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "MATCH " + historyList[index].id.toString(),
                        style: FontWhite,
                      ),
                    ],
                  ),
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        historyList[index].list,
                        style: FontWhite.copyWith(color: Colors.green),
                      ),
                    ],
                  ),
                  subtitle: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        historyList[index].result,
                        style: FontWhite.copyWith(
                            color: Colors.orange, fontSize: 13),
                      ),
                    ],
                  ),
                ),
              );
            }),
      ),
      floatingActionButton: SizedBox.fromSize(
        size: Size.square(80),
        child: FloatingActionButton(
          onPressed: () async {
            var service = DBService();
            var result = await service.deleteData(historyList);
            getAllData();
            setState(() {});
            // Navigator.push(context,
            //     MaterialPageRoute(builder: (context) => historyPlay()));
            Navigator.pop(context);
          },
          child: Icon(
            CupertinoIcons.trash,
            size: 40.0,
            color: Colors.white,
          ),
          backgroundColor: Colors.redAccent,
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
}
