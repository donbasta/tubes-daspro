unit proses_data;

interface

    uses tipe_data, konversi, parser;

    const
    mark = ',';

    procedure convert_buku(var array_buku:tabBuku; var nama : string);
    (*Procedure ini membaca data dari file csv buku dan menyalinnya ke array*)

    procedure convert_user(var array_user:tabUser; var nama: string);
    (*Procedure ini membaca data dari file csv user dan menyalinnya ke array*)

    procedure convert_pinjam(var array_pinjam:tabPinjam; var nama: string);
    (*Procedure ini membaca data dari file csv peminjaman dan menyalinnya ke array*)

    procedure convert_kembali(var array_kembali:tabKembali; var nama: string);
    (*Procedure ini membaca data dari file csv pengembalian dan menyalinnya ke array*)

    procedure convert_hilang(var array_hilang:tabHilang; var nama: string);
    (*Procedure ini membaca data dari file csv kehilangan dan menyalinnya ke array*)

    procedure load(var array_buku : tabBuku; var array_user : tabUser; var array_pinjam : tabPinjam; var array_kembali : tabKembali; var array_hilang : tabHilang; var nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang: string );
    (*Procedure ini menyatukan semua fungsi convert menjadi satu*)

    procedure write_buku(var array_buku : tabBuku; var nama : string);
    (*Procedure ini membaca data dari array dan menyalinnya ke csv buku*)

    procedure write_user(var array_user : tabUser; var nama : string);
    (*Procedure ini membaca data dari array dan menyalinnya ke csv user*)

    procedure write_pinjam(var array_pinjam : tabPinjam; var nama : string);
    (*Procedure ini membaca data dari array dan menyalinnya ke csv peminjaman*)

    procedure write_kembali(var array_kembali : tabKembali; var nama : string);
    (*Procedure ini membaca data dari array dan menyalinnya ke csv pengembalian*)

    procedure write_hilang(var array_hilang : tabHilang; var nama : string);
    (*Procedure ini membaca data dari array dan menyalinnya ke csv kehilangan*)

    procedure save(var array_buku : tabBuku; var array_user : tabUser; var array_pinjam : tabPinjam; var array_kembali : tabKembali; var array_hilang : tabHilang; var nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang: string; var isSave : Boolean);
    (*Procedure ini menyatukan semua fungsi write menjadi satu*)

