//Desainer-Coder-Tester -- Hengky Surya Angkasa/16518196 (16 April 2019)

const 
 NMax = 100;
 
type jam = record
           DD : integer;
		   MM : integer;
		   YYYY : integer;
		   end;
		   
    history_pinjam = record 
           Username : string;
           ID_Buku : integer;
		   Tanggal_Peminjaman : jam;
		   Tanggal_Batas_Pengembalian : jam;
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
		   
	TabHistory = array [1..NMax] of history_pinjam;
	
    TabBuku = array [1..NMax] of buku;
	
var 
 i : integer;
 H : TabHistory;
 B : TabBuku;

procedure Riwayat (H : TabHistory ; B : TabBuku ); 

var 
 U : string;
 i : integer;

begin
 // Input
 write('Masukkan username pengunjung: ');
 readln(U);
 writeln('Riwayat: ');
 
 // Menuliskan riwayat pinjam buku user sesuai ketentuan -- menggunakan pengulangan untuk menampilkan data
 for i:=1 to NMax do 
 begin 
  if (H[i].Username = U) then 
  begin 
   writeln(' | ',H[i].ID_Buku,' | ',B[i].Judul_Buku)
  end;
 end;
 
end;
 
begin
  // Input Array  
 for i:=1 to 15 do
 begin 
  readln(H[i].Username);
  readln(H[i].ID_Buku);
 end;
 
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
 
 Riwayat(H,B);
end.