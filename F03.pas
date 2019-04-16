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
 B : array [1..NMax] of buku;
 i : integer;
 
procedure CetakKategori(B : TabBuku);

var 
  i,buku_ada : integer;
  stop : boolean;
  K : string;
  
 // Skema Validasi II 

begin
  stop := false; 
 repeat
  write('Masukkan kategori: ');
  readln(K);
  if ((K ='sastra') or (K ='sains') or (K ='manga') or (K ='sejarah') or (K ='programming')) then
  begin
   stop := true;
  end else
  begin
   writeln('Kategori ',K,' tidak valid.');
  end;
 until(stop);
 
 // Mencari berdasarkan kategori buku 
 writeln();
 writeln('Hasil pencarian: ');
 buku_ada := 0;
 for i:=1 to NMax do // jika buku tidak kosong then 
 begin 
  if (B[i].Jumlah_Buku <> 0) and (B[i].Kategori = K) then 
  begin 
   buku_ada := buku_ada + 1;
   write(B[i].ID_Buku,' | ');
   write(B[i].Judul_Buku,' | ');
   writeln(B[i].Author); // select dan write data yang ada di csv. Sesuai ketentuan ID Buku | Judul | Penulis
  end;
 end;
 // Kasus buku kosong 
 if (buku_ada = 0) then  
 begin
  writeln('Tidak ada buku dalam kategori ini'); 
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
  readln(B[i].Kategori);
 end;
 
 CetakKategori(B)

end. 