implementation

    procedure convert_buku(var array_buku:tabBuku; var nama : string);
    {Kamus Lokal}
    const
        mark = ',';
    var
        current : integer;
        f : text;
        a : string;
        chara : char;
    {Algoritma}
    begin
        array_buku.Neff := 0;
        current := 1;

        assign(f, nama); 
        reset(f);

            while(not eof(f)) do begin (*Pembacaan dilakukan selama belum eof, per record tipe data buku*)
            a := '';
            csv_comma_solver(f, a);
            array_buku.T[current].ID_Buku := toInt(a);
            
            a := '';
            csv_comma_solver(f, a);
            array_buku.T[current].Judul_Buku := a;
            
            a := '';
            csv_comma_solver(f, a);
            array_buku.T[current].Author := a;

            a := '';
            csv_comma_solver(f, a);
            array_buku.T[current].Jumlah_Buku := toInt(a);

            a := '';
            csv_comma_solver(f, a);
            array_buku.T[current].Tahun_Penerbit := toInt(a);
            
            a := '';
            csv_comma_solver(f, a);
            array_buku.T[current].Kategori := a;

            if(not eof(f)) then begin
            read(f,chara);
            end;

            array_buku.Neff := array_buku.Neff + 1;
            current := current + 1;
            end;

        close(f);
    end;

    procedure convert_user(var array_user:tabUser; var nama: string);
    {Kamus Lokal}
    var
        current : integer;
        f : text;
        a : string;
        chara : char;

    {Algoritma}
    begin
        array_user.Neff := 0;
        current := 1;

        assign(f, nama); reset(f);

            while(not eof(f)) do begin (*Pembacaan dilakukan selama belum eof, per record tipe data user*)
                a := '';
                csv_comma_solver(f, a);
                array_user.T[current].nama := a;

                a := '';
                csv_comma_solver(f, a);
                array_user.T[current].alamat := a;

                a := '';
                csv_comma_solver(f, a);
                array_user.T[current].username := a;

                a := '';
                csv_comma_solver(f, a);
                array_user.T[current].password := a;

                a := '';
                csv_comma_solver(f, a);
                array_user.T[current].role := a;

                if(not eof(f)) then begin
                read(f,chara);
                end;

                array_user.Neff := array_user.Neff + 1;
                current := current + 1;
            
            end;
        
        close(f);
    end;

    procedure convert_pinjam(var array_pinjam:tabPinjam; var nama: string);
    {Kamus Lokal}
    var
        current : integer;
        f : text;
        chara : char;
        a : string;

    {Algoritma}
    begin
        array_pinjam.Neff := 0;
        current := 1;

        assign(f, nama); reset(f);


            while (not eof(f)) do begin (*Pembacaan dilakukan selama belum eof, per record tipe data pinjam*)
            a := '';
            csv_comma_solver(f, a);
            array_pinjam.T[current].ID_Buku := toInt(a);
            
            a := '';
            csv_comma_solver(f, a);
            array_pinjam.T[current].Username := a;
            
            a := '';
            csv_comma_solver(f, a);
            array_pinjam.T[current].Judul_Buku := a;

            a := '';
            csv_comma_solver(f, a);
            array_pinjam.T[current].Tanggal_Peminjaman := a;

            a := '';
            csv_comma_solver(f, a);
            array_pinjam.T[current].Tanggal_Batas_Peminjaman := a;
            
            a := '';
            csv_comma_solver(f, a);

            if(not eof(f)) then begin
            read(f,chara);
            end;

            if(a='True') then begin
                array_pinjam.T[current].Status_Pengembalian := True;
            end else begin
                array_pinjam.T[current].Status_Pengembalian := false;
            end;

            array_pinjam.Neff := array_pinjam.Neff + 1;
            current := current + 1;
            end;

        close(f);
    end;

    procedure convert_kembali(var array_kembali:tabKembali; var nama: string);
    {Kamus Lokal}
    var
        current : integer;
        f : text;
        a : string;
        chara : char;

    {Algoritma}
    begin
        array_kembali.Neff := 0;
        current := 1;

        assign(f, nama); reset(f);

            while (not eof(f)) do begin (*Pembacaan dilakukan selama belum eof, per record tipe data kembali*)
                a := '';
                csv_comma_solver(f, a);
                array_kembali.T[current].Username := a;

                a := '';
                csv_comma_solver(f, a);
                array_kembali.T[current].ID_Buku := toInt(a);

                a := '';
                csv_comma_solver(f, a);
                array_kembali.T[current].Tanggal_Pengembalian := a;

                if(not eof(f)) then begin
                read(f,chara);
                end;

                array_kembali.Neff := array_kembali.Neff + 1;
                current := current + 1;
            
            end;
        
        close(f);
    end;

    procedure convert_hilang(var array_hilang:tabHilang; var nama: string);
    {Kamus Lokal}
    var
        current : integer;
        f : text;
        a : string;
        chara : char;

    {Algoritma}
    begin
        array_hilang.Neff := 0;
        current := 1;

        assign(f, nama); reset(f);


            while (not eof(f)) do begin (*Pembacaan dilakukan selama belum eof, per record tipe data hilang*)
                a := '';
                csv_comma_solver(f, a);
                array_hilang.T[current].Username := a;

                a := '';
                csv_comma_solver(f, a);
                array_hilang.T[current].ID_Buku_Hilang := toInt(a);

                a := '';
                csv_comma_solver(f, a);
                array_hilang.T[current].Tanggal_Laporan := a;

                if(not eof(f)) then begin
                read(f,chara);
                end;

                array_hilang.Neff := array_hilang.Neff + 1;
                current := current + 1;
            
            end;
        
        close(f);
    end;

    procedure load(var array_buku : tabBuku; var array_user : tabUser; var array_pinjam : tabPinjam; var array_kembali : tabKembali; var array_hilang : tabHilang; var nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang: string );
    {semua bakal dimasukin ke procedure ini untuk load}
    begin

        write('Masukkan nama file buku: ');
        readln(nama_file_buku);
        write('Masukkan nama file user: ');
        readln(nama_file_user);
        write('Masukkan nama file peminjaman: ');
        readln(nama_file_pinjam);
        write('Masukkan nama file pengembalian: ');
        readln(nama_file_kembali);
        write('Masukkan nama file buku hilang: ');
        readln(nama_file_hilang);

        convert_buku(array_buku, nama_file_buku);
        convert_user(array_user, nama_file_user);
        convert_pinjam(array_pinjam, nama_file_pinjam);
        convert_kembali(array_kembali, nama_file_kembali);
        convert_hilang(array_hilang, nama_file_hilang);

        writeln('Memuat data...');
        writeln('Selamat, data berhasil dimuat!');
        writeln('');

    end;

    procedure write_buku(var array_buku : tabBuku; var nama : string);
    {Kamus Lokal}
    var
        f : text;
        i : integer;
        data_save : string;
    {Algoritma}
    begin
        assign(f, nama); rewrite(f);

        for i := 1 to array_buku.Neff do begin
            data_save := toStr( array_buku.T[i].ID_Buku ) +','+ csv(array_buku.T[i].Judul_Buku)+','+csv(array_buku.T[i].Author)+','+toStr (array_buku.T[i].Jumlah_Buku)+','+toStr(array_buku.T[i].Tahun_Penerbit)+','+array_buku.T[i].Kategori;
            writeln(f, data_save);
        end;
    
        close(f);
    end;

    procedure write_user(var array_user : tabUser; var nama : string);
    {Kamus Lokal}
    var
        f : text;
        i : integer;
        data_save : string;
    {Algoritma}
    begin
        assign(f, nama); rewrite(f);

        for i := 1 to array_user.Neff do begin
            data_save := csv(array_user.T[i].nama)+','+csv(array_user.T[i].alamat)+','+array_user.T[i].username+','+array_user.T[i].password+','+array_user.T[i].role;
            writeln(f, data_save);
        end;

        close(f);
    end;

    procedure write_pinjam(var array_pinjam : tabPinjam; var nama : string);
    {Kamus Lokal}
    var
        f : text;
        i : integer;
        data_save, ubah_status : string;
    {Algoritma}
    begin
        assign(f, nama); rewrite(f);

        for i := 1 to array_pinjam.Neff do begin
            if(array_pinjam.T[i].Status_Pengembalian) then begin
                ubah_status := 'True';
            end else begin
                ubah_status := 'False';
            end;
            data_save := toStr (array_pinjam.T[i].ID_Buku)+','+array_pinjam.T[i].username+','+csv(array_pinjam.T[i].Judul_Buku)+','+array_pinjam.T[i].Tanggal_Peminjaman+','+array_pinjam.T[i].Tanggal_Batas_Peminjaman+','+ubah_status;
            writeln(f, data_save);
        end;

        close(f);
    end;

    procedure write_kembali(var array_kembali : tabKembali; var nama : string);
    {Kamus Loka;}
    var
        f : text;
        i : integer;
        data_save : string;
    {Algoritma}
    begin
            assign(f, nama); rewrite(f);

        for i := 1 to array_kembali.Neff do begin
            data_save := array_kembali.T[i].Username+','+toStr(array_kembali.T[i].ID_Buku)+','+array_kembali.T[i].Tanggal_Pengembalian;
            writeln(f, data_save);
        end;

        close(f);
    end;

    procedure write_hilang(var array_hilang : tabHilang; var nama : string);
    {Kamus Lokal}
    var
            f : text;
            i : integer;
            data_save : string;
    {Algoritma}
    begin
            assign(f, nama); rewrite(f);

        for i := 1 to array_hilang.Neff do begin
            data_save := csv(array_hilang.T[i].Username)+','+ toStr (array_hilang.T[i].ID_Buku_Hilang)+','+array_hilang.T[i].Tanggal_Laporan;
            writeln(f, data_save);
        end;

        close(f);
    end;


    procedure save(var array_buku : tabBuku; var array_user : tabUser; var array_pinjam : tabPinjam; var array_kembali : tabKembali; var array_hilang : tabHilang; var nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang: string; var isSave : Boolean);
    (*Procedure ini menyatukan semua fungsi write menjadi satu*)
    
    begin

            writeln('');
            write('Masukkan nama file buku: ');
            readln(nama_file_buku);
            write('Masukkan nama file user: ');
            readln(nama_file_user);
            write('Masukkan nama file peminjaman: ');
            readln(nama_file_pinjam);
            write('Masukkan nama file pengembalian: ');
            readln(nama_file_kembali);
            write('Masukkan nama file buku hilang: ');
            readln(nama_file_hilang);

            write_buku(array_buku, nama_file_buku);
            write_user(array_user, nama_file_user);
            write_pinjam(array_pinjam, nama_file_pinjam);
            write_kembali(array_kembali, nama_file_kembali);
            write_hilang(array_hilang, nama_file_hilang);

            writeln('Data berhasil disimpan!');
            writeln('');
            
            isSave := True;
    end;

end.