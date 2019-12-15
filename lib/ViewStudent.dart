import 'package:flutter/material.dart';
import 'package:sekolahku_sqlite/DatabaseHelper.dart';
import 'package:sekolahku_sqlite/ListStudent.dart';
import 'package:sekolahku_sqlite/model/Student.dart';
import 'dart:async';

class ViewStudent extends StatefulWidget{
  // variabel global untuk menangpung list siswa dari route
  final int index;
  ViewStudent({Key key, @required this.index}) : super (key :key);
  // buat class state untuk view siswa
  @override
  _ViewStudent createState() => _ViewStudent();
}
  
class _ViewStudent extends State<ViewStudent>{

  // ViewStudent({this.index});
  DatabaseHelper dbHelper;
  String namadepan;
  String namabelakang;
  String nohp;
  String gender;
  String jenjang;
  String hobi;
  String valHobi;
  String alamat;
  String email;
  int id;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    id = widget.index;
    main(id); 
  }

  Future main(id) async {
    Student list = await dbHelper.getStudent(id);
    setState(() {
      namadepan = list.nama_depan;
      namabelakang = list.nama_belakang;
      nohp = list.no_hp;
      gender = list.gender;
      jenjang = list.jenjang;
      hobi = list.hobi.toString();
      var val1 = hobi.replaceAll('[', '');
      var val2 = val1.replaceAll(']', '');
      valHobi = val2;
      alamat = list.alamat;
      email = list.email;
    });
  }

  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Detail Siswa"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        
        padding: const EdgeInsets.all(10.0),
        child: ListView(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.person),
              title: Text("$namadepan  $namabelakang"),
              subtitle: Text("Nama"),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.email),
              title: Text("$email"),
              subtitle: Text("Email"),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.school),
              title: Text("$nohp"),
              subtitle: Text("No Tlp."),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.sort),
              title: Text("$gender"),
              subtitle: Text("Gender"),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.phone),
              title: Text("$jenjang"),
              subtitle: Text("Jenjang"),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.child_care),
              title: Text("$valHobi"),
              subtitle: Text("Hobi"),
            ),
            Divider(
              color: Colors.grey,
            ),
            ListTile(
              leading: Icon(Icons.map),
              title: Text("$alamat"),
              subtitle: Text("Alamat"),
            ),
            Divider(
              color: Colors.grey,
            ),
          ],
        )

      ),
    );
  }
} 