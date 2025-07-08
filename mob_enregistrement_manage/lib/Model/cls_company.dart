import 'dart:io';

import 'package:mob_enregistrement_manage/Design/uploaded_company_List.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_glossaire.dart';
import 'package:flutter/material.dart';
import 'package:mob_enregistrement_manage/Database/DBHelper.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';
import 'package:excel/excel.dart';
import 'package:path/path.dart';

class Company {
  int? colId_Ese, colRefCategorie;
  String? colIdNat_Ese;
  String? colCode_Ese;
  String? colRCCM_Ese;
  String? colNom_Ese;
  String? colRaisonSociale_Ese;
  String? colFormeJuridique_Ese;
  String? colGenreActivite_Ese;
  String? colQuartier_Ese;
  String? colRefCodeQuartier;
  String? colAdresseEntreprise_Ese;
  String? colProprietaire_Ese;
  String? colDateSave_Ese;
  String? colCreatedBy_Ese;
  String? colEntreprisePhone1;
  String? colEntreprisePhone2;
  String? colEntrepriseMail;
  String? colDetails;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '${DBHelper.colIdNat_Ese}': colIdNat_Ese,
      '${DBHelper.colCode_Ese}': colCode_Ese,
      '${DBHelper.colRCCM_Ese}': colRCCM_Ese,
      '${DBHelper.colNom_Ese}': colNom_Ese,
      '${DBHelper.colRaisonSociale_Ese}': colRaisonSociale_Ese,
      '${DBHelper.colFormeJuridique_Ese}': colFormeJuridique_Ese,
      '${DBHelper.colGenreActivite_Ese}': colGenreActivite_Ese,
      '${DBHelper.ColRefCat}': colRefCategorie,
      '${DBHelper.colQuartier_Ese}': colQuartier_Ese,
      '${DBHelper.ColRefcodeQuartier}': colRefCodeQuartier,
      '${DBHelper.colAdresseEntreprise_Ese}': colAdresseEntreprise_Ese,
      '${DBHelper.colProprietaire_Ese}': colProprietaire_Ese,
      '${DBHelper.colCreatedBy_Ese}': colCreatedBy_Ese,
      '${DBHelper.colEntreprisePhone1}': colEntreprisePhone1,
      '${DBHelper.colEntreprisePhone2}': colEntreprisePhone2,
      '${DBHelper.colEntrepriseMail}': colEntrepriseMail,
      '${DBHelper.colDetails}': colDetails
    };
  }

//colDetails
  //CRUD FUNCTIONS
  Future<List<Company>> getCompanies() async {
    List<Company> company = [];
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      List<Map> list = await db_connection.rawQuery(
          "SELECT * FROM ${DBHelper.entrepriseTable} WHERE ${DBHelper.colStatus}=0 ORDER BY ${DBHelper.colId_Ese} DESC");
      company = List<Company>.empty(growable: true);
      print("====================>>>>\n$company");
      for (int i = 0; i < list.length; i++) {
        Company p = new Company();
        p.colId_Ese = list[i]['${DBHelper.colId_Ese}'];
        p.colCode_Ese = list[i]['${DBHelper.colCode_Ese}'];
        p.colIdNat_Ese = list[i]['${DBHelper.colIdNat_Ese}'];
        p.colRCCM_Ese = list[i]['${DBHelper.colRCCM_Ese}'];
        p.colNom_Ese = list[i]['${DBHelper.colNom_Ese}'];
        p.colRaisonSociale_Ese = list[i]['${DBHelper.colRaisonSociale_Ese}'];
        p.colFormeJuridique_Ese = list[i]['${DBHelper.colFormeJuridique_Ese}'];
        p.colGenreActivite_Ese = list[i]['${DBHelper.colGenreActivite_Ese}'];
        p.colRefCategorie = list[i]['${DBHelper.ColRefCat}'];
        p.colQuartier_Ese = list[i]['${DBHelper.colQuartier_Ese}'];
        p.colRefCodeQuartier = list[i]['${DBHelper.ColRefcodeQuartier}'];
        p.colAdresseEntreprise_Ese =
            list[i]['${DBHelper.colAdresseEntreprise_Ese}'];
        p.colProprietaire_Ese = list[i]['${DBHelper.colProprietaire_Ese}'];
        p.colDateSave_Ese = list[i]['${DBHelper.colDateSave_Ese}'];
        p.colCreatedBy_Ese = list[i]['${DBHelper.colCreatedBy_Ese}'];
        p.colEntreprisePhone1 = list[i]['${DBHelper.colEntreprisePhone1}'];
        p.colEntreprisePhone2 = list[i]['${DBHelper.colEntreprisePhone2}'];
        p.colEntrepriseMail = list[i]['${DBHelper.colEntrepriseMail}'];
        p.colDetails = list[i]['${DBHelper.colDetails}'];
        company.add(p);
      }
    } catch (e) {}
    return company;
  }

