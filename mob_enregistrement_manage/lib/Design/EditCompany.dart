import 'package:mob_enregistrement_manage/Design/company_List.dart';
import 'package:mob_enregistrement_manage/Design/select_Category.dart';
import 'package:mob_enregistrement_manage/Design/select_Quartier.dart';
import 'package:mob_enregistrement_manage/Model/cls_company.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_colors.dart';
import 'package:mob_enregistrement_manage/MyClasses/pub_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class EditCompanyFrm extends StatefulWidget {
  final Company? snapshot;

  const EditCompanyFrm({Key? key, required this.snapshot}) : super(key: key);
  @override
  _EditCompanyFrmState createState() => _EditCompanyFrmState();
}

class _EditCompanyFrmState extends State<EditCompanyFrm> {
  Company company = new Company();
  TextEditingController cIdNat = TextEditingController(),
      cRCCM = TextEditingController(),
      cCode = TextEditingController(),
      cCompanyName = TextEditingController(),
      cRaisonSoc = TextEditingController(),
      cFormeJuridique = TextEditingController(),
      cGenreActivite = TextEditingController(),
      cQuartier = TextEditingController(),
      cAdresse = TextEditingController(),
      cProprietaire = TextEditingController(),
      cPhone1 = TextEditingController(),
      cPhone2 = TextEditingController(),
      cMail = TextEditingController(),
      cDetail = TextEditingController();

//cDetail
  //final TextEditingController _typeAheadController = TextEditingController();
  int? Id_Ese;
  String? IdNat = "-",
      RCCM,
      Code,
      CompanyName,
      RaisonSoc = "-",
      FormeJuridique = "-",
      GenreActivite,
      Quartier,
      Adresse,
      Proprietaire,
      phone1,
      phone2,
      mail,
      detail;

  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  //fill entries
  void fillEntries() {
    try {
      Id_Ese = widget.snapshot?.colId_Ese;
      cIdNat.text = '${widget.snapshot?.colIdNat_Ese}';
      cCode.text = '${widget.snapshot?.colCode_Ese}';
      cRCCM.text = '${widget.snapshot?.colRCCM_Ese}';
      cCompanyName.text = '${widget.snapshot?.colNom_Ese}';
      cRaisonSoc.text = '${widget.snapshot?.colRaisonSociale_Ese}';
      cFormeJuridique.text = '${widget.snapshot?.colFormeJuridique_Ese}';
      cGenreActivite.text = '${widget.snapshot?.colGenreActivite_Ese}';
      cQuartier.text = '${widget.snapshot?.colQuartier_Ese}';
      cAdresse.text = '${widget.snapshot?.colAdresseEntreprise_Ese}';
      cProprietaire.text = '${widget.snapshot?.colProprietaire_Ese}';
      cPhone1.text = '${widget.snapshot?.colEntreprisePhone1}';
      cPhone2.text = '${widget.snapshot?.colEntreprisePhone2}';
      cMail.text = '${widget.snapshot?.colEntrepriseMail}';
      cDetail.text = '${widget.snapshot?.colDetails}';
      PubCon.nomAuthor = '${widget.snapshot?.colCreatedBy_Ese}';
      PubCon.codequartier = '${widget.snapshot?.colRefCodeQuartier}';
      PubCon.refCategorie = int.parse('${widget.snapshot?.colRefCategorie}');
    } catch (e) {
      print(e);
    }
  }

