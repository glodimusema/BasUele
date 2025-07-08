
import 'package:mob_enregistrement_manage/Model/cls_users.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class UserFrm extends StatefulWidget {
  @override
  _UserFrmState createState() => _UserFrmState();
}

class _UserFrmState extends State<UserFrm> {
  Users company = new Users();
  TextEditingController colfullname = TextEditingController(),
      colusername = TextEditingController(),
      colpassword1 = TextEditingController(),
      colfonction = TextEditingController(),
      colaxe = TextEditingController(),
      coltelephone = TextEditingController();

  //final TextEditingController _typeAheadController = TextEditingController();

  String? fullname = "-",
      username,
      password1,
      fonction,
      axe = "-",
      telephone = "-";

  final formKey = new GlobalKey<FormState>();
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.backgroundColor,
      appBar: AppBar(
        iconTheme: IconThemeData(color: Colors.black),
        title: Text("Config User",
            style: TextStyle(
              color: Colors.black,
            )),
        backgroundColor: MyColors.backgroundColor,
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
                      child: TextFormField(
                        controller: colfullname,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: "Entrer le Nom complet",
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) =>
                            val?.length == 0 ? "Entrer le Nom complet" : null,
                        onSaved: (val) => this.fullname = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: colusername,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Username',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) =>
                            val?.length == 0 ? "Entrer le username" : null,
                        onSaved: (val) => this.username = val,
                      ),
                    ),

//========================================================================================

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: colpassword1,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Password',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) =>
                            val?.length == 0 ? "Entrer le password" : null,
                        onSaved: (val) => this.password1 = val,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        controller: colfonction,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Fonction',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) => val?.length == 0
                            ? "Entrer la fonction de l\'utilisateur"
                            : null,
                        onSaved: (val) => this.fonction = val,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.phone,
                        controller: coltelephone,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Numéro de téléphone1 de l\'utilisateur',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) => val?.length == 0
                            ? "Entrer le numéro de téléphone l'utilisateur"
                            : null,
                        onSaved: (val) => this.telephone = val,
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: TextFormField(
                        keyboardType: TextInputType.text,
                        controller: colaxe,
                        cursorColor: Colors.black,
                        cursorWidth: 4,
                        style: TextStyle(color: Colors.black, fontSize: 18),
                        decoration: InputDecoration(
                            labelText: 'Axe de l\'utilisateur',
                            labelStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            border: new OutlineInputBorder(),
                            focusedBorder: new OutlineInputBorder()),
                        validator: (val) => val?.length == 0
                            ? "Entrer l'axe de l'utilisateur"
                            : null,
                        onSaved: (val) => this.axe = val,
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
    var p = Users();
    p.colFullname = fullname;
    p.colUsername = username;
    p.colPassword = password1;
    p.colFonction = fonction;
    p.colAxe = axe;
    p.colTelephone = telephone;
    p.addNewUser(p, context);
    innit();
  }

  void innit() {
    fullname = "-";
    username = "";
    password1 = "";
    fonction = "";
    axe = "-";
    telephone = "-";
    setState(() {
      colfullname.text = "-";
      colusername.text = "";
      colpassword1.text = "";
      colaxe.text = "";
      colfonction.text = "-";
      coltelephone.text = "-";
    });
    if (Navigator.canPop(context)) {
      Navigator.pop(context);
    } else {
      SystemNavigator.pop();
    }
  }
}