//colDetails
//CRUD FUNCTIONS
  Future<List<Company>> UploadCompanies(BuildContext ctx) async {
    List<Company> company = [];
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      List<Map> list = await db_connection.rawQuery(
          "SELECT * FROM ${DBHelper.entrepriseTable} WHERE ${DBHelper.colStatus}=0 ORDER BY ${DBHelper.colId_Ese} DESC");
      company = List<Company>.empty(growable: true);
      for (int i = 0; i < list.length; i++) {
        Company p = new Company();
        p.colId_Ese = list[i]['${DBHelper.colId_Ese}'];
        p.colCode_Ese = list[i]['${DBHelper.colCode_Ese}'];
        p.colIdNat_Ese = list[i]['${DBHelper.colIdNat_Ese}'];
        p.colRCCM_Ese = list[i]['${DBHelper.colRCCM_Ese}'];
        p.colNom_Ese = list[i]['${DBHelper.colNom_Ese}'];
        p.colRaisonSociale_Ese = list[i]['${DBHelper.colRaisonSociale_Ese}'];
        p.colFormeJuridique_Ese = list[i]['${DBHelper.colFormeJuridique_Ese}'];
        p.colGenreActivite_Ese = list[i]['${DBHelper.colGenreActivite_Ese}'];
        p.colRefCategorie = list[i]['${DBHelper.ColRefCat}'];
        p.colQuartier_Ese = list[i]['${DBHelper.colQuartier_Ese}'];
        p.colRefCodeQuartier = list[i]['${DBHelper.ColRefcodeQuartier}'];
        p.colAdresseEntreprise_Ese =
            list[i]['${DBHelper.colAdresseEntreprise_Ese}'];
        p.colProprietaire_Ese = list[i]['${DBHelper.colProprietaire_Ese}'];
        p.colDateSave_Ese = list[i]['${DBHelper.colDateSave_Ese}'];
        p.colCreatedBy_Ese = list[i]['${DBHelper.colCreatedBy_Ese}'];
        p.colEntreprisePhone1 = list[i]['${DBHelper.colEntreprisePhone1}'];
        p.colEntreprisePhone2 = list[i]['${DBHelper.colEntreprisePhone2}'];
        p.colEntrepriseMail = list[i]['${DBHelper.colEntrepriseMail}'];
        p.colDetails = list[i]['${DBHelper.colDetails}'];
        //colDetails
        company.add(p);
        await Glossaire.upload_companies(p, ctx);
      }
      Navigator.pushReplacement(
        ctx,
        MaterialPageRoute(
          builder: (context) => UploadedCompanies(),
        ),
      );
    } catch (e) {
      Navigator.of(ctx).pop();
    }
    return company;
  }

  Future<List<Company>> getCompaniesUploaded() async {
    List<Company> company = [];
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      List<Map> list = await db_connection.rawQuery(
          "SELECT * FROM ${DBHelper.entrepriseTable} WHERE ${DBHelper.colStatus}=1 ORDER BY ${DBHelper.colId_Ese} DESC");
      company = List<Company>.empty(growable: true);
      for (int i = 0; i < list.length; i++) {
        Company p = new Company();
        p.colId_Ese = list[i]['${DBHelper.colId_Ese}'];
        p.colCode_Ese = list[i]['${DBHelper.colCode_Ese}'];
        p.colIdNat_Ese = list[i]['${DBHelper.colIdNat_Ese}'];
        p.colRCCM_Ese = list[i]['${DBHelper.colRCCM_Ese}'];
        p.colNom_Ese = list[i]['${DBHelper.colNom_Ese}'];
        p.colRaisonSociale_Ese = list[i]['${DBHelper.colRaisonSociale_Ese}'];
        p.colFormeJuridique_Ese = list[i]['${DBHelper.colFormeJuridique_Ese}'];
        p.colGenreActivite_Ese = list[i]['${DBHelper.colGenreActivite_Ese}'];
        p.colRefCategorie = list[i]['${DBHelper.ColRefCat}'];
        p.colQuartier_Ese = list[i]['${DBHelper.colQuartier_Ese}'];
        p.colRefCodeQuartier = list[i]['${DBHelper.ColRefcodeQuartier}'];
        p.colAdresseEntreprise_Ese =
            list[i]['${DBHelper.colAdresseEntreprise_Ese}'];
        p.colProprietaire_Ese = list[i]['${DBHelper.colProprietaire_Ese}'];
        p.colDateSave_Ese = list[i]['${DBHelper.colDateSave_Ese}'];
        p.colCreatedBy_Ese = list[i]['${DBHelper.colCreatedBy_Ese}'];
        p.colEntreprisePhone1 = list[i]['${DBHelper.colEntreprisePhone1}'];
        p.colEntreprisePhone2 = list[i]['${DBHelper.colEntreprisePhone2}'];
        p.colEntrepriseMail = list[i]['${DBHelper.colEntrepriseMail}'];
        p.colDetails = list[i]['${DBHelper.colDetails}'];
        //colDetails
        company.add(p);
      }
    } catch (e) {}
    return company;
  }

  void addNewCompany(Company c, BuildContext ctx) async {
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      // String query =
      //     'INSERT INTO ${DBHelper.entrepriseTable}(${DBHelper.colIdNat_Ese},${DBHelper.colRCCM_Ese},${DBHelper.colNom_Ese},${DBHelper.colRaisonSociale_Ese},${DBHelper.colFormeJuridique_Ese},${DBHelper.colGenreActivite_Ese},${DBHelper.ColRefCat},${DBHelper.colQuartier_Ese},${DBHelper.colAdresseEntreprise_Ese},${DBHelper.colProprietaire_Ese},${DBHelper.colCreatedBy_Ese}) VALUES(\'${c.colIdNat_Ese}\',\'${c.colRCCM_Ese}\',\'${c.colNom_Ese}\',\'${c.colRaisonSociale_Ese}\',\'${c.colFormeJuridique_Ese}\',\'${c.colGenreActivite_Ese}\',${PubCon.refCategorie},\'${c.colQuartier_Ese}\',\'${c.colAdresseEntreprise_Ese}\',\'${c.colProprietaire_Ese}\',\'${c.colCreatedBy_Ese}\')';
      // print(query);
      await db_connection.transaction((transaction) async {
        return await transaction.insert(
            '${DBHelper.entrepriseTable}', c.toMap(),
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
          'Erreur d\'enregistrement!....',
          style: TextStyle(color: Colors.red),
        )),
      );
      print(e);
    }
  }

  void updateCompany(Company c, BuildContext ctx) async {
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      // String query =
      //     'UPDATE ${DBHelper.entrepriseTable} SET ${DBHelper.colIdNat_Ese}=\'${c.colIdNat_Ese}\',${DBHelper.colRCCM_Ese}=\'${c.colRCCM_Ese}\',${DBHelper.colNom_Ese}=\'${c.colNom_Ese}\',${DBHelper.colRaisonSociale_Ese}=\'${c.colRaisonSociale_Ese}\',${DBHelper.colFormeJuridique_Ese}=\'${c.colFormeJuridique_Ese}\',${DBHelper.colGenreActivite_Ese}=\'${c.colGenreActivite_Ese}\',${DBHelper.colQuartier_Ese}=\'${c.colQuartier_Ese}\',${DBHelper.colAdresseEntreprise_Ese}=\'${c.colAdresseEntreprise_Ese}\',${DBHelper.colProprietaire_Ese}=\'${c.colProprietaire_Ese}\' WHERE ${DBHelper.colId_Ese}=${c.colId_Ese}';
      await db_connection.transaction((transaction) async {
        return await transaction.update(
            '${DBHelper.entrepriseTable}', c.toMap(),
            where: "${DBHelper.colId_Ese}=?", whereArgs: [c.colId_Ese]);
        //return await transaction.rawQuery(query);
      });
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
          'Modification reussie!....',
          style: TextStyle(color: Color.fromARGB(255, 7, 80, 31)),
        )),
      );
    } catch (e) {
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
          'Erreur!....\n{\$e}',
          style: TextStyle(color: Colors.red),
        )),
      );
    }
  }

  static void updateCompanyStatus(Company c, BuildContext ctx) async {
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      String query =
          "UPDATE ${DBHelper.entrepriseTable} SET ${DBHelper.colStatus}=1 WHERE ${DBHelper.colId_Ese}=${c.colId_Ese}";
      await db_connection.transaction((transaction) async {
        return await transaction.rawQuery(query);
      });
      // ScaffoldMessenger.of(ctx).showSnackBar(
      //                 const SnackBar(content: Text('Synchronisation reussie!....',style: TextStyle(color: Color.fromARGB(255, 7, 80, 31)),)),
      //               );
    } catch (e) {
      // ScaffoldMessenger.of(ctx).showSnackBar(
      //                 const SnackBar(content: Text("Attention! Erreur!....",style: TextStyle(color: Colors.red),)),
      //               );
    }
  }

