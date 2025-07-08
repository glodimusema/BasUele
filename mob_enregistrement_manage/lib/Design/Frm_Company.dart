import 'package:mob_enregistrement_manage/Design/company_List.dart';
import 'package:mob_enregistrement_manage/Design/select_Category.dart';
import 'package:mob_enregistrement_manage/Design/select_Quartier.dart';
import 'package:mob_enregistrement_manage/Model/cls_company.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_colors.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_glossaire.dart';
import 'package:mob_enregistrement_manage/MyClasses/pub_con.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class CompanyFrm extends StatefulWidget {
  @override
  _CompanyFrmState createState() => _CompanyFrmState();
}

class _CompanyFrmState extends State<CompanyFrm> {
  // List<String> inputs = [];
  // final TextEditingController _controller = TextEditingController();
  // void _addInput() {
  //   if (_controller.text.isNotEmpty) {
  //     setState(() {
  //       inputs.add(_controller.text);
  //       _controller.clear(); // Efface le champ de texte après l'ajout
  //     });
  //   }
  // }

  // String get inputsAsString =>
  //     inputs.join(', '); // Convertit la liste en chaîne

  Company company = new Company();
  TextEditingController cIdNat = TextEditingController(),
      cCode = TextEditingController(),
      cRCCM = TextEditingController(),
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

  //final TextEditingController _typeAheadController = TextEditingController();

  String? IdNat = "-",
      Code,
      RCCM,
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Menage",
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
                        'Enregistrer',
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
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        controller: cIdNat,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                          labelText: "Numéro d'Agrement",
                          labelStyle:
                              TextStyle(color: Color(0xff49A2B6), fontSize: 20),
                          focusedBorder: new OutlineInputBorder(),
                          border: new OutlineInputBorder(),
                        ),
                        validator: (val) => val?.length == 0
                            ? "Entrer le Numéro d'Agrement"
                            : null,
                        onSaved: (val) => this.IdNat = val,
                      ),
                    ),
                    SizedBox(
                      height: 16.0,
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
                      child: TextFormField(
                        controller: cRaisonSoc,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: "Site d'Exploitation",
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) => val?.length == 0
                            ? "Entrer le Site d'Exploitation"
                            : null,
                        onSaved: (val) => this.RaisonSoc = val,
                      ),
                    ),

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
                          child: Icon(Icons.remove_red_eye,
                              color: MyColors.primaryColor),
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
                              labelText: 'Quartier',
                              labelStyle: TextStyle(
                                  color: Color(0xff49A2B6), fontSize: 20),
                              border: new OutlineInputBorder(),
                              focusedBorder: new OutlineInputBorder()),
                          validator: (val) => val?.length == 0
                              ? "Selectionnez le Quartier"
                              : null,
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
                            labelText: 'Adresse Complete du Contribuable',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) => val?.length == 0
                            ? "Entrer l'adresse Complete du Contribuable"
                            : null,
                        onSaved: (val) => this.Adresse = val,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
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
                        keyboardType: TextInputType.phone,
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
                        keyboardType: TextInputType.emailAddress,
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
                    // Padding(
                    //   padding: const EdgeInsets.all(16.0),
                    //   child: Column(
                    //     children: [
                    //       TextField(
                    //         controller: _controller,
                    //         cursorColor: Colors.black,
                    //         cursorWidth: 4,
                    //         style: TextStyle(color: Colors.black, fontSize: 18),
                    //         decoration: InputDecoration(
                    //             labelText: 'Entrez le dependant',
                    //             labelStyle: TextStyle(
                    //                 color: Color(0xff49A2B6), fontSize: 20),
                    //             border: new OutlineInputBorder(),
                    //             focusedBorder: new OutlineInputBorder()),
                    //       ),
                    //       SizedBox(height: 5),
                    //       ElevatedButton(
                    //         onPressed: _addInput,
                    //         child: Text('Ajouter'),
                    //       ),
                    //       SizedBox(height: 10),
                    //       Expanded(
                    //         child: ListView.builder(
                    //           itemCount: inputs.length,
                    //           itemBuilder: (context, index) {
                    //             return ListTile(
                    //               title: Text(inputs[index]),
                    //             );
                    //           },
                    //         ),
                    //       ),
                    //       SizedBox(height: 20),
                    //       Text(
                    //         'Chaîne résultante : $inputsAsString',
                    //         style: TextStyle(
                    //             fontSize: 16, fontWeight: FontWeight.bold),
                    //       ),
                    //     ],
                    //   ),
                    // ),
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
                        maxLines: null,
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
    // this.detail = this.inputsAsString;

    var p = Company();
    p.colIdNat_Ese = IdNat;
    p.colCode_Ese = Code;
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
    p.addNewCompany(p, context);
    innit();
  }

  void innit() {
    IdNat = "-";
    Code = "";
    RCCM = "";
    CompanyName = "";
    RaisonSoc = "-";
    FormeJuridique = "-";
    GenreActivite = "";
    Quartier = "";
    Adresse = "";
    phone1 = "";
    phone2 = "";
    mail = "";
    detail = "";
    Proprietaire = "";
    PubCon.NomQuartier = "";
    PubCon.nomCategorie = "";
    PubCon.codequartier = "-1";
    PubCon.refCategorie = -1;
    setState(() {
      cIdNat.text = "-";
      cCode.text = "";
      cRCCM.text = "";
      cCompanyName.text = "";
      cRaisonSoc.text = "-";
      cFormeJuridique.text = "-";
      cGenreActivite.text = "";
      cQuartier.text = "";
      cAdresse.text = "";
      cProprietaire.text = "";
      cPhone1.text = "";
      cPhone2.text = "";
      cMail.text = "";
      cDetail.text = "";
    });
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (ctx) => CompanyLists()));
  }
}
