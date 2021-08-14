import 'package:flutter/material.dart';
import 'package:tictactoe/database/db_service.dart';
import 'package:tictactoe/model/history_Model.dart';
import 'package:google_fonts/google_fonts.dart';

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
      backgroundColor: Colors.grey[900],
      appBar: AppBar(
        backgroundColor: Colors.grey[900],
        elevation: 0,
        centerTitle: true,
        title: Text(
          'HISTORY PLAY',
          style: FontWhite.copyWith(color: Colors.white),
        ),
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
      body: Padding(
        padding:
            const EdgeInsets.only(top: 10, left: 20, right: 20, bottom: 10),
        child: ListView.builder(
            itemCount: historyList.length,
            itemBuilder: (BuildContext buildContext, int index) {
              return Card(
                child: ListTile(
                  leading: Text(
                    historyList[index].id.toString(),
                    style: FontWhite,
                  ),
                  title: Text(
                    historyList[index].list,
                    style: FontWhite,
                  ),
                  subtitle: Text(
                    historyList[index].result,
                    style: FontWhite.copyWith(color: Colors.orange),
                  ),
                ),
              );
            }),
      ),
    );
  }
}
