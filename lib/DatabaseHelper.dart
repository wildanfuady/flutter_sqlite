import 'package:sekolahku_sqlite/model/Student.dart';
import 'package:sqflite/sqflite.dart';
import 'dart:io' as io;
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

class DatabaseHelper {

  static Database _db;
  
  Future<Database> get db async {
  
    if (_db != null) {
      return _db;
    }
    
    _db = await initDatabase();
    return _db;
 
  }

  initDatabase() async {

    io.Directory documentDirectory = await getApplicationDocumentsDirectory();
    String path = join(documentDirectory.path, 'student.db');
    var db = await openDatabase(path, version: 1, onCreate: _onCreate);
    return db;
    
  }

  _onCreate(Database db, int version) async {
    await db
        .execute('CREATE TABLE student (id INTEGER PRIMARY KEY, nama_depan TEXT, nama_belakang TEXT, no_hp TEXT, gender TEXT, jenjang TEXT, hobi TEXT, alamat TEXT, email TEXT)');
  }

  // Function Tambah Data Siswa
  Future<Student> add(Student student) async {
    var dbClient = await db;
    student.id = await dbClient.insert('student', student.toMap());
    return student;
  }

  // Function Get Siswa Berdasarkan Id
  Future<List<Student>> getStudents() async {
    var dbClient = await db;
    List<Map> maps = await dbClient.query('student', columns: ['id', 'nama_depan', 'nama_belakang']);
    List<Student> students = [];
    if (maps.length > 0) {
      for (int i = 0; i < maps.length; i++) {
        students.add(Student.fromMap(maps[i]));
      }
    }
    return students;
  }

  Future<Student> getStudent(int id) async {
    var dbClient = await db;
    List<Map> results = await dbClient.query("student",
        columns: ["id", "nama_depan", "nama_belakang", "no_hp", "gender", "jenjang", "hobi", "alamat", "email"],
        where: 'id = ?',
        whereArgs: [id]);

    if (results.length > 0) {
      return new Student.fromMap(results.first);
    }

    return null;
  }

  Future<List> getAllRecords(String dbTable) async {
    var dbClient = await db;
    var result = await dbClient.rawQuery("SELECT * FROM $dbTable");

    return result.toList();
  }

  // Function Hapus Siswa
  Future<int> delete(int id) async {
    var dbClient = await db;
    return await dbClient.delete(
      'student',
      where: 'id = ?',
      whereArgs: [id],
    );
  }

  // Function Update Siswa
  Future<int> update(Student student) async {
    var dbClient = await db;
    return await dbClient.update(
      'student',
      student.toMap(),
      where: 'id = ?',
      whereArgs: [student.id],
    );
  }

  // Function Close Access Database
  Future close() async {
    var dbClient = await db;
    dbClient.close();
  }
}
