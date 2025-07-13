import 'dart:async';
import 'package:mob_enregistrement_manage/Model/cls_company.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_colors.dart';
import 'package:flutter/material.dart';

Future<List<Company>> getCompanyUploaded() async {
  var as1 = Company();
  Future<List<Company>> companies = as1.getCompaniesUploaded();
  return companies;
}

class UploadedCompanies extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new UploadedCompaniesState();
}

class UploadedCompaniesState extends State<UploadedCompanies> {
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
  final cDetails = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        backgroundColor: MyColors.backgroundColor,
        title: Text('Les Contribuables synchronisés'),
      ),
      body: new Container(
        padding: EdgeInsets.all(0.0),
        child: FutureBuilder<List<Company>>(
          future: getCompanyUploaded(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                if (snapshot.data?.length == 0) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Aucun Contribuable trouvé!',
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
                                                fontWeight: FontWeight.bold),
                                          ),
                                        ),
                                        // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                        //   style: TextStyle(color: Colors.grey[500]),
                                        // ),
                                        Text(
                                          'Code : ${snapshot.data?[index].colCode_Ese}',
                                          style: TextStyle(color: Colors.red),
                                        ),

                                        Text(
                                          'Quartier : ${snapshot.data?[index].colQuartier_Ese}',
                                          style: TextStyle(color: Colors.black),
                                        ),
                                        Text(
                                          'Proprietaire : ${snapshot.data?[index].colProprietaire_Ese} \n(${snapshot.data?[index].colDateSave_Ese}) (${snapshot.data?[index].colCreatedBy_Ese})  (${snapshot.data?[index].colDetails})',
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
                                  onTap: () {},
                                  child: Icon(
                                    Icons.check_circle,
                                    color: Color.fromARGB(255, 9, 67, 45),
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
                return Text('Aucun Contribuable trouvé!',
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
    );
  }

  @override
  void initState() {
    super.initState();
  }
}
