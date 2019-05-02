unit proses_buku;

interface

    uses tipe_data, konversi;

    procedure CetakKategori(var B : tabBuku);
    // prosedur untuk mencetak buku berdasarkan kategori

    procedure Cetak (var B : tabBuku ; i : integer); 
    // prosedur untuk mencetak info buku sesuai ketentuan

    procedure CetakDariTahun (var B : tabBuku);
    //procedure untuk mencetak buku berdasarkan ketentuan tahun 

    procedure pinjam_buku (var tb : tabBuku; var tp : tabPinjam; var active_user: tuser; var isSave: boolean) ;
	{Meminjam buku yang ada, data di-update ke tabPinjam}

    procedure kembalikan_buku (var tb: tabBuku ; var tp: tabPinjam ; var tk: tabKembali ; var active_user : tuser; var isSave : Boolean ) ;
    {Mengembalikan buku yang telah dipinjam, di-update ke data peminjaman}

    function FoundBookIdIdx (var Id : integer; var ArrBook : tabBuku): integer;
    {Mencari indeks buku dengan id tertentu, asumsi id terdaftar}

    procedure SortArrBook (var ArrBook : tabBuku );
    {Mengurutkan Array Daftar Buku}

    procedure AddJumlahBuku (var array_buku : tabBuku; var active_user : tuser; var isSave : boolean);
    {Menambahkan jumlah buku}

    procedure AddBook (var array_buku : tabBuku; var active_user : tuser; var isSave : boolean);
    {Menambahkan buku baru}

    procedure SeeLost (var array_hilang : tabHilang; var active_user : tuser);
    {Prosedur untuk melihat data buku yang hilang}

    procedure RegLost (var array_hilang : tabHilang; var isSave : boolean);
    {Prosedur untuk melaporkan buku yang hilang}  

