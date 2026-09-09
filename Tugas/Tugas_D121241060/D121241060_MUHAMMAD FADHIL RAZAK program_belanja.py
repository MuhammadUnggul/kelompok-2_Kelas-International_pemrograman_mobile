"""
Program Perhitungan Belanjaan dengan Diskon
--------------------------------------------
Menggunakan:
- Built-in type: dict, list, tuple, int, float, str
- Function
- if / elif / else
- Operator comparison (>, >=, <, ==, dst)
"""

# ============================================================
# 1. DAFTAR HARGA (built-in type: dict)
# ============================================================
daftar_harga = {
    "beras": 65000,
    "gula": 15000,
    "minyak": 32000,
    "telur": 30000,
    "susu": 20000,
    "kopi": 25000,
}


# ============================================================
# 2. FUNCTION: Menambahkan daftar belanjaan (built-in type: list of tuple)
# ============================================================
def buat_belanjaan(items):
    """
    items: list of tuple -> [(nama_barang, jumlah), ...]
    Mengembalikan list belanjaan yang valid saja
    (barang yang ada di daftar_harga).
    """
    belanjaan = []
    for nama, jumlah in items:
        if nama in daftar_harga and jumlah > 0:
            belanjaan.append((nama, jumlah))
        else:
            print(f"[!] '{nama}' dilewati (tidak ada di daftar harga atau jumlah tidak valid)")
    return belanjaan


# ============================================================
# 3. FUNCTION: Menghitung subtotal belanjaan
# ============================================================
def hitung_subtotal(belanjaan):
    subtotal = 0
    for nama, jumlah in belanjaan:
        harga_satuan = daftar_harga[nama]
        subtotal += harga_satuan * jumlah
    return subtotal


# ============================================================
# 4. FUNCTION: Menentukan diskon berdasarkan case belanjaan
#    - Menggunakan if / elif / else + operator comparison
# ============================================================
def hitung_diskon(subtotal, jumlah_item):
    """
    Aturan diskon:
    - Belanja >= 500.000        -> diskon 20%
    - Belanja >= 200.000        -> diskon 10%
    - Belanja >= 100.000        -> diskon 5%
    - Jumlah item >= 10 (walau nominal kecil) -> diskon tambahan 5%
    - Selain itu -> tidak ada diskon
    """
    if subtotal >= 500000:
        persen_diskon = 20
    elif subtotal >= 200000:
        persen_diskon = 10
    elif subtotal >= 100000:
        persen_diskon = 5
    else:
        persen_diskon = 0

    # Case tambahan: beli banyak jenis/qty item
    if jumlah_item >= 10:
        persen_diskon += 5

    # Batas maksimal diskon
    if persen_diskon > 30:
        persen_diskon = 30

    return persen_diskon


# ============================================================
# 5. FUNCTION: Menampilkan total akhir belanjaan
# ============================================================
def tampilkan_total(belanjaan):
    print("=" * 40)
    print("STRUK BELANJA")
    print("=" * 40)

    total_qty = 0
    for nama, jumlah in belanjaan:
        harga_satuan = daftar_harga[nama]
        total_harga = harga_satuan * jumlah
        total_qty += jumlah
        print(f"{nama.capitalize():<10} x{jumlah:<3} @Rp{harga_satuan:,} = Rp{total_harga:,}")

    subtotal = hitung_subtotal(belanjaan)
    persen_diskon = hitung_diskon(subtotal, total_qty)
    nominal_diskon = subtotal * persen_diskon / 100
    total_akhir = subtotal - nominal_diskon

    print("-" * 40)
    print(f"Subtotal      : Rp{subtotal:,.0f}")

    if persen_diskon == 0:
        print("Diskon        : Tidak ada")
    elif persen_diskon < 10:
        print(f"Diskon        : {persen_diskon}% (diskon kecil) -Rp{nominal_diskon:,.0f}")
    else:
        print(f"Diskon        : {persen_diskon}% (diskon besar) -Rp{nominal_diskon:,.0f}")

    print("=" * 40)
    print(f"TOTAL AKHIR   : Rp{total_akhir:,.0f}")
    print("=" * 40)

    return total_akhir


# ============================================================
# CONTOH PENGGUNAAN
# ============================================================
if __name__ == "__main__":
    input_belanja = [
        ("beras", 2),
        ("gula", 3),
        ("minyak", 1),
        ("telur", 4),
        ("sabun", 2),   # tidak ada di daftar harga -> dilewati
    ]

    belanjaan = buat_belanjaan(input_belanja)
    tampilkan_total(belanjaan)
