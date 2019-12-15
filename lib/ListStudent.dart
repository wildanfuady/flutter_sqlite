import 'package:flutter/material.dart';
import 'package:sekolahku_sqlite/DatabaseHelper.dart';
import 'package:sekolahku_sqlite/EditStudent.dart';
import 'package:sekolahku_sqlite/FormStudent.dart';
import 'package:sekolahku_sqlite/ViewStudent.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:random_color/random_color.dart';

class ListStudent extends StatefulWidget {
  @override
  _ListStudentState createState() => _ListStudentState();
}

class _ListStudentState extends State<ListStudent> {

  bool isUpdate = false;
  int studentIdForUpdate;
  DatabaseHelper dbHelper;

  @override
  void initState() {
    super.initState();
    dbHelper = DatabaseHelper();
    refreshStudentList();
  }

  editData(id){
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => EditStudent(id: id)),
    );
  }

  void confirm(id){
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Apakah Anda yakin ingin menghapus list ini?"),
      actions: <Widget>[
        RaisedButton(
          child: Text("Delete", style: TextStyle(color: Colors.white),),
          color: Colors.red,
          onPressed: (){
            deleteData(id);
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => ListStudent()),
            );
          },
        ),
        new RaisedButton(
          child: Text("Close", style:TextStyle(color: Colors.white),),
          color: Colors.green,
          onPressed: () => Navigator.pop(context),
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  } 


  deleteData(id) async{
    await dbHelper.delete(id);
  }

  refreshStudentList() {
    setState(() {
      // students = dbHelper.getStudents();
    });
  }

  void contextMenu(id){
    AlertDialog alertDialog = new AlertDialog(
      content: Text("Silahkan pilih action yang Anda butuhkan pada list ini: "),
      actions: <Widget>[
        RaisedButton(
          child: Text("Edit", style: TextStyle(color: Colors.white),),
          color: Colors.green,
          onPressed: (){
            editData(id);
          },
        ),
        new RaisedButton(
          child: Text("Delete", style:TextStyle(color: Colors.white,),),
          color: Colors.red,
          onPressed: (){
            confirm(id);
          },
        ),
      ],
    );
    showDialog(context: context, child: alertDialog);
  } 



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text('Sekolahku'),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormStudent()),
              );
            },
          )
        ],
      ),
      body: FutureBuilder<List>(
        future: dbHelper.getAllRecords("student"),
        initialData: List(),
        builder: (context, snapshot) {
          return snapshot.hasData
            ? ListView.builder(
              itemCount: snapshot.data.length,
              itemBuilder: (_, int position) {
                final student = snapshot.data[position];
                
                //get your item data here ...
                // return GestureDetector(
                //   onLongPress: () {
                //     contextMenu(student.row[0]);
                //   },
                //   child: Card(
                //     child: ListTile(
                //       title: Text(student.row[1]+" "+student.row[2]),
                //       leading: Icon(Icons.person, size: 40.0,),
                //       subtitle: Text(student.row[3]),
                //       onTap: () => 
                //         Navigator.push(
                //           context,
                //           MaterialPageRoute(builder: (context) => ViewStudent(index: student.row[0],)),
                //         ),
                //         // Navigator.of(context).pushReplacement(
                //         // new MaterialPageRoute(
                //         //   builder: (BuildContext context) => ViewStudent(index: student.row[0],)
                //         // ),
                //     ),
                //   ),
                // );
                RandomColor _randomColor = RandomColor();
                Color _color = _randomColor.randomColor();
                return Slidable(
                  delegate: new SlidableDrawerDelegate(),
                  actionExtentRatio: 0.25,
                  child: new Container(
                    color: Colors.white,
                    child: new ListTile(
                      leading: new CircleAvatar(
                        backgroundColor: _color,
                        child: new Icon(Icons.people),
                        foregroundColor: Colors.white,
                      ),
                      title: Text(student.row[1]+" "+student.row[2]),
                      subtitle: Text(student.row[3]),
                      trailing: Text(student.row[4] +"\n"+ student.row[5], style: TextStyle(fontSize: 14), textAlign: TextAlign.end,),
                      onTap: () => 
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => ViewStudent(index: student.row[0],)),
                        ),
                    ),
                  ),
                  // actions: <Widget>[
                  //   new IconSlideAction(
                  //     caption: 'Archive',
                  //     color: Colors.blue,
                  //     icon: Icons.archive,
                  //     onTap: () => print('Archive'),
                  //   ),
                  //   new IconSlideAction(
                  //     caption: 'Share',
                  //     color: Colors.indigo,
                  //     icon: Icons.share,
                  //     onTap: () => print('Share'),
                  //   ),
                  // ],
                  secondaryActions: <Widget>[
                    new IconSlideAction(
                      caption: 'Edit',
                      color: Colors.blue,
                      icon: Icons.edit,
                      onTap: () => editData(student.row[0]),
                    ),
                    new IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => confirm(student.row[0]),
                    ),
                  ],
                );
              },
            )
          : Center(
            child: CircularProgressIndicator(),
          );
        },
      ),
    );
  }
}