implementation

    procedure CetakKategori(var B : TabBuku);
    (*Kamus Lokal*)
    var 
        i,buku_ada : integer;
        stop : boolean;
        K : string;
    // Skema Validasi II 
    (*Algoritma*)
    begin
        writeln('');
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
        for i:=1 to B.Neff do // jika buku tidak kosong then 
        begin 
            if (B.T[i].Jumlah_Buku <> 0) and (B.T[i].Kategori = K) then 
            begin 
                buku_ada := buku_ada + 1;
                write(B.T[i].ID_Buku,' | ');
                write(B.T[i].Judul_Buku,' | ');
                writeln(B.T[i].Author); // select dan write data yang ada di csv. Sesuai ketentuan ID Buku | Judul | Penulis
            end;
        end;
    
        // Kasus buku kosong 
        if (buku_ada = 0) then  
        begin
            writeln('Tidak ada buku dalam kategori ini'); 
        end;

        writeln('');
    end;


    procedure Cetak (var B : TabBuku ; i : integer); // prosedur untuk mencetak info buku sesuai ketentuan
    (*Algoritma*)
    begin
        write(B.T[i].ID_Buku,' | ');
        write(B.T[i].Judul_Buku,' | ');
        writeln(B.T[i].Author);
    end;


    procedure CetakDariTahun (var B : TabBuku);
    (*Kamus Lokal*)
    var 
        T : integer; // T adalah tahun buku
        K : string; // K adalah kategori pencarian {=,>,<,>=,<=}
        i,buku_ada : integer;
    (*Algoritma*)
    begin 
        // Input
        writeln('');
        write('Masukkan tahun: ');
        readln(T);
        write('Masukkan kategori (< > = <= >=): ');
        readln(K);
        writeln();
    
        // Mencari berdasarkan kategori {=,>,<,>=,<=} tahun tahun terbit buku
        writeln('Buku yang terbit ',K,' ',T,':');
        buku_ada := 0; // flag digunakan untuk proses pengecekan, buku ada sesuai dengan input pengguna atau tidak
        for i:=1 to B.Neff do // jika buku tidak kosong then 
        begin 
            if (K = '=') and (B.T[i].Tahun_Penerbit = T) then 
            begin 
                Cetak(B,i);   // select dan write data yang ada di csv. Sesuai ketentuan ID Buku | Judul | Penulis
                buku_ada := buku_ada + 1;
            end else if (K='>=') and (B.T[i].Tahun_Penerbit >= T) then 
            begin
                Cetak(B,i);
                buku_ada := buku_ada + 1;
            end else if (K='>') and (B.T[i].Tahun_Penerbit > T) then
            begin 
                Cetak(B,i);
                buku_ada := buku_ada + 1;
            end else if (K='<=') and (B.T[i].Tahun_Penerbit <= T) then
            begin 
                Cetak(B,i);
                buku_ada := buku_ada + 1;
            end else if (K='<') and (B.T[i].Tahun_Penerbit < T) then
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

        writeln('');
    end;


    procedure pinjam_buku (var tb : tabBuku; var tp : tabPinjam; var active_user: tuser; var isSave: boolean) ;
	{Meminjam buku yang ada, data di-update ke tabPinjam}

    {Kamus Lokal}
	var
		id : integer; {ID buku yang ingin dipinjam} 
        i: integer; {untuk Looping}
		tanggal : string;
		found : boolean; {untuk skema pencarian}
	(*Algoritma*)
	begin

        if(active_user.role = 'admin') then begin

            writeln('');
            writeln('Hanya untuk pengunjung!');
            writeln('');

        end else begin

            writeln('');
            write('Masukkan id buku yang ingin dipinjam: ') ; readln(id);
            write('Masukkan tanggal hari ini: ') ; readln(tanggal); (* Masukan dd/mm/yyyy *)
            
            i := 1; found := false;
            while( i <= tb.Neff ) and (not found) do
            begin
                
                (*Asumsi masukan valid*)
                if tb.t[i].ID_Buku = id then
                begin
                    if tb.t[i].Jumlah_Buku > 0 then
                    begin

                        tp.Neff := tp.Neff + 1;
                        tp.t[tp.Neff].ID_Buku:= id;
                        tp.t[tp.Neff].Judul_Buku:= tb.t[i].Judul_Buku;
                        tp.t[tp.Neff].Username:= active_user.Username;
                        tp.t[tp.Neff].Tanggal_Peminjaman:= tanggal;
                        tp.t[tp.Neff].Tanggal_Batas_Peminjaman:= tanggalToString( batas(stringToTanggal(tanggal) , 7));
                        {Batas peminjaman = 7 hari}
                        tp.t[tp.Neff].Status_Pengembalian:= false;
                        
                        
                        writeln('Buku ' , tb.t[i].Judul_Buku , ' berhasil dipinjam!');
                        writeln('Tersisa ', tb.t[i].Jumlah_Buku - 1 , ' Buku ', tb.t[i].Judul_Buku );
                        writeln('Terima kasih sudah meminjam!');
                        writeln('');
                        
                        tb.t[i].Jumlah_Buku := tb.t[i].Jumlah_Buku - 1;

                    end else (*Buku habis*)
                    begin
                        
                        writeln('Buku ' , tb.t[i].Judul_Buku , ' sedang habis!');
                        writeln('Coba lain kali.');
                        writeln('');

                    end;
                    
                    found := true;

                end else
                begin
                    i := i + 1;
                end;
            
            end; 

            if (not found) then begin
                writeln('Maaf, buku tidak ditemukan!');
                writeln('');
            end;

            isSave := False;

        end;
    end;


    procedure kembalikan_buku (var tb: tabBuku ; var tp: tabPinjam ; var tk: tabKembali ; var active_user : tuser; var isSave : Boolean ) ;
    {Mengembalikan buku yang telah dipinjam, di-update ke data peminjaman}

    {Kamus Lokal}
	var
		id : integer; {ID buku yang ingin dikembalikan}
		i,j : integer ; {untuk Looping}
		tgl : string ;
		denda : Longint; {untuk menghitung denda keterlambatan}
    (*Algoritma*)
	begin

        if(active_user.role = 'admin') then begin
            writeln('');
            writeln('Hanya untuk pengunjung!');
            writeln('');
        end else begin
    

            writeln('');
            write('Masukkan id buku yang dikembalikan: '); readln(id);
            writeln('Data peminjaman:');
            for i:=1 to tp.Neff do
            begin
                
                if (( tp.t[i].ID_Buku = id ) and (tp.t[i].Username = active_user.username)) then
                begin
                    write('Username: '); writeln(tp.t[i].Username);
                    write('Judul buku: '); writeln(tp.t[i].Judul_Buku);
                    write('Tanggal peminjaman: '); writeln(tp.t[i].Tanggal_Peminjaman);
                    write('Tanggal batas pengembalian: '); writeln(tp.t[i].Tanggal_Batas_Peminjaman);

                    writeln();		
                    write('Masukkan tanggal hari ini: '); read(tgl); {Masukan valid dd/mm/yyyy}

                    tk.Neff := tk.Neff + 1;

                    tk.t[tk.Neff].Username:= tp.t[i].Username;
                    tk.t[tk.Neff].ID_Buku:= tp.t[i].ID_Buku;
                    tk.t[tk.Neff].Tanggal_Pengembalian:= tgl; 
                    tp.t[i].Status_Pengembalian:= true;
                    
                    for j:= 1 to tb.Neff do
                    begin
                        if (tb.t[j].ID_Buku = tp.t[i].ID_Buku) then begin
                            tb.t[j].Jumlah_Buku:= tb.t[j].Jumlah_Buku + 1; {Mengembalikan jumlah buku di tabBuku}
                        end; 
                    end;

                    if ( selisihHari(stringToTanggal(tgl),stringToTanggal(tp.t[i].Tanggal_Peminjaman)) <= 7 ) then
                    begin
                        writeln('Terima kasih sudah meminjam.');
                    end else {Menghitung denda}
                    begin
                        writeln('Anda terlambat mengembalikan buku.');
                        denda:= selisihHari( stringToTanggal(tgl) , stringToTanggal(tp.t[i].Tanggal_Batas_Peminjaman) ) * 2000 ;
                        writeln('Anda terkena denda ' , denda ,'.');
                        writeln('');
                    end;
                    
                end;
                
            end;
            isSave := False;
        end;

	end;


    function FoundBookIdIdx (var Id : integer; var ArrBook : tabBuku): integer;
    {Mencari indeks buku dengan id tertentu, asumsi id terdaftar}
    {KAMUS LOKAL}
    var
        i : integer;
        found : boolean;
    
    {ALGORITMA}
    begin
        i := 1;
        found := False;
        repeat
            begin
                if (ArrBook.T[i].ID_Buku = Id) then
                begin
                    found := True;
                end;
                i := i + 1;
            end;
        until ((found) or (i > ArrBook.Neff));
        FoundBookIdIdx := i-1;
    end;
    

    procedure SortArrBook (var ArrBook : tabBuku);
    {Mengurutkan Array Daftar Buku}
    {KAMUS LOKAL}
    var
        Check, i, j : integer;
        Temp : buku;
        stop : boolean;
    
    {ALGORITMA}
    begin
        for Check := 1 to ArrBook.Neff do
            begin
                Temp := ArrBook.T[Check];
            
                i := Check - 1;
                j := 1;
                stop := False;
            
                repeat         
                while (ord (ArrBook.T[i].Judul_Buku [j]) > ord (Temp.Judul_Buku [j])) and (i > 1) do
                    begin
                        ArrBook.T[i + 1] := ArrBook.T[i];
                        i := i - 1;
                end;
            
                if (ord (ArrBook.T[i].Judul_Buku [j]) < ord (Temp.Judul_Buku [j])) then
                    begin
                        ArrBook.T[i + 1] := Temp;
                        stop := True;
                    end
                else if (ord (ArrBook.T[i].Judul_Buku [j]) > ord (Temp.Judul_Buku [j])) then
                    begin
                        ArrBook.T[i + 1] := ArrBook.T[i];
                        ArrBook.T[i] := Temp;
                        stop := True;
                    end
                else
                    begin
                        j := j + 1;
                    end;
                until stop;
            end;
    end;


    procedure RegLost (var array_hilang : tabHilang; var isSave : Boolean);
    {Prosedur untuk melaporkan buku yang hilang}  
    {KAMUS LOKAL}
    var
        LB : kehilangan;
    
    {ALGORITMA}
    begin
        writeln('');
        write ('Masukkan id buku: ');
        readln (LB.ID_Buku_Hilang);
        write ('Masukkan judul buku: ');
        readln (LB.Username);
        write ('Masukkan tanggal pelaporan: ');
        readln (LB.Tanggal_Laporan);
        writeln ();
		
		array_hilang.Neff := array_hilang.Neff + 1;
        array_hilang.T[ array_hilang.Neff ].ID_Buku_Hilang := LB.ID_Buku_Hilang;
        array_hilang.T[ array_hilang.Neff ].Username := LB.Username;
        array_hilang.T[ array_hilang.Neff ].Tanggal_Laporan := LB.Tanggal_Laporan;
        writeln ('Laporan berhasil diterima');
        writeln('');

        isSave := False;
    end;

    
    procedure SeeLost (var array_hilang : tabHilang; var active_user : tuser);
    {Prosedur untuk melihat data buku yang hilang}
    {KAMUS LOKAL}
    var
        i : integer;
        
    {ALGORITMA}
    begin

        if(active_user.role = 'pengunjung') then begin

            writeln('');
            writeln('Fitur ini hanya dapat diakses oleh admin. Kontak admin terdekat.');
            writeln('')

        end else begin
                    
            writeln('');
            if array_hilang.Neff > 0 then
                begin 
                    writeln ('Buku yang hilang :');
                    for i := 1 to array_hilang.Neff do
                    begin
                        writeln (array_hilang.T[i].ID_Buku_Hilang, ' | ', array_hilang.T[i].Username, ' | ', array_hilang.T[i].Tanggal_Laporan);
                    end;
                end
            else
                begin
                    writeln ('Tidak ada buku hilang.')
                end;
            writeln('');
        
        end;
    end;

    
    procedure AddBook (var array_buku : tabBuku; var active_user : tuser; var isSave : boolean);
    {Menambahkan buku baru}
    {KAMUS LOKAL}
    var
        NB : buku; {New Book}
    
    {ALGORITMA}
    begin

        if(active_user.role = 'pengunjung') then begin

            writeln('');
            writeln('Fitur ini hanya dapat diakses oleh admin. Kontak admin terdekat.');
            writeln('');

        end else begin
                
            writeln('');
            writeln ('Masukkan informasi buku yang ditambahkan:');
            write ('Masukkan id buku: ');
            readln (NB.ID_Buku);
            write ('Masukkan judul buku: ');
            readln (NB.Judul_Buku);
            write ('Masukkan pengarang buku: ');
            readln (NB.Author);
            write ('Masukkan jumlah buku: ');
            readln (NB.Jumlah_Buku);
            write ('Masukkan tahun terbit buku: ');
            readln (NB.Tahun_Penerbit);
            write ('Masukkan kategori buku: ');
            readln (NB.kategori);
            writeln ();
            
            array_buku.Neff := array_buku.Neff + 1;
            array_buku.T[ array_buku.Neff ].ID_Buku := NB.ID_Buku;
            array_buku.T[ array_buku.Neff ].Judul_Buku := NB.Judul_Buku;
            array_buku.T[ array_buku.Neff ].Jumlah_Buku := NB.Jumlah_Buku;
            array_buku.T[ array_buku.Neff ].Author := NB.Author;
            array_buku.T[ array_buku.Neff ].Tahun_Penerbit := NB.Tahun_Penerbit;
            array_buku.T[ array_buku.Neff ].Kategori := NB.Kategori;
            writeln ('Buku berhasil ditambahkan ke dalam sistem');
            writeln ('');

            SortArrBook(array_buku);

            isSave := False;
        
        end;
    end;


    procedure AddJumlahBuku (var array_buku : tabBuku; var active_user : tuser; var isSave : boolean);
    {Menambahkan jumlah buku}
    {KAMUS LOKAL}
    var
        IdAdd, NAdd : integer;
        
    {ALGORITMA}
    begin

        if(active_user.role = 'pengunjung') then begin

            writeln('');
            writeln('Fitur ini hanya dapat diakses oleh admin. Kontak admin terdekat.');
            writeln('');

        end else begin            

            writeln('');
            write ('Masukkan ID Buku: ');
            readln (IdAdd);
            write ('Masukkan jumlah buku yang ditambahkan: ');
            readln (NAdd);
            writeln ();
            
            array_buku.T[FoundBookIdIdx (IdAdd, array_buku)].Jumlah_Buku := array_buku.T[FoundBookIdIdx (IdAdd, array_buku)].Jumlah_Buku + NAdd;
            
            writeln ('Pembaharuan jumlah buku berhasil dilakukan, total buku ', array_buku .T[FoundBookIdIdx (IdAdd, array_buku)].Judul_Buku, ' di perpustakaan menjadi ', array_buku.T[FoundBookIdIdx (IdAdd, array_buku)].Jumlah_Buku);
            writeln('');

            isSave := False;
        
        end;
        
    end;

end.