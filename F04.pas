//Desainer-Coder-Tester -- Hengky Surya Angkasa/16518196 (16 April 2019)

const 
 NMax = 100;
 
type buku = record 
           ID_Buku : integer;
		   Judul_Buku : string;
		   Author : string;
		   Jumlah_Buku : integer;
		   Tahun_Penerbit : integer;
		   Kategori : string;
		   end;
		  
     TabBuku = array [1..NMax] of buku;
	 
var 
 B : TabBuku;
 i : integer;
 
procedure Cetak (T : TabBuku ; i : integer); // prosedur untuk mencetak info buku sesuai ketentuan

begin
 write(T[i].ID_Buku,' | ');
 write(T[i].Judul_Buku,' | ');
 writeln(T[i].Author);
end;
 

procedure CetakDariTahun (B : TabBuku);

var 
 T : integer; // T adalah tahun buku
 K : string; // K adalah kategori pencarian {=,>,<,>=,<=}
 i,buku_ada : integer;
 
begin 
 // Input
 write('Masukkan tahun: ');
 readln(T);
 write('Masukkan kategori: ');
 readln(K);
 writeln();
 
 // Mencari berdasarkan kategori {=,>,<,>=,<=} tahun tahun terbit buku
 writeln('Buku yang terbit ',K,' ',T,':');
 buku_ada := 0; // flag digunakan untuk proses pengecekan, buku ada sesuai dengan input pengguna atau tidak
 for i:=1 to NMax do // jika buku tidak kosong then 
 begin 
  if (K = '=') and (B[i].Tahun_Penerbit = T) then 
  begin 
   Cetak(B,i);   // select dan write data yang ada di csv. Sesuai ketentuan ID Buku | Judul | Penulis
   buku_ada := buku_ada + 1;
  end else if (K='>=') and (B[i].Tahun_Penerbit >= T) then 
  begin
   Cetak(B,i);
   buku_ada := buku_ada + 1;
  end else if (K='>') and (B[i].Tahun_Penerbit > T) then
  begin 
   Cetak(B,i);
   buku_ada := buku_ada + 1;
  end else if (K='<=') and (B[i].Tahun_Penerbit <= T) then
  begin 
   Cetak(B,i);
   buku_ada := buku_ada + 1;
  end else if (K='<') and (B[i].Tahun_Penerbit < T) then
  begin 
   Cetak(B,i);
   buku_ada := buku_ada + 1;
  end else 
  begin 
   buku_ada := buku_ada + 0;
  end;
 end;
 
 // Kasus buku tidak ada
 if (buku_ada = 0) then  
 begin
  writeln('Tidak ada buku dalam kategori ini.');
 end;
end;

begin 
 // Input Array  
 for i:=1 to 15 do
 begin 
  readln(B[i].ID_Buku);
  readln(B[i].Judul_Buku);
  readln(B[i].Author);
  readln(B[i].Jumlah_Buku);
  readln(B[i].Tahun_Penerbit);
  readln(B[i].Kategori);
 end;
 CetakDariTahun(B);
end.
