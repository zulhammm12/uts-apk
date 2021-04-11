class Contact {
  // Initial variable String
  static const t_patient = 'patient';
  static const f_id = 'f_id';
  static const f_name = 'f_name';
  static const f_alamat = 'f_alamat';
  static const f_pendidikan = 'f_pendidikan';
  static const f_keahlian = 'f_keahlian';
  static const f_pengalaman = 'f_pengalaman';

  Contact({
    this.id,
    this.name,
    this.alamat,
    this.pendidikan,
    this.keahlian,
    this.pengalaman,
  });

  int id;
  String name;
  String alamat;
  String pendidikan;
  String keahlian;
  String pengalaman;

  Contact.fromMap(Map<String, dynamic> map) {
    id = map[f_id];
    name = map[f_name];
    alamat = map[f_alamat];
    pendidikan = map[f_pendidikan];
    keahlian = map[f_keahlian];
    pengalaman = map[f_pengalaman];
  }

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      f_name: name,
      f_alamat: alamat,
      f_pendidikan: pendidikan,
      f_keahlian: keahlian,
      f_pengalaman: pengalaman
    };
    if (id != null) map[f_id] = id;

    return map;
  }
}
