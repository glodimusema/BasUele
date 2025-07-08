import 'dart:async';
import 'dart:io';
import 'package:mob_enregistrement_manage/Design/EditCompany.dart';
import 'package:mob_enregistrement_manage/Design/Frm_Company.dart';
import 'package:mob_enregistrement_manage/Model/cls_company.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_colors.dart';
import 'package:flutter/material.dart';

Future<List<Company>> uploadCompanyToDB(BuildContext ctx) async {
  var as1 = Company();
  Future<List<Company>> companies = as1.UploadCompanies(ctx);
  return companies;
}
class UploadTask extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new UploadTaskState();
}

class UploadTaskState extends State<UploadTask> {
  
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: MyColors.backgroundColor,
        title: CircularProgressIndicator(color: MyColors.primaryColor,),
        elevation: 0,
      ),
      body: new Container(
        padding: EdgeInsets.all(0.0),
        child: FutureBuilder<List<Company>>(
          future: uploadCompanyToDB(context),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                if (snapshot.data?.length == 0) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Aucune Entreprise à synchroniser',
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
                                            '${snapshot.data?[index].colNom_Ese}',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                        //   style: TextStyle(color: Colors.grey[500]),
                                        // ),
                                        Text(
                                          'IdNat : ${snapshot.data?[index].colIdNat_Ese}',
                                          style: TextStyle(color: Colors.red),
                                        ),
                                        Text(
                                          'RCCM : ${snapshot.data?[index].colRCCM_Ese}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Forme Juridique :\n ${snapshot.data?[index].colFormeJuridique_Ese}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Genre d\'activités :\n ${snapshot.data?[index].colGenreActivite_Ese}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Raison Sociale:\n ${snapshot.data?[index].colRaisonSociale_Ese}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Quartier : ${snapshot.data?[index].colQuartier_Ese} (${snapshot.data?[index].colRefCodeQuartier})',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Adresse : ${snapshot.data?[index].colAdresseEntreprise_Ese}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Proprietaire : ${snapshot.data?[index].colProprietaire_Ese} \n(${snapshot.data?[index].colDateSave_Ese}) (${snapshot.data?[index].colCreatedBy_Ese})',
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
                                    
                                  },
                                  child: Icon(
                                    Icons.sync_sharp,
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
                    'Aucune Entreprise à synchroniser',
                    style: TextStyle(color: MyColors.primaryColor));
              }
            }

//show loading while snapshot is not getting data
            return new Container(
              alignment: AlignmentDirectional.center,
              child: ListTile(leading: CircularProgressIndicator(color: MyColors.primaryColor),title: Text("Synchronisation encours..."),)
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
