//Desainer-Coder-Tester -- Hengky Surya Angkasa/16518196 (16 April 2019)

const
 NMax = 100;

type user = record 
	       Nama : string;
		   Username : string;
		   Password : string;
		   Role : string;
		   end;

    buku = record 
           ID_Buku : integer;
		   Judul_Buku : string;
		   Author : string;
		   Jumlah_Buku : integer;
		   Tahun_Penerbit : integer;
		   Kategori : string;
		   end;
 
    TabBuku = array [1..NMax] of buku;
	
    TabUser = array [1..NMax] of user;

 var
 T : TabBuku;
 U : TabUser;
 i : integer;
 
procedure Statistik (U : TabUser;  B : TabBuku);

var 
  i,admin,pengunjung,sastra,sains,manga,sejarah,programming : integer;

begin
 // menggunakan pengulangan untuk menghitung jumlah data
 admin := 0; pengunjung := 0;
 for i:=1 to NMax do 
 begin 
  if (U[i].Role = 'admin') then 
  begin 
   admin := admin + 1;
  end else if (U[i].Role = 'pengunjung') then 
  begin 
   pengunjung := pengunjung + 1;
  end;
 end;
 
 // menggunakan pengulangan untuk menghitung jumlah data
 sastra := 0; sains := 0; manga := 0; sejarah := 0; programming := 0; 
 for i:=1 to NMax do  // menggunakan pengulangan untuk menghitung jumlah data
 begin 
  if (B[i].Kategori = 'sastra') then 
  begin 
   sastra := sastra + (B[i].Jumlah_Buku);
  end else if (B[i].Kategori = 'sains') then 
  begin 
   sains := sains + (B[i].Jumlah_Buku);
  end else if (B[i].Kategori = 'manga') then 
  begin 
   manga := manga + (B[i].Jumlah_Buku);
  end else if (B[i].Kategori = 'sejarah') then 
  begin 
   sejarah := sejarah + (B[i].Jumlah_Buku);
  end else if (B[i].Kategori = 'programming') then 
  begin 
   programming := programming + (B[i].Jumlah_Buku);
  end;
 end; 

 writeln('Pengguna: ');
 writeln('Admin | ',admin);
 writeln('Pengunjung | ',pengunjung);
 writeln('Total | ',(admin+pengunjung));
 writeln('Buku: ');
 writeln('Sastra | ',sastra);
 writeln('Sains | ',sains);
 writeln('Manga | ',manga);
 writeln('Sejarah | ',sejarah);
 writeln('Programming | ',programming);
 writeln('Total | ',(sastra+sains+manga+sejarah+programming));

end; 

begin 
 // Input Array  
 for i:=1 to 15 do
 begin 
  readln(T[i].ID_Buku);
  readln(T[i].Judul_Buku);
  readln(T[i].Author);
  readln(T[i].Jumlah_Buku);
  readln(T[i].Tahun_Penerbit);
  readln(T[i].Kategori);
 end;
 
 for i:=1 to 2 do
 begin 
  readln(U[i].Role);
 end;
 
 Statistik(U,T);
end.