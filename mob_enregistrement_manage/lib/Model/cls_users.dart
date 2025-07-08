import 'package:mob_enregistrement_manage/Design/Frm_Users.dart';
import 'package:mob_enregistrement_manage/Design/company_List.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_glossaire.dart';
import 'package:mob_enregistrement_manage/MyClasses/pub_con.dart';
import 'package:flutter/material.dart';
import 'package:mob_enregistrement_manage/Database/DBHelper.dart';
import 'package:sqflite/sqflite.dart';

class Users {
  int? colId_user;
  String? colFullname;
  String? colUsername;
  String? colPassword;
  String? colFonction;
  String? colAxe;
  String? colTelephone;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '${DBHelper.colFullName}': colFullname,
      '${DBHelper.colUsername}': colUsername,
      '${DBHelper.colPassword}': colPassword,
      '${DBHelper.colFonction}': colFonction,
      '${DBHelper.colAxe}': colAxe,
      '${DBHelper.colTelephone}': colTelephone,
    };
  }

  //CRUD FUNCTIONS
  static Future<List<Users>> CheckUser(String username1, String password1,
      GlobalKey<ScaffoldState> scaffoldKey, BuildContext ctx) async {
    List<Users> company = [];
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      List<Map> list = await db_connection.rawQuery(
          'SELECT * FROM ${DBHelper.usersTable} WHERE ${DBHelper.colUsername}=\'${username1}\' AND ${DBHelper.colPassword}=\'${password1}\' ');
      company = List<Users>.empty(growable: true);
      for (int i = 0; i < list.length; i++) {
        Users p = new Users();
        p.colUsername = list[i]['${DBHelper.colUsername}'];
        PubCon.nomAuthor = list[i]['${DBHelper.colUsername}'];
        PubCon.phoneUser = list[i]['${DBHelper.colTelephone}'];
        PubCon.axeUser = list[i]['${DBHelper.colAxe}'];
        company.add(p);
      }
      if (list.length > 0) {
        //Login success=====Redirect Company List
        Navigator.pushReplacement(
          ctx,
          MaterialPageRoute(
            builder: (context) => CompanyLists(),
          ),
        );
      } else if (username1 == "TAXE2025" && password1 == "12345678") {
        Navigator.push(
          ctx,
          MaterialPageRoute(
            builder: (context) => UserFrm(),
          ),
        );
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
              content: Text(
            "Echec de connexion!....",
            style: TextStyle(color: Colors.red),
          )),
        );
      }
    } catch (e) {}
    return company;
  }

  void addNewUser(Users u, BuildContext ctx) async {
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      // String query =
      //     'INSERT INTO ${DBHelper.usersTable}(${DBHelper.colFullName},${DBHelper.colUsername},${DBHelper.colPassword}) VALUES(\'${u.colFullname}\',\'${u.colUsername}\',\'${u.colPassword}\')';
      // await db_connection.transaction((transaction) async {
      //   return await transaction.rawInsert(query);
      // });
      await db_connection.transaction((transaction) async {
        return await transaction.insert('${DBHelper.usersTable}', u.toMap(),
            conflictAlgorithm: ConflictAlgorithm.ignore);
        //return await transaction.rawInsert(query);
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
          'Enregistrement reussi!....',
          style: TextStyle(color: Color.fromARGB(255, 7, 80, 31)),
        )),
      );
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
          'Erreur d\'insertion!....\n{\$e}',
          style: TextStyle(color: Colors.red),
        )),
      );
    }
  }
}
