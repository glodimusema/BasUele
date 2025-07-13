import 'dart:async';
import 'dart:io' as io;
import 'package:flutter/foundation.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper {
  //Entreprise
  static String entrepriseTable = 'entreprises';
  static String colId_Ese = 'id_Ese';
  static String colCode_Ese = 'code_Ese';
  static String colIdNat_Ese = 'idNat';
  static String colRCCM_Ese = 'rccm';
  static String colNom_Ese = 'nomEntreprise';
  static String colRaisonSociale_Ese = 'raisonSociale';
  static String colFormeJuridique_Ese = 'formeJuridique';
  static String colGenreActivite_Ese = 'genreActivite';
  static String ColRefCat = 'refCat';
  static String colQuartier_Ese = 'quartier';
  static String ColRefcodeQuartier = 'refCodeQuartier';
  static String colAdresseEntreprise_Ese = 'adresseEntreprise';
  static String colProprietaire_Ese = 'proprietaire';
  static String colDateSave_Ese = 'created_at';
  static String colCreatedBy_Ese = 'created_by';
  static String colStatus = 'status';
  static String colEntreprisePhone1 = 'entreprisePhone1';
  static String colEntreprisePhone2 = 'entreprisePhone2';
  static String colEntrepriseMail = 'entrepriseMail';
  static String colDetails = 'Details';
//Users
  static String usersTable = 'users';
  static String colId_User = 'id_user';
  static String colFullName = 'fullname';
  static String colUsername = 'username';
  static String colPassword = 'password';
  static String colFonction = 'fonction';
  static String colAxe = 'axe';
  static String colTelephone = 'telephone';
//Quartiers
  static String quartierTable = 'quartiers';
  static String colId_quartier = 'id_quartier';
  static String colDesignation_quartier = 'designation_quartier';
  static String colCode_quartier = 'code_quartier';
//Categories
  static String categorieTable = 'tcatagorie';
  static String colId_cat = 'id_categorie';
  static String colDesignation_cat = 'categorie';
  static String colMontant_cat = 'montant';
  static String colMontant_Nom_cat = 'montant_nom';

  static Database? db_instance;
  static String PathDB = "";
  Future<Database> get db async => db_instance ??= await initDB();

  Future<Database> initDB() async {
    io.Directory documentsDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentsDirectory.path, "menageReg.db");
    PathDB = path;
    print(path);
    var db = await openDatabase(path, version: 1, onCreate: oncreateFunc);
    return db;
  }

  void oncreateFunc(Database db, int version) async {
    //create table
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $entrepriseTable ($colId_Ese INTEGER PRIMARY KEY AUTOINCREMENT,$colCode_Ese TEXT NOT NULL, $colIdNat_Ese TEXT, $colRCCM_Ese TEXT, $colNom_Ese TEXT, $colRaisonSociale_Ese TEXT, $colFormeJuridique_Ese TEXT, $colGenreActivite_Ese TEXT NOT NULL,$ColRefCat INTEGER NOT NULL, $colQuartier_Ese TEXT NOT NULL,$ColRefcodeQuartier TEXT NOT NULL, $colAdresseEntreprise_Ese TEXT NOT NULL, $colProprietaire_Ese TEXT NOT NULL, $colCreatedBy_Ese TEXT NOT NULL,$colEntreprisePhone1 TEXT NOT NULL,$colEntreprisePhone2 TEXT,$colEntrepriseMail TEXT,$colDetails TEXT, $colDateSave_Ese TEXT NOT NULL DEFAULT current_timestamp,$colStatus INTEGER DEFAULT 0)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $usersTable ($colId_User INTEGER PRIMARY KEY AUTOINCREMENT, $colFullName TEXT NOT NULL, $colUsername TEXT NOT NULL UNIQUE, $colPassword TEXT NOT NULL,$colFonction TEXT,$colAxe TEXT,$colTelephone TEXT)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $quartierTable ($colId_quartier INTEGER PRIMARY KEY AUTOINCREMENT, $colDesignation_quartier TEXT NOT NULL UNIQUE,$colCode_quartier TEXT NOT NULL)');
    await db.execute(
        'CREATE TABLE IF NOT EXISTS $categorieTable ($colId_cat INTEGER PRIMARY KEY AUTOINCREMENT, $colDesignation_cat TEXT NOT NULL,$colMontant_Nom_cat TEXT NOT NULL,$colMontant_cat TEXT NOT NULL)');
    //insertion users
    await db.execute(
        "INSERT INTO $usersTable($colFullName, $colUsername, $colPassword,$colFonction,$colAxe,$colTelephone) VALUES ('TESTER GOOGLE', 'TESTER', 'TESTER456#', 'Taxateur', 'Q. Katoyi', 'Google000')");

    //insertion quartiers
    await db.execute(
        "INSERT INTO $quartierTable($colDesignation_quartier,$colCode_quartier) VALUES ('Makiso', '00'),('Kisangani', '00'),('Lubunga', '000'),('Kabondo', '000'),('Tshopo', '000'),('Mangobo', '000'),('Kongakonga/Cimesta', '000'),('SPK12 RN4', 'UB'),('SPK(23) RN4&LUBUTU', 'UB'),('SPK121 RN4', 'UB'),('SITE1 UCBE', 'UB'),('SITE2 UCBE', 'UB'),('SITE3 UCBE', 'UB'),('S.CIMESTAN', 'UB'),('S.KIKONGO', 'UB'),('S.LUBUNGA', 'UB'),('SKBB&E', 'KIS'),('S.DU CANON', 'KIS'),('S.LITOYI & E', 'KIS'),('S.RIVE DROITE TSHOPO', 'KIS'),('S.MOIAT&E', 'KIS'),('SPK6RTE AERO&E', 'KIS'),('S.MANGOBO', 'KIS'),('S.ASPIRO', 'KIS'),('S.TEBEE', 'KIS')");
    //insertion categories
    await db.execute(
        "INSERT INTO $categorieTable($colDesignation_cat,$colMontant_Nom_cat,$colMontant_cat) VALUES ('Taxe Abbatage(A)', '5', '5')");
    //insertion categories
    await db.execute(
        "INSERT INTO $categorieTable($colDesignation_cat,$colMontant_Nom_cat,$colMontant_cat) VALUES ('Taxe Abbatage(B)', '5', '5')");
    //insertion categories
    await db.execute(
        "INSERT INTO $categorieTable($colDesignation_cat,$colMontant_Nom_cat,$colMontant_cat) VALUES ('Taxe Reboisement', '5', '5')");
    //insertion categories
    await db.execute(
        "INSERT INTO $categorieTable($colDesignation_cat,$colMontant_Nom_cat,$colMontant_cat) VALUES ('Taxe de Deboisement', '5', '5')");
  }

  //generate code
  // Future<String> getCode(String countParam,String tblParam,String condition,String value) async {
  //   String code;
  //   try{
  //   var db_connection=await db;
  //       int compteur=Sqflite.firstIntValue(await db_connection.rawQuery('SELECT COUNT($countParam) as nombre FROM $tblParam WHERE $condition=\'$value\''));
  //       if(compteur.isNaN || compteur==null || compteur==0){
  //         code=value+'001';
  //       }else{
  //         if(compteur<10){code=value+'00'+'$compteur';}
  //         else if(compteur>=10 && compteur<100){code=value+'0'+'$compteur';}
  //         else if(compteur>=100 && compteur<1000){code=value+'$compteur';}
  //       }

  //   }catch(e){
  //     print(e);
  //   }
  //       return code;
  // }
}
