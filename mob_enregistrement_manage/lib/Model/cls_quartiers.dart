import 'package:mob_enregistrement_manage/Database/DBHelper.dart';

class Quartiers {
 int? colId_quartier;
 String? colDesignation_quartier;
 String? colCodeQuartier;


  //CRUD FUNCTIONS
Future<List<Quartiers>> FilterQuartier(String query) async {
    List<Quartiers> quartiers=[];
    try{
    DBHelper db =DBHelper();
    var db_connection = await db.db;
    List<Map> list =
    await db_connection.rawQuery('SELECT * FROM ${DBHelper.quartierTable} WHERE ${DBHelper.colDesignation_quartier} LIKE \'%${query}%\' ');
    quartiers = List<Quartiers>.empty(growable: true);
    for (int i = 0; i < list.length; i++) {
      Quartiers p = new Quartiers();
      p.colId_quartier=list[i]['${DBHelper.colId_quartier}'];
      p.colDesignation_quartier = list[i]['${DBHelper.colDesignation_quartier}'];
      p.colCodeQuartier=list[i]['${DBHelper.colCode_quartier}'];
      quartiers.add(p);
    }
    
    }catch(e){

    }
    return quartiers;
  }
Future<List<Quartiers>> GetQuartiersFromDB() async {
    List<Quartiers> quartiers=[];
    try{
    DBHelper db =DBHelper();
    var db_connection = await db.db;
    List<Map> list =
    await db_connection.rawQuery('SELECT * FROM ${DBHelper.quartierTable}');
    quartiers = List<Quartiers>.empty(growable: true);
    for (int i = 0; i < list.length; i++) {
      Quartiers p = new Quartiers();
      p.colId_quartier=list[i]['${DBHelper.colId_quartier}'];
      p.colDesignation_quartier = list[i]['${DBHelper.colDesignation_quartier}'];
      p.colCodeQuartier=list[i]['${DBHelper.colCode_quartier}'];
      quartiers.add(p);
    }
    
    }catch(e){

    }
    return quartiers;
  }
}
