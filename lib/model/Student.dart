class Student {
  int id;
  String nama_depan;
  String nama_belakang;
  String no_hp;
  String gender;
  String jenjang;
  String hobi;
  String alamat;
  String email;
  Student(
    this.id, 
    this.nama_depan,
    this.nama_belakang,
    this.no_hp,
    this.gender,
    this.jenjang,
    this.hobi,
    this.alamat,
    this.email,
  );

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'id': id,
      'nama_depan': nama_depan,
      'nama_belakang': nama_belakang,
      'no_hp': no_hp,
      'gender': gender,
      'jenjang': jenjang,
      'hobi': hobi,
      'alamat': alamat,
      'email': email,
    };
    return map;
  }

  Student.fromMap(Map<String, dynamic> map) {
    id = map['id'];
    nama_depan = map['nama_depan'];
    nama_belakang = map['nama_belakang'];
    no_hp = map['no_hp'];
    gender = map['gender'];
    jenjang = map['jenjang'];
    hobi = map['hobi'];
    alamat = map['alamat'];
    email = map['email'];
  }
}