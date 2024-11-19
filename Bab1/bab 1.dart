import 'dart:async';

// Model Data
class User {
  String name;
  int age;
  late List<Product>? products;
  Role? role;

  User(this.name, this.age);
}

class Product {
  String productName;
  double price;
  bool inStock;

  Product(this.productName, this.price, this.inStock);
}

// Enum Role
enum Role { Admin, Customer }

// OOP & Inheritance
class AdminUser extends User {
  AdminUser(String name, int age) : super(name, age) {
    role = Role.Admin;
    products = [];
  }

  void addProduct(Product product) {
    try {
      if (!product.inStock) {
        throw Exception('Produk ${product.productName} tidak tersedia dalam stok.');
      }
      products!.add(product);
      print('Produk ${product.productName} berhasil ditambahkan.');
    } on Exception catch (e) {
      print('Terjadi kesalahan: $e');
    }
  }

  void removeProduct(Product product) {
    if (products!.contains(product)) {
      products!.remove(product);
      print('Produk ${product.productName} berhasil dihapus.');
    } else {
      print('Produk ${product.productName} tidak ditemukan di daftar.');
    }
  }
}

class CustomerUser extends User {
  CustomerUser(String name, int age) : super(name, age) {
    role = Role.Customer;
    products = [];
  }

  void viewProducts() {
    if (products != null && products!.isNotEmpty) {
      print('Daftar produk untuk ${name}:');
      for (var product in products!) {
        print('Produk: ${product.productName}, Harga: ${product.price}');
      }
    } else {
      print('Tidak ada produk untuk dilihat.');
    }
  }
}

// Asynchronous Programming
Future<void> fetchProductDetails(String productName) async {
  print('Mengambil detail produk $productName...');
  await Future.delayed(Duration(seconds: 2)); // Simulasi penundaan
  print('Detail produk $productName berhasil diambil.');
}

void main() async {
  // Collections: Menggunakan Map dan Set
  Map<String, Product> productCatalog = {
    'Laptop': Product('Laptop', 15000.0, true),
    'Smartphone': Product('Smartphone', 5000.0, false),
  };

  Set<Product> uniqueProducts = {};

  // Membuat pengguna admin dan customer
  AdminUser admin = AdminUser('Putri', 30);
  CustomerUser customer = CustomerUser('iki', 25);

  // Menambahkan produk ke dalam daftar admin
  var laptop = productCatalog['Laptop']!;
  var smartphone = productCatalog['Smartphone']!;

  admin.addProduct(laptop);
  admin.addProduct(smartphone); // Ini akan gagal karena produk tidak tersedia dalam stok

  // Menampilkan produk untuk customer
  customer.products = admin.products;
  customer.viewProducts();

  // Mengambil detail produk secara asynchronous
  await fetchProductDetails('Laptop');

  // Menambahkan produk ke dalam Set untuk memastikan unik
  uniqueProducts.add(laptop);
  uniqueProducts.add(smartphone);
  uniqueProducts.add(laptop); // tidak akan ditambahkan karena sudah ada

  print('Total produk unik: ${uniqueProducts.length}');
}