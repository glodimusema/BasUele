import 'package:mob_enregistrement_manage/Database/DBHelper.dart';
import 'package:mob_enregistrement_manage/MyClasses/pub_con.dart';

class Category {
  int? colId_cat;
  String? colDesignation_cat;
  String? colMontant_cat;

  //CRUD FUNCTIONS
  Future<List<Category>> FilterCategory(String query) async {
    List<Category> categories = [];
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      List<Map> list = await db_connection.rawQuery(
          'SELECT * FROM ${DBHelper.categorieTable} WHERE ${DBHelper.colDesignation_cat} LIKE \'%${query}%\' ');
      categories = List<Category>.empty(growable: true);
      for (int i = 0; i < list.length; i++) {
        Category p = new Category();
        p.colId_cat=list[i]['${DBHelper.colId_cat}'];
        p.colDesignation_cat = list[i]['${DBHelper.colDesignation_cat}'];
        p.colMontant_cat = list[i]['${DBHelper.colMontant_cat}'];
        categories.add(p);
      }
    } catch (e) {}
    return categories;
  }

  Future<List<Category>> GetCategoryFromDB() async {
    List<Category> categories = [];
    try {
      DBHelper db = DBHelper();
      var db_connection = await db.db;
      List<Map> list = await db_connection
          .rawQuery('SELECT * FROM ${DBHelper.categorieTable}');
      categories = List<Category>.empty(growable: true);
      PubCon.categories=[];
      for (int i = 0; i < list.length; i++) {
        Category p = new Category();
        p.colId_cat=list[i]['${DBHelper.colId_cat}'];
        p.colDesignation_cat = list[i]['${DBHelper.colDesignation_cat}'];
        p.colMontant_cat = list[i]['${DBHelper.colMontant_cat}'];
        categories.add(p);
        PubCon.categories.add(p);
      }
    } catch (e) {}
    return categories;
  }
}
