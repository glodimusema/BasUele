import 'package:mob_enregistrement_manage/Home/add_company.dart';
import 'package:mob_enregistrement_manage/Login/login.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:typed_data';
import 'package:flutter/services.dart';
import 'dart:convert';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // The controller for the ListView
  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List of revenues'),
        actions: [
          InkWell(
            child: Icon(Icons.refresh),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
          InkWell(
            child: Icon(Icons.exit_to_app),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const LoginPage(),
                ),
              );

              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (BuildContext context) => super.widget));
            },
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
          ),
        ],
      ),
      body: Container(),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        tooltip: 'Add',
        onPressed: () async {
          try {
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AddRecette(),
              ),
            );
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => super.widget));
          } catch (e) {}
        },
        child: const Icon(
          Icons.add,
          color: Color.fromARGB(255, 70, 129, 196),
        ),
      ),
    );
  }
}