  //colDetails
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    setState(() {
      fillEntries();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Modification Contribuable",
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: MyColors.backgroundColor,
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.view_list),
            tooltip: 'View List',
            onPressed: () {
              Navigator.pushReplacement(
                  context, MaterialPageRoute(builder: (ctx) => CompanyLists()));
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
                  submitAs();
                },
                child: Row(
                  children: <Widget>[
                    Expanded(
                      flex: 2,
                      child: Text(
                        'Modifier',
                        style: TextStyle(
                            color: MyColors.backgroundColor,
                            fontWeight: FontWeight.normal,
                            fontSize: MediaQuery.of(context).size.height / 25),
                        textAlign: TextAlign.center,
                      ),
                    ),
                    Expanded(
                        child: Icon(
                      Icons.save,
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
      body: ListView(
        children: <Widget>[
          Container(
            color: MyColors.backgroundColor,
            child: Align(
              alignment: Alignment.topCenter,
              child: Form(
                key: formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    SizedBox(
                      height: 16.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                        trailing: InkWell(
                            onTap: (() async {
                              // Code = await scanner.scan();
                              // cCode.text=Code.toString();
                              try {
                                await Permission.camera.request();
                                final qrCode = await scanner.scan();
                                setState(() {
                                  this.Code = qrCode;
                                  cCode.text = Code.toString();
                                });
                              } catch (e) {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                      content: Text(
                                    "Erreur de scan",
                                    style: TextStyle(color: Colors.red),
                                  )),
                                );
                              }
                            }),
                            child: Icon(Icons.qr_code,
                                color: MyColors.primaryColor)),
                        title: TextFormField(
                          controller: cCode,
                          cursorColor: Colors.black,
                          cursorWidth: 4,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Code du Contribuable',
                              labelStyle: TextStyle(
                                  color: Color(0xff49A2B6), fontSize: 20),
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder()),
                          validator: (val) => val?.length == 0
                              ? "Tapez ou scanner le code"
                              : null,
                          onSaved: (val) => this.Code = val,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cRCCM,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: "Entrer le numero Permis",
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) =>
                            val?.length == 0 ? "Entrer le numero Permis" : null,
                        onSaved: (val) => this.RCCM = val,
                      ),
                    ),
                    // Padding(
                    //   padding: const EdgeInsets.all(8.0),
                    //   child: TextFormField(
                    //     controller: cCompanyName,
                    //     cursorColor: Colors.black,
                    //     cursorWidth: 4,
                    //     style: TextStyle(color: Colors.black, fontSize: 18),
                    //     decoration: InputDecoration(
                    //         labelText: 'Nom de l\'entreprise',
                    //         labelStyle: TextStyle(
                    //             color: Color(0xff49A2B6), fontSize: 20),
                    //         border: new OutlineInputBorder(),
                    //         focusedBorder: new OutlineInputBorder()),
                    //     validator: (val) => val?.length == 0
                    //         ? "Entrer le nom de l'entreprise"
                    //         : null,
                    //     onSaved: (val) => this.CompanyName = val,
                    //   ),
                    // ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                        trailing: InkWell(
                            onTap: (() {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryList(),
                                ),
                              ).then((value) {
                                setState(() {
                                  cGenreActivite.text = PubCon.nomCategorie;
                                });
                              });
                            }),
                            child: Icon(Icons.remove_red_eye,
                                color: MyColors.primaryColor)),
                        title: TextFormField(
                          enabled: false,
                          minLines: 2,
                          maxLines: 4,
                          controller: cGenreActivite,
                          cursorColor: Colors.black,
                          cursorWidth: 4,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Categorie',
                              labelStyle: TextStyle(
                                  color: Color(0xff49A2B6), fontSize: 20),
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder()),
                          validator: (val) => val?.length == 0
                              ? "Selectionnez la categorie"
                              : null,
                          onSaved: (val) => this.GenreActivite = val,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ListTile(
                        contentPadding: const EdgeInsets.all(0.0),
                        trailing: InkWell(
                          child: Icon(
                            Icons.remove_red_eye,
                            color: MyColors.primaryColor,
                          ),
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => QuartiersLists(),
                              ),
                            ).then((value) {
                              setState(() {
                                cQuartier.text = PubCon.NomQuartier;
                              });
                            });
                          }),
                        ),
                        title: TextFormField(
                          enabled: false,
                          controller: cQuartier,
                          cursorColor: Colors.black,
                          cursorWidth: 4,
                          style: TextStyle(color: Colors.black, fontSize: 18),
                          decoration: InputDecoration(
                              labelText: 'Site',
                              labelStyle: TextStyle(
                                  color: Color(0xff49A2B6), fontSize: 20),
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder()),
                          validator: (val) =>
                              val?.length == 0 ? "Selectionnez le Site" : null,
                          onSaved: (val) => this.Quartier = val,
                        ),
                      ),
                    ),

//========================================================================================

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cProprietaire,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Contribuable(Client)',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) => val?.length == 0
                            ? "Entrer le nom du Contribuable(Client)"
                            : null,
                        onSaved: (val) => this.Proprietaire = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cAdresse,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Adresse',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) =>
                            val?.length == 0 ? "Entrer l'adresse" : null,
                        onSaved: (val) => this.Adresse = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cPhone1,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Numéro de téléphone1',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) => val?.length == 0
                            ? "Entrer le numéro de téléphone1"
                            : null,
                        onSaved: (val) => this.phone1 = val,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cPhone2,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Numéro de téléphone2 (facultatif)',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        onSaved: (val) => this.phone2 = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cMail,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Adresse mail (facultatif)',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        onSaved: (val) => this.mail = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: cDetail,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Autres détails',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        onSaved: (val) => this.detail = val,
                      ),
                    ),
                    Divider(
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void submitAs() {
    if (this.formKey.currentState!.validate()) {
      formKey.currentState!.save();
    } else {
      return null;
    }
    var p = Company();
    p.colId_Ese = Id_Ese;
    p.colCode_Ese = Code;
    p.colIdNat_Ese = IdNat;
    p.colRCCM_Ese = RCCM;
    p.colNom_Ese = CompanyName;
    p.colRaisonSociale_Ese = RaisonSoc;
    p.colFormeJuridique_Ese = FormeJuridique;
    p.colGenreActivite_Ese = GenreActivite;
    p.colQuartier_Ese = Quartier;
    p.colAdresseEntreprise_Ese = Adresse;
    p.colProprietaire_Ese = Proprietaire;
    p.colEntreprisePhone1 = phone1;
    p.colEntreprisePhone2 = phone2;
    p.colEntrepriseMail = mail;
    p.colDetails = detail;
    p.colCreatedBy_Ese = PubCon.nomAuthor;
    p.colRefCategorie = PubCon.refCategorie;
    p.colRefCodeQuartier = PubCon.codequartier;
    p.updateCompany(p, context);
    innit();
  }

  void innit() {
    IdNat = "-";
    RCCM = "";
    Code = "";
    CompanyName = "";
    RaisonSoc = "-";
    FormeJuridique = "-";
    GenreActivite = "";
    Quartier = "";
    Adresse = "";
    Proprietaire = "";
    phone1 = "";
    phone2 = "";
    mail = "";
    detail = "";
    //PubCon.NomQuartier = "";
    // PubCon.NomQuartier = "";
    // PubCon.nomCategorie="";
    // PubCon.codequartier="-1";
    // PubCon.refCategorie=-1;

    setState(() {
      cIdNat.text = "";
      cCode.text = "";
      cRCCM.text = "";
      cCompanyName.text = "";
      cRaisonSoc.text = "";
      cFormeJuridique.text = "";
      cGenreActivite.text = "";
      cQuartier.text = "";
      cAdresse.text = "";
      cProprietaire.text = "";
      cPhone1.text = "";
      cPhone2.text = "";
      cMail.text = "";
      cDetail.text = "";
    });
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}
