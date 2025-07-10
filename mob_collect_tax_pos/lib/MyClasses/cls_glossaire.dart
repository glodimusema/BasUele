import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mob_collect_tax_pos/Home/home_recette.dart';
import 'package:mob_collect_tax_pos/MyClasses/cls_colors.dart';
import 'package:mob_collect_tax_pos/MyClasses/pub_con.dart';

class Glossaire {
  static String baseUrl_mvt =
      '${PubCon.cheminApi}fetch_paiementtaxe_agent/${PubCon.id_agent}';

//login
  static Future<List?> mylogin(GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context, String user, String pass) async {
    final queryParameters = {
      'mail': user,
      'codeSecret': pass,
    };
    Map<String, String> headers = {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*'
    };
    try {
      var url = Uri.http(
          '${PubCon.url_domaine}', 'api/fetch_login_agent', queryParameters);

      // Await the http get response, then decode the json-formatted response.
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var datauser =
            jsonDecode(response.body)['data']; // as Map<String, dynamic>;
        print(datauser);
        if (datauser.length == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('login incorrect!!!')),
          );
        } else {
          PubCon.id_agent = datauser[0]['id'];
          PubCon.noms_author = datauser[0]['noms_agent'];
          PubCon.telephone_profil = datauser[0]['contact_agent'];
          PubCon.mail = datauser[0]['mail_agent'];
          PubCon.adresse_profil = datauser[0]['nomQuartier'];
          print(PubCon.telephone_profil);
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MyHomePage(
                title: "Revenue_Collector",
              ),
            ),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Echec de connexion!')),
        );
      }
    } on Exception catch (e) {
      print(e);
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verifiez votre connexion!')),
      );
      return null;
    }
  }

//insert data into database
  static Future insert_recette(
      BuildContext ctx,
      String montant,
      String qte,
      String recouvrement,
      String marque_vehicule,
      String lieu_chargement,
      String destination,
      String bordereau,
      String observations) async {
    try {
      var url =
          Uri.https('ffn-tshopo-bas-uele.site', 'api/insert_taxe_paiement');
      var response = await http.post(url, body: {
        'refEse': PubCon.refEntreprise.toString(),
        'refMois': PubCon.refMois.toString(),
        'refAnnee': PubCon.refAnnee.toString(),
        'refAgent': PubCon.id_agent.toString(),
        'refCompte': PubCon.refCompte.toString(),
        'montant': montant.toString(),
        'author': PubCon.noms_author,
        'qte': qte,
        'recouvrement': recouvrement,
        'refExploitation': PubCon.refExploitation.toString(),
        'marque_vehicule': marque_vehicule,
        'lieu_chargement': lieu_chargement,
        'destination': destination,
        'bordereau': bordereau,
        'observations': observations
      });
      print(
          "refaneee: ${PubCon.refAnnee}, refMois: ${PubCon.refMois}, refExploitation: ${PubCon.refExploitation}");
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        //print("Enregistrement reussi");
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(content: Text('Enregistrement reussi!')),
        );
        Navigator.of(ctx).pop();
      } else {
        ScaffoldMessenger.of(ctx).showSnackBar(
          const SnackBar(
              content: Text(
            'Echec d\'enregistrement!....',
            style: TextStyle(color: Colors.red),
          )),
        );
      }
    } catch (e) {
      print(e);
      ScaffoldMessenger.of(ctx).showSnackBar(
        const SnackBar(
            content: Text(
          'Une erreur s\'est produite lors de l\'enregistrement....',
          style: TextStyle(color: Colors.red),
        )),
      );
    }
  }

//Get entreprise by code
//
  static Future<List?> getEseByCode(GlobalKey<ScaffoldState> _scaffoldKey,
      BuildContext context, String code) async {
    final queryParameters = {'colId_Ese': code};
    try {
      var url = Uri.http('${PubCon.url_domaine}',
          'api/fetch_contribuable_bycode', queryParameters);
      var response = await http.get(url);
      if (response.statusCode == 200) {
        var datauser = jsonDecode(response.body); // as Map<String, dynamic>;
        print(datauser.length);
        if (datauser.length == 0) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Aucune entreprise trouvée')),
          );
        } else {
          PubCon.refEntreprise = datauser[0]['id'];
          PubCon.DesignationEntreprise = datauser[0]['colProprietaire_Ese'];
          PubCon.PrixEntreprise = datauser[0]['prix_categorie'].toString();
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Echec de connexion')),
        );
      }
    } on Exception catch (e) {
      print("===================================\n$e");
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Verifiez votre connexion!')),
      );
      return null;
    }
    return null;
  }
}
