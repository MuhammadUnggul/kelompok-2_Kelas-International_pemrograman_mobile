// ============================================================
// Program Perhitungan Belanjaan dengan Diskon (Dart)
// ------------------------------------------------------------
// Menggunakan:
// - Built-in type: Map, List, String, int, double
// - Function
// - if / else if / else
// - Operator comparison (>, >=, <, ==, dst)
// ============================================================

void main() {
  // ----------------------------------------------------------
  // Contoh penggunaan
  // ----------------------------------------------------------
  List<Map<String, dynamic>> inputBelanja = [
    {"nama": "beras", "jumlah": 2},
    {"nama": "gula", "jumlah": 3},
    {"nama": "minyak", "jumlah": 1},
    {"nama": "telur", "jumlah": 4},
    {"nama": "sabun", "jumlah": 2}, // tidak ada di daftar harga -> dilewati
  ];

  List<Map<String, dynamic>> belanjaan = buatBelanjaan(inputBelanja);
  tampilkanTotal(belanjaan);
}

// ============================================================
// 1. DAFTAR HARGA (built-in type: Map)
// ============================================================
Map<String, int> daftarHarga = {
  "beras": 65000,
  "gula": 15000,
  "minyak": 32000,
  "telur": 30000,
  "susu": 20000,
  "kopi": 25000,
};

// ============================================================
// 2. FUNCTION: Membuat daftar belanjaan yang valid
//    items: List of Map -> [{"nama": ..., "jumlah": ...}, ...]
// ============================================================
List<Map<String, dynamic>> buatBelanjaan(List<Map<String, dynamic>> items) {
  List<Map<String, dynamic>> belanjaan = [];

  for (var item in items) {
    String nama = item["nama"];
    int jumlah = item["jumlah"];

    if (daftarHarga.containsKey(nama) && jumlah > 0) {
      belanjaan.add({"nama": nama, "jumlah": jumlah});
    } else {
      print("[!] '$nama' dilewati (tidak ada di daftar harga atau jumlah tidak valid)");
    }
  }

  return belanjaan;
}

// ============================================================
// 3. FUNCTION: Menghitung subtotal belanjaan
// ============================================================
int hitungSubtotal(List<Map<String, dynamic>> belanjaan) {
  int subtotal = 0;

  for (var item in belanjaan) {
    String nama = item["nama"];
    int jumlah = item["jumlah"];
    int hargaSatuan = daftarHarga[nama]!;
    subtotal += hargaSatuan * jumlah;
  }

  return subtotal;
}

// ============================================================
// 4. FUNCTION: Menentukan diskon berdasarkan case belanjaan
//    - Menggunakan if / else if / else + operator comparison
// ============================================================
int hitungDiskon(int subtotal, int jumlahItem) {
  int persenDiskon;

  // Aturan diskon berdasarkan nominal belanja
  if (subtotal >= 500000) {
    persenDiskon = 20;
  } else if (subtotal >= 200000) {
    persenDiskon = 10;
  } else if (subtotal >= 100000) {
    persenDiskon = 5;
  } else {
    persenDiskon = 0;
  }

  // Case tambahan: beli banyak jenis/qty item
  if (jumlahItem >= 10) {
    persenDiskon += 5;
  }

  // Batas maksimal diskon
  if (persenDiskon > 30) {
    persenDiskon = 30;
  }

  return persenDiskon;
}

// ============================================================
// 5. FUNCTION: Menampilkan total akhir belanjaan
// ============================================================
double tampilkanTotal(List<Map<String, dynamic>> belanjaan) {
  print("=" * 40);
  print("STRUK BELANJA");
  print("=" * 40);

  int totalQty = 0;

  for (var item in belanjaan) {
    String nama = item["nama"];
    int jumlah = item["jumlah"];
    int hargaSatuan = daftarHarga[nama]!;
    int totalHarga = hargaSatuan * jumlah;
    totalQty += jumlah;

    String namaTampil = nama[0].toUpperCase() + nama.substring(1);
    print(
      "$namaTampil".padRight(10) +
      " x$jumlah".padRight(6) +
      "@Rp${formatRupiah(hargaSatuan)} = Rp${formatRupiah(totalHarga)}",
    );
  }

  int subtotal = hitungSubtotal(belanjaan);
  int persenDiskon = hitungDiskon(subtotal, totalQty);
  double nominalDiskon = subtotal * persenDiskon / 100;
  double totalAkhir = subtotal - nominalDiskon;

  print("-" * 40);
  print("Subtotal      : Rp${formatRupiah(subtotal)}");

  if (persenDiskon == 0) {
    print("Diskon        : Tidak ada");
  } else if (persenDiskon < 10) {
    print("Diskon        : $persenDiskon% (diskon kecil) -Rp${formatRupiah(nominalDiskon.round())}");
  } else {
    print("Diskon        : $persenDiskon% (diskon besar) -Rp${formatRupiah(nominalDiskon.round())}");
  }

  print("=" * 40);
  print("TOTAL AKHIR   : Rp${formatRupiah(totalAkhir.round())}");
  print("=" * 40);

  return totalAkhir;
}

// ============================================================
// HELPER: Format angka jadi format ribuan (contoh: 130000 -> 130.000)
// ============================================================
String formatRupiah(int angka) {
  String hasil = angka.toString();
  String reversed = hasil.split('').reversed.join('');
  List<String> bagian = [];

  for (int i = 0; i < reversed.length; i += 3) {
    int end = (i + 3 < reversed.length) ? i + 3 : reversed.length;
    bagian.add(reversed.substring(i, end));
  }

  return bagian.join('.').split('').reversed.join('');
}