//EXPORT TO EXCEL
  static Future<List<Company>> ExportExcelCompanies(BuildContext ctx) async {
    List<Company> company = [];
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      List<Map> list = await db_connection
          .rawQuery("SELECT * FROM ${DBHelper.entrepriseTable}");
      company = List<Company>.empty(growable: true);
      final excel = Excel.createExcel();
      final Sheet sheet = excel[excel.getDefaultSheet()!];
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: 0))
          .value = "CODE";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: 0))
          .value = "IDNAT";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: 0))
          .value = "RCCM";
      sheet
          .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: 0))
          .value = "NOM ENTREPRISE";
      for (int i = 0; i < list.length; i++) {
        Company p = new Company();
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 0, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colCode_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 1, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colIdNat_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 2, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colRCCM_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 3, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colNom_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 4, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colRaisonSociale_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 5, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colFormeJuridique_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 6, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colGenreActivite_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 7, rowIndex: i + 1))
            .value = list[i]['${DBHelper.ColRefCat}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 8, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colQuartier_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 9, rowIndex: i + 1))
            .value = list[i]['${DBHelper.ColRefcodeQuartier}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 10, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colAdresseEntreprise_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 11, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colProprietaire_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 12, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colDateSave_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 13, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colCreatedBy_Ese}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 14, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colEntreprisePhone1}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 15, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colEntreprisePhone2}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colEntrepriseMail}'];
        sheet
            .cell(CellIndex.indexByColumnRow(columnIndex: 16, rowIndex: i + 1))
            .value = list[i]['${DBHelper.colDetails}'];

        company.add(p);
      }
      //colDetails
      excel.save(fileName: "MyData.xlsx");
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
          'Telechargement reussi!....',
          style: TextStyle(color: Color.fromARGB(255, 7, 80, 31)),
        )),
      );
    } catch (e) {
      print(e);
    }
    return company;
  }
}
