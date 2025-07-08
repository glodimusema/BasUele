import 'package:mob_enregistrement_manage/Database/DBHelper.dart';
import 'package:mob_enregistrement_manage/Model/cls_company.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_colors.dart';
import 'package:mob_enregistrement_manage/MyClasses/pub_con.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:async';

import 'package:flutter/services.dart';

class Glossaire {
  // static void showInSnackBar(
  //     GlobalKey<ScaffoldState> _scaffoldKey, BuildContext context, String msg,
  //     {Color clr = Colors.white}) {
  //   FocusScope.of(context).requestFocus(new FocusNode());
  //   _scaffoldKey.currentState?.removeCurrentSnackBar();
  //   _scaffoldKey.currentState?.showSnackBar(new SnackBar(
  //     content: new Text(
  //       msg,
  //       textAlign: TextAlign.center,
  //       style: TextStyle(
  //         color: clr,
  //         fontSize: 16.0,
  //         //fontFamily: "WorkSansSemiBold"
  //       ),
  //     ),
  //     backgroundColor: MyColors.primaryColor,
  //     duration: Duration(seconds: 3),
  //   ));
  //   //Navigator.of(context).pushReplacementNamed("/splash");
  // }

//insert data into online database
  static Future upload_companies(Company c, BuildContext ctx) async {
    try {
      //var uri = Uri.parse(PubCon.cheminApi + "insertSync_contribuable");
      var uri =
          Uri.https('ffn-tshopo-bas-uele.site', 'api/insertSync_contribuable');
      print(uri);
      var url =
          Uri.https('ffn-tshopo-bas-uele.site', 'api/insertSync_contribuable');
      var response = await http.post(url, body: {
        'colIdNat_Ese': '${c.colIdNat_Ese}',
        'colRCCM_Ese': '${c.colRCCM_Ese}',
        'colRaisonSociale_Ese': '${c.colRaisonSociale_Ese}',
        'colId_Ese': '${c.colCode_Ese}',
        'ColRefCat': '${c.colRefCategorie}',
        'ColRefQuartier': '${c.colRefCodeQuartier}',
        'colQuartier_Ese': '${c.colQuartier_Ese}',
        'colAdresseEntreprise_Ese': '${c.colAdresseEntreprise_Ese}',
        'colProprietaire_Ese': '${c.colProprietaire_Ese}',
        'entreprisePhone1': '${c.colEntreprisePhone1}',
        'entreprisePhone2': '${c.colEntreprisePhone2}',
        'entrepriseMail': '${c.colEntrepriseMail}',
        'Details': '${c.colDetails}',
        'colCreatedBy_Ese': '${PubCon.phoneUser}',
        'colDateSave_Ese': '${c.colDateSave_Ese}',
        'author': '${c.colCreatedBy_Ese}'
      });
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        //update status
        Company.updateCompanyStatus(c, ctx);
        // ScaffoldMessenger.of(ctx).showSnackBar(
        //   const SnackBar(content: Text('Uploaded...')),
        //);
      } else {
        String code = "${response.statusCode}";
        print("===============code=$code=======${response.headers}=====");

        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
              content: Text(
            "Echec d'envoi des données!....",
            style: TextStyle(color: Colors.red),
          )),
        );
      }
    } catch (e) {
      print(
          "===============================================\n====$e====\n==========================");
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            elevation: 2,
            //duration: Duration(seconds: 30),
            content: Text(
              'Erreur de connexion... \nAucune synchronisation effectuée!!!',
              style: TextStyle(color: Colors.red, fontSize: 16),
            )),
      );
      throw Exception();
    }
  }
}
