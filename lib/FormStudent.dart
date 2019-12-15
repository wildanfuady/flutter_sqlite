import 'package:flutter/material.dart';
import 'package:sekolahku_sqlite/DatabaseHelper.dart';
import 'package:sekolahku_sqlite/ListStudent.dart';
import 'package:sekolahku_sqlite/model/Student.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
class FormStudent extends StatefulWidget {
  @override
  _StudentPageState createState() => _StudentPageState();
}

class _StudentPageState extends State<FormStudent> {

  final GlobalKey<FormState> _formStateKey = GlobalKey<FormState>();
  DatabaseHelper dbHelper;

  final FocusNode _namadepan = FocusNode();  
  final FocusNode _namabelakang = FocusNode();  
  final FocusNode _nohp = FocusNode();  
  final FocusNode _email = FocusNode();  
  final FocusNode _alamat = FocusNode();  

  // kondisi untuk select / radio button
  String _jenjang = "TK";
  String gender = "Laki-laki";

  // kondisi untuk checkbox
  List<String> hobi = ["Membaca"];

  TextEditingController _namaDepanController = new TextEditingController();
  TextEditingController _namaBelakangController = new TextEditingController();
  TextEditingController _noHpController = new TextEditingController();
  TextEditingController _emailController = new TextEditingController();
  TextEditingController _alamatController = new TextEditingController();

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
  }

  simpan(){
    dbHelper.add(Student(null, _namaDepanController.text, _namaBelakangController.text, _noHpController.text, gender, _jenjang, hobi.toString(), _alamatController.text, _emailController.text));
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => ListStudent()),
    );
  }

  _fieldFocusChange(BuildContext context, FocusNode currentFocus,FocusNode nextFocus) {
    currentFocus.unfocus();
    FocusScope.of(context).requestFocus(nextFocus);  
  }
  
  @override
  Widget build(BuildContext context) {

    final Size screenSize = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        title: Text('Tambah Siswa'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Form(
        key: _formStateKey,
        autovalidate: false,
        child: Padding(
          padding: const EdgeInsets.all(10.0),
          child: ListView(
              children: <Widget>[
                Row(
                  children: <Widget>[
                    Expanded(
                      flex: 1,
                      child:  TextFormField(
                        textInputAction: TextInputAction.next,
                        focusNode: _namadepan,
                        onFieldSubmitted: (term){
                          _fieldFocusChange(context, _namadepan, _namabelakang);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Student Name';
                          }
                          if (value.trim() == "")
                            return "Only Space is Not Valid!!!";
                          return null;
                        },
                      controller: _namaDepanController,
                      decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.purple,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          labelText: "Nama Depan",
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.purple,
                          )),
                      ),
                
                    ),
                    Container(
                      width: 5.0,
                    ),
                    Expanded(
                      flex: 1,
                      child: TextFormField(
                        textInputAction: TextInputAction.next,
                        focusNode: _namabelakang,
                        onFieldSubmitted: (term){
                          _fieldFocusChange(context, _namabelakang, _email);
                        },
                        validator: (value) {
                          if (value.isEmpty) {
                            return 'Please Enter Student Name';
                          }
                          if (value.trim() == "")
                            return "Only Space is Not Valid!!!";
                          return null;
                        },
                        controller: _namaBelakangController,
                        decoration: InputDecoration(
                          focusedBorder: new UnderlineInputBorder(
                              borderSide: new BorderSide(
                                  color: Colors.purple,
                                  width: 2,
                                  style: BorderStyle.solid)),
                          // hintText: "Student Name",
                          labelText: "Nama Belakang",
                          fillColor: Colors.white,
                          labelStyle: TextStyle(
                            color: Colors.purple,
                          )
                        ),
                      ),
                    ),
                  ],
                ),
                TextFormField(
                  keyboardType: TextInputType.emailAddress,
                  textInputAction: TextInputAction.next,
                  focusNode: _email,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, _email, _nohp);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Email Address';
                    }
                    if (value.trim() == "")
                      return "Only Space is Not Valid!!!";
                    return null;
                  },
                controller: _emailController,
                decoration: InputDecoration(
                    focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.purple,
                            width: 2,
                            style: BorderStyle.solid)),
                    // hintText: "Student Name",
                    labelText: "Email",
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.purple,
                    )),
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  textInputAction: TextInputAction.next,
                  focusNode: _nohp,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, _nohp, _alamat);
                  },
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter No Hp';
                    }
                    if (value.trim() == "")
                      return "Only Space is Not Valid!!!";
                    return null;
                  },
                controller: _noHpController,
                decoration: InputDecoration(
                    focusedBorder: new UnderlineInputBorder(
                        borderSide: new BorderSide(
                            color: Colors.purple,
                            width: 2,
                            style: BorderStyle.solid)),
                    // hintText: "Student Name",
                    labelText: "No Hp",
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.purple,
                    )),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                Text(
                  "Gender:", 
                  style: TextStyle(fontSize: 16, color: Colors.purple),
                  textAlign: TextAlign.left,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                RadioButtonGroup(
                  labels: <String>[
                    "Laki-laki",
                    "Perempuan",
                  ],
                  
                  onSelected: (String selected) => setState((){
                    gender = selected;
                  }),
                  picked: gender,
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                Text(
                  "Jenjang:", 
                  style: TextStyle(fontSize: 16, color: Colors.purple),
                  textAlign: TextAlign.left,
                ),
                DropdownButton<String>(
                  isExpanded: true,
                  value: _jenjang,
                  onChanged: (String jenjang) {
                    setState(() {
                      _jenjang = jenjang;
                    });
                  },
                  items: <String>[
                    'TK',
                    'SD',
                    'SMP'
                  ].map<DropdownMenuItem<String>>(
                    (String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value),
                      );
                    }
                  ).toList(),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                Text(
                  "Hobi:", 
                  style: TextStyle(fontSize: 16, color: Colors.purple),
                  textAlign: TextAlign.left,
                ),
                CheckboxGroup(
                  margin: EdgeInsets.only(right: 10.0),
                  labels: <String>[
                    "Membaca",
                    "Menulis",
                    "Menggambar",
                  ],
                  checked: hobi,
                  onChange: (
                    bool isChecked, 
                    String label, 
                    int index
                  ) => print("isChecked: $isChecked, label: $label, index: $index"),
                  onSelected: (List<String> checked) => setState((){
                    hobi = checked;
                  }),
                ),
            
                Padding(
                  padding: EdgeInsets.only(top: 10.0),
                ),
                TextFormField(
                  validator: (value) {
                    if (value.isEmpty) {
                      return 'Please Enter Address';
                    }
                    if (value.trim() == "")
                      return "Only Space is Not Valid!!!";
                    return null;
                  },
                  keyboardType: TextInputType.multiline,
                  focusNode: _alamat,
                  onFieldSubmitted: (term){
                    _fieldFocusChange(context, _alamat, null);
                  },
                  maxLines: 2,
                  controller: _alamatController,
                  decoration: InputDecoration(
                    focusedBorder: new UnderlineInputBorder(
                      borderSide: new BorderSide(
                          color: Colors.purple,
                          width: 2,
                          style: BorderStyle.solid
                        )
                    ),
                    // hintText: "Student Name",
                    labelText: "Alamat",
                    fillColor: Colors.white,
                    labelStyle: TextStyle(
                      color: Colors.purple,
                    )
                  ),
                ),
                
                Padding(
                  padding: EdgeInsets.only(top: 20.0),
                ),
                Container(
                  width: screenSize.width,
                  child: RaisedButton(
                    color: Colors.purple,
                    child: Text('Simpan Data',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      if (_formStateKey.currentState.validate()) {
                          _formStateKey.currentState.save();
                          simpan();
                        }
                    }  
                  ),
                ),
              ],
            ),
        ),
      ),
    );
  }
}