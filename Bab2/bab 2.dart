import 'dart:core';

// Kelas ProdukDigital
class ProdukDigital {
  String namaProduk;
  double harga;
  String kategori;

  ProdukDigital(this.namaProduk, this.harga, this.kategori);

  void terapkanDiskon(double persentase) {
    if (kategori == 'NetworkAutomation') {
      harga -= harga * (persentase / 100);
      print('Diskon sebesar $persentase% diterapkan. Harga baru: $harga');
    } else {
      print('Diskon hanya berlaku untuk kategori NetworkAutomation.');
    }
  }
}

// Kelas Abstrak Karyawan dan Subkelas
abstract class Karyawan {
  String nama;
  int umur;

  Karyawan(this.nama, this.umur);

  void bekerja();
}

class KaryawanTetap extends Karyawan {
  KaryawanTetap(String nama, int umur) : super(nama, umur);

  @override
  void bekerja() {
    print('$nama adalah karyawan tetap, bekerja penuh waktu.');
  }
}

class KaryawanKontrak extends Karyawan {
  KaryawanKontrak(String nama, int umur) : super(nama, umur);

  @override
  void bekerja() {
    print('$nama adalah karyawan kontrak, bekerja sesuai kontrak proyek.');
  }
}

// Positional dan Named Arguments untuk KaryawanBaru
class KaryawanBaru {
  String nama;
  int umur;
  String peran;

  KaryawanBaru(this.nama, {required this.umur, required this.peran});
}

// Mixin Kinerja untuk Produktivitas
mixin Kinerja {
  int produktivitas = 0;

  void tingkatkanProduktivitas() {
    produktivitas += 1;
    print('Produktivitas naik: $produktivitas');
  }
}

class Manager extends Karyawan with Kinerja {
  Manager(String nama, int umur) : super(nama, umur);

  @override
  void bekerja() {
    print('$nama bekerja sebagai Manager.');
  }

  void cekProduktivitas() {
    if (produktivitas < 85) {
      print('$nama produktivitas kurang dari 85, perlu ditingkatkan.');
    } else {
      print('$nama produktivitas sudah memenuhi standar.');
    }
  }
}

// Enum FaseProyek untuk Konsistensi Proyek
enum FaseProyek { Perencanaan, Pengembangan, Evaluasi }

class Proyek {
  FaseProyek faseSaatIni;

  Proyek(this.faseSaatIni);

  void transisiKeFase(FaseProyek faseTujuan) {
    if (faseSaatIni == FaseProyek.Perencanaan && faseTujuan == FaseProyek.Pengembangan) {
      faseSaatIni = faseTujuan;
      print('Proyek telah bertransisi ke fase Pengembangan.');
    } else if (faseSaatIni == FaseProyek.Pengembangan && faseTujuan == FaseProyek.Evaluasi) {
      faseSaatIni = faseTujuan;
      print('Proyek telah bertransisi ke fase Evaluasi.');
    } else {
      print('Transisi ke fase $faseTujuan tidak valid dari fase $faseSaatIni.');
    }
  }
}

// Mekanisme Pembatasan Jumlah Karyawan Aktif di Perusahaan
class Perusahaan {
  List<Karyawan> karyawanAktif = [];
  List<Karyawan> karyawanNonAktif = [];
  final int batasKaryawanAktif = 20;

  void tambahKaryawan(Karyawan karyawan) {
    if (karyawanAktif.length < batasKaryawanAktif) {
      karyawanAktif.add(karyawan);
      print('Karyawan ${karyawan.nama} ditambahkan ke daftar karyawan aktif.');
    } else {
      print('Tidak dapat menambahkan karyawan ${karyawan.nama}. Batas karyawan aktif tercapai.');
    }
  }

  void karyawanResign(Karyawan karyawan) {
    if (karyawanAktif.contains(karyawan)) {
      karyawanAktif.remove(karyawan);
      karyawanNonAktif.add(karyawan);
      print('Karyawan ${karyawan.nama} telah resign dan statusnya menjadi non-aktif.');
    } else {
      print('Karyawan ${karyawan.nama} tidak ditemukan dalam daftar karyawan aktif.');
    }
  }

  void tampilkanKaryawanAktif() {
    print("Daftar Karyawan Aktif:");
    for (var k in karyawanAktif) {
      print("- ${k.nama}");
    }
  }
}

void main() {
  // Buat ProdukDigital
  var produk1 = ProdukDigital('Automation Software', 1000000, 'NetworkAutomation');
  var produk2 = ProdukDigital('Website Builder', 500000, 'WebDevelopment');

  // Terapkan diskon ke produk
  produk1.terapkanDiskon(10);
  produk2.terapkanDiskon(10);

  // Buat Karyawan Tetap dan Kontrak
  var karyawanTetap = KaryawanTetap('erna', 30);
  var karyawanKontrak = KaryawanKontrak('Hendra', 27);

  // Coba buat Manager dengan mixin Kinerja
  var manager = Manager('rini', 40);
  manager.tingkatkanProduktivitas();
  manager.cekProduktivitas();

  // Coba Positional dan Named Arguments
  var karyawanBaru = KaryawanBaru('Dewi', umur: 28, peran: 'Developer');
  print('Nama: ${karyawanBaru.nama}, Umur: ${karyawanBaru.umur}, Peran: ${karyawanBaru.peran}');

  // Buat proyek dan transisi antar fase
  var proyek = Proyek(FaseProyek.Perencanaan);
  proyek.transisiKeFase(FaseProyek.Pengembangan);
  proyek.transisiKeFase(FaseProyek.Evaluasi);

  // Inisialisasi perusahaan dan tambahkan karyawan
  var perusahaan = Perusahaan();
  perusahaan.tambahKaryawan(karyawanTetap);
  perusahaan.tambahKaryawan(karyawanKontrak);
  perusahaan.tambahKaryawan(manager);

  // Menampilkan karyawan aktif
  perusahaan.tampilkanKaryawanAktif();

  // Karyawan resign
  perusahaan.karyawanResign(karyawanKontrak);
  perusahaan.tampilkanKaryawanAktif();
}