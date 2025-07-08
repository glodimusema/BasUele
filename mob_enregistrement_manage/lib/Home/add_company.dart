import 'package:flutter/material.dart';
import 'package:mob_enregistrement_manage/MyClasses/cls_glossaire.dart';

class AddRecette extends StatefulWidget {
  const AddRecette({ Key? key }) : super(key: key);

  @override
  State<AddRecette> createState() => _AddRecetteState();
}

class _AddRecetteState extends State<AddRecette> {
  final _formKey = GlobalKey<FormState>();
  bool saving=false;
  TextEditingController 
  _edittxtMontant=TextEditingController(),
  _edittxtMotif=TextEditingController();






  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      appBar: AppBar(title: Text("Add a revenue")),
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _edittxtMotif,
                validator: (value) {
                  if (value.toString() == "") {
                    return 'enter the valid reason for payment.';
                  }
                },
                keyboardType: TextInputType.text,
                style: TextStyle(color: Color(0xff49A2B6)),
                decoration: InputDecoration(
                  hintText: "Enter the reason for payment",
                  labelText: "reason",
                  hintStyle: TextStyle(color: Color(0xff49A2B6)),
                  border: InputBorder.none,
                  // icon: Icon(
                  //   Icons.bubble_chart,
                  //   color: Color(0xff49A2B6),
                  // )
                ),
              )),
              Container(
            child: Divider(
              color: Colors.blue.shade400,
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
          ),
            
           Container(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
              child: TextFormField(
                controller: _edittxtMontant,
                validator: (value) {
                  try{
                    double x= double.parse(value!);
                    if (value.toString() == ""|| value.isEmpty){
                    return 'Enter the amount (in FC).';
                  }
                  }catch (e){
                    return 'Wrong format of the amount in decimal.';
                  }
                },
                keyboardType: TextInputType.number,
                style: TextStyle(color: Color(0xff49A2B6)),
                decoration: InputDecoration(
                  hintText: "Enter the amount (FC)",
                  labelText: "Amount(FC)",
                  hintStyle: TextStyle(color: Color(0xff49A2B6)),
                  border: InputBorder.none,
                  // icon: Icon(
                  //   Icons.bubble_chart,
                  //   color: Color(0xff49A2B6),
                  // )
                ),
              )),
              Container(
            child: Divider(
              color: Colors.blue.shade400,
            ),
            padding: EdgeInsets.only(left: 20.0, right: 20.0, bottom: 10.0),
          ),
            
                                         
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child:saving? Center(child: CircularProgressIndicator(),): ElevatedButton(
                
                onPressed: () {

                  // Validate returns true if the form is valid, or false otherwise.
                  if (_formKey.currentState!.validate()) {
                    try{
                      setState(() {
                        saving=true;
                      });
                     ///// Glossaire.insert_recette(_edittxtMontant.text,_edittxtMotif.text,context);

                      setState(() {
                        saving=false;
                      });
                    }catch(e){
                      setState(() {
                        saving=false;
                      });
                    }
                    
                    // ScaffoldMessenger.of(context).showSnackBar(
                    //   const SnackBar(content: Text('Processing....')),
                    // );
                  }
                },
                child: const Text('Save'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}