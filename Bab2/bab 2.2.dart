// Enum untuk tipe buku
enum BookType { Fiction, NonFiction }

// Abstract class untuk representasi umum buku
abstract class Book {
  String title;
  String author;
  int year;
  BookType type;

  Book(this.title, this.author, this.year, this.type);

  void read();
  void info();

  // Getter untuk menghitung usia buku
  int get age => DateTime.now().year - year;
}

// Mixin untuk kelas buku yang dapat diperbarui statusnya
mixin Updatable {
  void updateStatus() {
    print("Status buku telah diperbarui.");
  }
}

// Class FictionBook yang merupakan turunan dari Book
class FictionBook extends Book with Updatable {
  String genre;

  // Constructor dengan positional argument untuk genre dan named argument untuk atribut lainnya
  FictionBook(this.genre, {required String title, required String author, required int year})
      : super(title, author, year, BookType.Fiction);

  // Implementasi method read dan info
  @override
  void read() {
    print("Membaca buku fiksi berjudul '$title'.");
  }

  @override
  void info() {
    print("Buku Fiksi: '$title' oleh $author, genre: $genre, diterbitkan pada tahun $year.");
  }
}

// Class NonFictionBook yang merupakan turunan dari Book
class NonFictionBook extends Book {
  String subject;

  // Constructor dengan positional argument untuk subject dan named argument untuk atribut lainnya
  NonFictionBook(this.subject, {required String title, required String author, required int year})
      : super(title, author, year, BookType.NonFiction);

  // Implementasi method read dan info
  @override
  void read() {
    print("Membaca buku non-fiksi berjudul '$title'.");
  }

  @override
  void info() {
    print("Buku Non-Fiksi: '$title' oleh $author, subjek: $subject, diterbitkan pada tahun $year.");
  }
}

// Class LibraryUser untuk mewakili pengguna perpustakaan
class LibraryUser {
  String name;
  int age;

  LibraryUser({required this.name, required this.age});

  void borrowBook(Book book) {
    print("$name meminjam buku berjudul '${book.title}'.");
  }
}

// Class LibraryAdmin yang merupakan turunan dari LibraryUser
class LibraryAdmin extends LibraryUser {
  LibraryAdmin({required String name, required int age}) : super(name: name, age: age);

  void manageBook(Book book) {
    print("$name mengelola buku '${book.title}' di perpustakaan.");
  }
}

void main() {
  // Membuat instance dari FictionBook
  FictionBook fictionBook = FictionBook("Fantasy", title: "Harry Potter", author: "J.K. Rowling", year: 1997);
  fictionBook.info();
  fictionBook.read();

  // Memanfaatkan mixin Updatable
  fictionBook.updateStatus();

  // Membuat instance dari NonFictionBook
  NonFictionBook nonFictionBook = NonFictionBook("Science", title: "A Brief History of Time", author: "Stephen Hawking", year: 1988);
  nonFictionBook.info();
  nonFictionBook.read();

  // Membuat instance dari LibraryUser dan LibraryAdmin
  LibraryUser user = LibraryUser(name: "Alice", age: 25);
  user.borrowBook(fictionBook);

  LibraryAdmin admin = LibraryAdmin(name: "Bob", age: 40);
  admin.manageBook(nonFictionBook);

  // Menampilkan usia buku dengan menggunakan getter
  print("Usia buku '${fictionBook.title}': ${fictionBook.age} tahun");
  print("Usia buku '${nonFictionBook.title}': ${nonFictionBook.age} tahun");
}