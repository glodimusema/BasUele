import 'dart:async';
import 'package:mob_enregistrement_manage/Model/cls_categorie.dart';
import 'package:mob_enregistrement_manage/MyClasses/pub_con.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<List<Category>> getCategoryFormDB() async {
  var as1 = Category();
  Future<List<Category>> categories = as1.GetCategoryFromDB();

  return categories;
}

class CategoryList extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => new CategoryListState();
}

class CategoryListState extends State<CategoryList> {
  List<Category> items = [];
  List<Category> filteredItems = [];
  String _query = '';

  void search(String query) {
    setState(
      () {
        _query = query;

        filteredItems = PubCon.categories
            .where(
              (item) =>
                  item.colDesignation_cat.toString().toLowerCase().contains(
                        query.toLowerCase(),
                      ),
            )
            .toList();
      },
    );
  }

  @override
  void initState(){
    // TODO: implement initState

    super.initState();
    setState(() {
      getCategoryFormDB();
      items=PubCon.categories;
    });
  }

  final TextEditingController searchTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    items = PubCon.categories;
    return new Scaffold(
      appBar: AppBar(
        title: TextField(
          
          cursorColor: Color.fromARGB(255, 58, 148, 170) ,
          style: const TextStyle(color: Color.fromARGB(255, 58, 148, 170)),
          onChanged: (value) {
            search(value);
          },
          decoration: InputDecoration(
                            labelText: 'T',
                            hintText: 'Recherchez ici...',
                            hintStyle: TextStyle(
                                color: Color(0xff49A2B6), fontSize: 20),
                            
                            prefixIcon: Icon(Icons.search,color: Colors.green,)
                            ),
                            
        ),
      ),
      body: body1()
      
      // filteredItems.isNotEmpty || _query.isNotEmpty
      //     ? filteredItems.isEmpty
      //         ? const Center(
      //             child: Text(
      //               'Aucune categorie trouvée',
      //               style: TextStyle(fontSize: 18,color: Colors.red),
      //             ),
      //           )
      //         : ListView.builder(
      //             itemCount: filteredItems.length,
      //             itemBuilder: (context, index) {
      //               return InkWell(
      //                 onTap: () {
      //               PubCon.nomCategorie = '${filteredItems[index].colDesignation_cat}';
      //               PubCon.refCategorie =
      //                   int.parse('${filteredItems[index].colId_cat}');
      //               print('===================>\n\n\n========================================${PubCon.refCategorie}');
      //               if (Navigator.canPop(context)) {
      //                 Navigator.pop(context);
      //               } else {
      //                 SystemNavigator.pop();
      //               }
      //             },
      //                 child: Card(
      //                   margin: EdgeInsets.all(8.0),
      //                     color: Colors.white,
      //                     elevation: 2.0,
      //                   child: ListTile(
      //                     title: Text(
      //                         filteredItems[index].colDesignation_cat.toString()),
      //                     subtitle: Text(
      //                         "Montant: ${filteredItems[index].colMontant_cat.toString()}"),
      //                   ),
      //                 ),
      //               );
      //             },
      //           )
      //     : ListView.builder(
      //         itemCount: items.length,
      //         itemBuilder: (context, index) {
      //           return InkWell(
      //             onTap: () {
      //               PubCon.nomCategorie = '${items[index].colDesignation_cat}';
      //               PubCon.refCategorie =
      //                   int.parse('${items[index].colId_cat}');
      //               print('===================>\n\n\n====================================${PubCon.refCategorie}');
      //               if (Navigator.canPop(context)) {
      //                 Navigator.pop(context);
      //               } else {
      //                 SystemNavigator.pop();
      //               }
      //             },
      //             child: Card(
      //               margin: EdgeInsets.all(8.0),
      //                     color: Colors.white,
      //                     elevation: 2.0,
      //               child: ListTile(
      //                 title: Text(items[index].colDesignation_cat.toString()),
      //                 subtitle:  Text(
      //                         "Montant: ${items[index].colMontant_cat.toString()}"),
      //               ),
      //             ),
      //           );
      //         },
      //       ),
    );
  }
}


Widget body1(){
  return new Container(
        padding: EdgeInsets.all(0.0),
        child: FutureBuilder<List<Category>>(
          future: getCategoryFormDB(),
          builder: (context, snapshot) {
            if (snapshot.data != null) {
              if (snapshot.hasData) {
                if (snapshot.data?.length == 0) {
                  return Container(
                    alignment: AlignmentDirectional.center,
                    child: Text(
                      'Aucune Categorie trouvée.\n',
                      style: TextStyle(
                          color: Colors.white,
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
                                    child: InkWell(
                                      onTap: () {
                                        PubCon.nomCategorie =
                                            '${snapshot.data?[index].colDesignation_cat}';
                                        PubCon.refCategorie = int.parse(
                                            '${snapshot.data?[index].colId_cat}');
                                        print(
                                            '===================>${PubCon.refCategorie}');
                                        if (Navigator.canPop(context)) {
                                          Navigator.pop(context);
                                        } else {
                                          SystemNavigator.pop();
                                        }
                                      },
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: <Widget>[
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0, top: 4.0),
                                            child: Text(
                                              '${snapshot.data?[index].colDesignation_cat}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 15),
                                            ),
                                          ),
                                          Container(
                                            padding: const EdgeInsets.only(
                                                bottom: 4.0, top: 4.0),
                                            child: Text(
                                              'Montant : ${snapshot.data?[index].colMontant_cat}',
                                              style: TextStyle(
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 14),
                                            ),
                                          ),
                                          // Text('Numero d\'ordre: ${snapshot.data[index].colNumordrevlg}',
                                          //   style: TextStyle(color: Colors.grey[500]),
                                          // ),
                                        ],
                                      ),
                                    ),
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
                return Text('Aucune Categorie trouvée.\n',
                    style: TextStyle(color: Color.fromARGB(255, 77, 51, 51)));
              }
            }

//show loading while snapshot is not getting data
            return new Container(
              alignment: AlignmentDirectional.center,
              child: new CircularProgressIndicator(),
            );
          },
        ),
      );
}