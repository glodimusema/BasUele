import 'dart:async';
import 'dart:io';
import 'package:mob_enregistrement_manage/Design/EditCompany.dart';
import 'package:mob_enregistrement_manage/Design/Frm_Company.dart';
import 'package:mob_enregistrement_manage/Design/upload_task.dart';
import 'package:mob_enregistrement_manage/Design/uploaded_company_List.dart';
import 'package:mob_enregistrement_manage/Model/cls_company.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_colors.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_glossaire.dart';
import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';

Future<List<Company>> getCompanyFormDB() async {
  var as1 = Company();
  Future<List<Company>> companies = as1.getCompanies();
  return companies;
}

class CompanyLists extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CompanyListsState();
}

class CompanyListsState extends State<CompanyLists> {
  //create Controller for update name and phone
  final cIdNat = TextEditingController();
  final cRCCM = TextEditingController();
  final cCompanyName = TextEditingController();
  final cRaisonSoc = TextEditingController();
  final cFormeJuridique = TextEditingController();
  final cGenreActivite = TextEditingController();
  final cQuartier = TextEditingController();
  final cAdresse = TextEditingController();
  final cProprietaire = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: Text('Liste des Menages'),
        actions: [
          InkWell(
            child: Icon(Icons.logout),
            onTap: () {
              exit(0);
            },
          )
        ],
      ),

      bottomNavigationBar: Card(
        child: Padding(
          padding: const EdgeInsets.all(2.0),
          child: Container(
            height: 55,
            width: MediaQuery.of(context).size.width / 1.0,
            decoration: BoxDecoration(
                color: MyColors.primaryColor,
                borderRadius: BorderRadius.all(Radius.circular(16))),
            child: Center(
              child: GestureDetector(
                onTap: () {
                  //aller à Insertion
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (ctx) => CompanyFrm()));
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Nouveau Menage',
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.height / 50),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                        child: Icon(
                      Icons.playlist_add,
                      textDirection: TextDirection.ltr,
                      color: Colors.white,
                      size: 44.0,
                    ))
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
      body: new Container(
        padding: EdgeInsets.all(0.0),
        child: FutureBuilder<List<Company>>(
          future: getCompanyFormDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                if (snapshot.data?.length == 0) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Aucun enregistrement trouvé.\nMerci de créer un nouveau Menage!',
                      style: TextStyle(
                          color: MyColors.primaryColor,
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
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: <Widget>[
                                        Container(
                                          padding: const EdgeInsets.only(
                                              bottom: 8.0),
                                          child: Text(
                                            '${snapshot.data?[index].colProprietaire_Ese}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                fontSize: 16),
                                          ),
                                        ),
                                        // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                        //   style: TextStyle(color: Colors.grey[500]),
                                        // ),
                                        // Text(
                                        //   'IdNat : ${snapshot.data?[index].colIdNat_Ese}',
                                        //   style: TextStyle(color: Colors.red),
                                        // ),
                                        Text(
                                          'Code : ${snapshot.data?[index].colCode_Ese}',
                                          style: TextStyle(
                                              color: Color.fromARGB(
                                                  255, 27, 94, 20)),
                                        ),

                                        // Text(
                                        //   'Forme Juridique :\n ${snapshot.data?[index].colFormeJuridique_Ese}',
                                        //   style: TextStyle(color: Colors.black),
                                        // ),
                                        Text(
                                          'Categorie :\n ${snapshot.data?[index].colGenreActivite_Ese}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        // Text(
                                        //   'Raison Sociale:\n ${snapshot.data?[index].colRaisonSociale_Ese}',
                                        //   style: TextStyle(color: Colors.black),
                                        // ),
                                        Text(
                                          'Quartier : ${snapshot.data?[index].colQuartier_Ese}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Adresse : ${snapshot.data?[index].colAdresseEntreprise_Ese} \nContacts: ${snapshot.data?[index].colEntreprisePhone1},${snapshot.data?[index].colEntreprisePhone2},${snapshot.data?[index].colEntrepriseMail}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Responsable : ${snapshot.data?[index].colProprietaire_Ese} \n(${snapshot.data?[index].colDateSave_Ese}) (${snapshot.data?[index].colCreatedBy_Ese} , ${snapshot.data?[index].colDetails})',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),

                              //create update and delete button
                              Padding(
                                padding: const EdgeInsets.all(16.0),
                                child: InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => EditCompanyFrm(
                                          snapshot: snapshot.data?[index],
                                        ),
                                      ),
                                    ).then((value) {
                                      setState(() {});
                                    });
                                  },
                                  child: Icon(
                                    Icons.edit,
                                    color: Color(0xff416391),
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
                return Text(
                    'Aucun enregistrement trouvé.\nMerci de créer un nouveau Menage!',
                    style: TextStyle(color: MyColors.primaryColor));
              }
            }

//show loading while snapshot is not getting data
            return new Container(
              alignment: AlignmentDirectional.center,
              child: new CircularProgressIndicator(
                color: MyColors.primaryColor,
              ),
            );
          },
        ),
      ),
//button for synchro

      floatingActionButton: FloatingActionButton(
        backgroundColor: Color(0xff416391),
        onPressed: () async {
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => UploadTask(),
          //   ),
          // ).then((value) {
          //                             setState(() {});
          //                           });
        },
        tooltip: 'Synchronisation',
        //child: Icon(Icons.sync),
        child: _getFAB(context),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
  }

  int _counter = 0;
  Widget _getFAB(BuildContext ctx) {
    return SpeedDial(
      animatedIcon: AnimatedIcons.menu_home,
      animatedIconTheme: IconThemeData(size: 22),
      backgroundColor: Color(0xFF801E48),
      visible: true,
      curve: Curves.bounceIn,
      children: [
        // FAB 1
        SpeedDialChild(
            child: Icon(Icons.assignment_turned_in),
            backgroundColor: Color(0xFF801E48),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadedCompanies(),
                ),
              );
            },
            label: 'Voir les données synchronisées',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color(0xFF801E48)),
        // FAB 2
        SpeedDialChild(
            child: Icon(Icons.cloud_sync_outlined),
            backgroundColor: Color(0xFF801E48),
            onTap: () {
              setState(() {
                _counter = 0;
              });

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UploadTask(),
                ),
              ).then((value) {
                setState(() {});
              });
            },
            label: 'Synchroniser',
            labelStyle: TextStyle(
                fontWeight: FontWeight.w500,
                color: Colors.white,
                fontSize: 16.0),
            labelBackgroundColor: Color(0xFF801E48)),

        // FAB 3
        //     SpeedDialChild(
        //         child: Icon(Icons.download_rounded),
        //         backgroundColor: Color(0xFF801E48),
        //         onTap: () async {
        //           await Company.ExportExcelCompanies(ctx);
        //           setState(() {
        //             _counter = 1;
        //           });
        //           //          Navigator.push(
        //           //   context,
        //           //   MaterialPageRoute(
        //           //     builder: (context) => UploadTask(),
        //           //   ),
        //           // ).then((value) {
        //           //                             setState(() {});
        //           //                           });
        //         },
        //         label: 'Export to Excel',
        //         labelStyle: TextStyle(
        //             fontWeight: FontWeight.w500,
        //             color: Colors.white,
        //             fontSize: 16.0),
        //         labelBackgroundColor: Color(0xFF801E48))
      ],
    );
  }
}
