import 'dart:async';
import 'package:mob_enregistrement_manage/Model/cls_company.dart';
import 'package:mob_enregistrement_manage/Model/cls_quartiers.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_colors.dart';
import 'package:mob_enregistrement_manage/MyClasses/pub_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<List<Quartiers>> getQuartiersFormDB() async {
  var as1 = Quartiers();
  Future<List<Quartiers>> quartiers = as1.GetQuartiersFromDB();
  return quartiers;
}

class QuartiersLists extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new QuartiersListsState();
}

class QuartiersListsState extends State<QuartiersLists> {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: Text('List des Sites'),
      ),
      body: new Container(
        padding: EdgeInsets.all(0.0),
        child: FutureBuilder<List<Quartiers>>(
          future: getQuartiersFormDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                if (snapshot.data?.length == 0) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Aucun Site trouvé.\n',
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: MediaQuery.of(context).size.height / 25),
                      textAlign: TextAlign.center,
                    ),
                  );
                } else {
                  return ListView.builder(
                      itemCount: snapshot.data?.length,
                      itemBuilder: (context, index) {
                        return Card(
                          margin: EdgeInsets.all(4.0),
                          color: Colors.white,
                          elevation: 2.0,
                          child: new Row(
                            children: <Widget>[
                              Expanded(
                                flex: 2,
                                child: Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: GestureDetector(
                                    onTap: () {
                                      // Navigator.push(
                                      //           context,
                                      //           MaterialPageRoute(
                                      //               builder: (ctx) => MyTList(
                                      //                     nomProv:
                                      //                         '${snapshot.data[index].colPname}',
                                      //                     codeProv:
                                      //                         '${snapshot.data[index].colAdm1Pcode}',
                                      //                   )));
                                    },
                                    child: InkWell(
                                      onTap: () {
                                        PubCon.NomQuartier =
                                            '${snapshot.data?[index].colDesignation_quartier}';

                                        PubCon.codequartier =
                                            '${snapshot.data?[index].colId_quartier}';
                                        print(
                                            '===================>${PubCon.codequartier}');

                                        if (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        } else {
                                          SystemNavigator.pop();
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 8.0, top: 8.0),
                                            child: Text(
                                              'Sites : ${snapshot.data?[index].colDesignation_quartier}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                          //   style: TextStyle(color: Colors.grey[500]),
                                          // ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              new Divider(),
                            ],
                          ),
                        );
                      });
                }
              } else {
                return Text('Aucun Site trouvé.\n',
                    style: TextStyle(color: Colors.white));
              }
            }

//show loading while snapshot is not getting data
            return new Container(
              alignment: AlignmentDirectional.center,
              child: new CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
