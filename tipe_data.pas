unit tipe_data;

interface

    type

        ttanggal = record	
            tanggal : integer;
            bulan : integer;
            tahun : integer;
            end;

        tuser = record
            nama : string;
            alamat : string;
            username : string;
            password : string;
            role : string;  
            end;

        peminjaman = record
            ID_Buku : integer;
            Username : string;
            Judul_Buku : string;
            Tanggal_Peminjaman : string;
            Tanggal_Batas_Peminjaman : string;
            Status_Pengembalian : boolean;
            end;

        buku = record
            ID_Buku : integer;
            Judul_Buku : string;
            Author : string;
            Jumlah_Buku : integer;
            Tahun_Penerbit : integer;
            Kategori : string;
            end;

        pengembalian = record
            Username : string;
            ID_Buku : integer;
            Tanggal_Pengembalian : string;
            end;  

        kehilangan = record
            Username : string;
            ID_Buku_Hilang : integer;
            Tanggal_Laporan : string;
            end;

        tabUser = record		
            T : array[1..1000] of tuser;
            Neff : integer; (*Nilai Efektif array*)
            end;

        tabBuku = record
            T : array [1..1000] of buku;
            Neff : integer; (*Nilai efektif array*)
            end;

        tabPinjam = record
            T : array [1..1000] of peminjaman;
            Neff : integer; (*Nilai efektif array*)
            end;

        tabKembali = record		
            T : array [1..1000] of pengembalian;
            Neff : integer; (*Nilai efektif array*)
            end;

        tabHilang = record
            T : array [1..1000] of kehilangan;
            Neff : integer; (*Nilai efektif array*)
            end;

implementation

end.

