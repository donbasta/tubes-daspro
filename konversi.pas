unit konversi;

interface

    uses tipe_data;

    function isKabisat (t : integer) : boolean;
    (*Mengembalikan nilai true bila tahun kabisat*)

    function toHari (t : ttanggal) : integer;
    (*Mengonversi dd/mm/yyyy menjadi jumlah hari*)

    function selisihHari (t2,t1: ttanggal) : integer;
    (*Menghitung selisih hari dari dua tanggal*)

    function toStr (n : integer) : string;
    (*Mengubah tipe data integer menjadi string*)

    function toInt (s : string) : integer;
    (*Mengonversi tipe data string menjadi integer*)

    function stringToTanggal (s : string) : ttanggal;
    (*Mengonversi string 'dd/mm/yyyy' menjadi type ttanggal*)

    function tanggalToString (t : ttanggal) : string ;
    (*Mengonversi type ttanggal menjadi string 'dd/mm/yyyy'*)

    function batas (t: ttanggal ; n: integer) : ttanggal;
    (*Menentukan tanggal batas untuk pengumpulan*)
	
    function hash (t : string) : string;
    (*Melakukan hash pada suatu string (password)*)

    function unhash (t: string) : string;
    (*Mengembalikan password dari bentuk hashnya ke semula*)

implementation

    function isKabisat (t : integer) : boolean;
    (*Mengembalikan nilai true bila tahun kabisat*)
    (*Algoritma*)
    begin
        
        if ((t mod 4 = 0) and (t mod 100 <> 0)) or (t mod 400 = 0) then
        begin
            isKabisat := True;
        end else
        begin
            isKabisat := False;
        end;

    end;


    function toHari (t : ttanggal) : integer;
    (*Mengonversi dd/mm/yyyy menjadi jumlah hari*)
    (*Kamus Lokal*)
    var
        i : integer;
    (*Algoritma*)    
    begin

        toHari := 0; {Inisialisasi}
        for i:=0 to t.tahun - 1 do
        begin

            if (isKabisat(i)) then
            begin
                toHari := toHari + 366;
            end else
            begin
                toHari := toHari + 365;
            end;

        end;

        if (isKabisat(t.tahun)) then
        begin

            case t.bulan of

                1 : toHari:= toHari + t.tanggal;

                2 : toHari:= tohari + 31 + t.tanggal;

                3 : toHari:= tohari + 60 + t.tanggal;

                4 : toHari:= toHari + 91 + t.tanggal;

                5 : toHari:= toHari + 121 + t.tanggal;

                6 : toHari:= toHari + 152 + t.tanggal;

                7 : toHari:= toHari + 182 + t.tanggal;

                8 : toHari:= toHari + 213 + t.tanggal;

                9 : toHari:= toHari + 244 + t.tanggal;

                10 : toHari:= toHari + 274 + t.tanggal;

                11 : toHari:= toHari + 305 + t.tanggal;

                12 : toHari:= toHari + 335 + t.tanggal;

            end;

        end else
        begin

            case t.bulan of

                1 : toHari:= toHari + t.tanggal;

                2 : toHari:= toHari + 31 + t.tanggal;

                3 : toHari:= toHari + 59 + t.tanggal;

                4 : toHari:= toHari + 90 + t.tanggal;

                5 : toHari:= toHari + 120 + t.tanggal;

                6 : toHari:= toHari + 151 + t.tanggal;

                7 : toHari:= toHari + 181 + t.tanggal;
    
                8 : toHari:= toHari + 212 + t.tanggal;

                9 : toHari:= toHari + 243 + t.tanggal;

                10 : toHari:= toHari + 273 + t.tanggal;

                11 : toHari:= toHari + 304 + t.tanggal;

                12 : toHari:= toHari + 334 + t.tanggal;

            end;

        end; 
        
    end;
    

    function selisihHari (t2,t1: ttanggal) : integer;
    (*Menghitung selisih hari dari dua tanggal*)
    (*Algoritma*)
    begin
        
        selisihHari:= toHari(t2) - toHari(t1); 

    end;


    function toStr (n : integer) : string;
    (*Mengubah tipe data integer menjadi string*)
    (*Kamus Lokal*)
    var
        s : string;
    (*Algoritma*)
    begin
        str(n,s);
        toStr := s;
    end;


    function toInt (s : string) : integer;
    (*Mengonversi tipe data string menjadi integer*)
    (*Kamus Lokal*)
    var
        num , error : integer;
    (*Algoritma*)
    begin
        
        val(s,num,error);
        if (error = 0) then
        begin
            toInt:= num;
        end;

    end;


    function stringToTanggal (s : string) : ttanggal;
    (*Mengonversi string 'dd/mm/yyyy' menjadi type ttanggal*)
    (*Anggap masukan valid dd/mm/yyyy*)
    (*Algoritma*)
    begin

        stringToTanggal.tanggal:= toInt(copy(s,1,2));
        stringToTanggal.bulan:= toInt(copy(s,4,2));
        stringToTanggal.tahun:= toInt(copy(s,7,4));

    end;


    function tanggalToString (t : ttanggal) : string ;
    (*Mengonversi type ttanggal menjadi string 'dd/mm/yyyy'*)
    (*Algoritma*)
    begin

        tanggalToString:='';
        if (t.tanggal<10) then
        begin
            tanggalToString:= tanggaltoString + '0' + toStr(t.tanggal) + '/';
        end else
        begin
            tanggalToString:= tanggaltoString + toStr(t.tanggal) + '/';
        end;

        if(t.bulan<10) then
        begin
            tanggalToString:= tanggaltoString + '0' + toStr(t.bulan) + '/';
        end else
        begin
            tanggalToString:= tanggaltoString + toStr(t.bulan) + '/';
        end;

        tanggalToString:= tanggaltoString + toStr(t.tahun);
        

    end;


    function batas (t: ttanggal ; n: integer) : ttanggal;
    (*Menentukan tanggal batas untuk pengumpulan*)
    (*Algoritma*)
    begin
        
        batas.tanggal := t.tanggal + n;
        if (t.bulan= 1) or (t.bulan= 3) or (t.bulan= 5) or (t.bulan= 7) or (t.bulan= 8) or (t.bulan= 10) or (t.bulan= 12) then
        begin 
            
            if (batas.tanggal > 31) then
            begin
                batas.tanggal:= batas.tanggal-31;
                if(t.bulan = 12) then
                begin
                    batas.bulan:= 1;
                    batas.tahun:= t.tahun + 1;
                end else
                begin
                    batas.bulan:= t.bulan + 1;
                    batas.tahun:= t.tahun + 1;
                end;
            end else (*batas.tanggal <= 31*)
            begin
                batas.bulan:= t.bulan;
                batas.tahun:= t.tahun;
            end;
            
        end else if (t.bulan= 4) or (t.bulan= 6) or (t.bulan= 9) or (t.bulan = 11) then
        begin
        
            if(batas.tanggal > 30) then
            begin
                    batas.bulan:= t.bulan + 1;
                    batas.tanggal:= batas.tanggal - 30;
                    batas.tahun:= t.tahun;
            end else
            begin
                    batas.bulan:= t.bulan;
                    batas.tahun:= t.tahun;
            end; 
            
        end else if (t.bulan = 2) then
        begin
            
            if(isKabisat(t.tahun)) then
            begin
                if (batas.tanggal>29) then
                begin
                    batas.tanggal := batas.tanggal - 29;
                    batas.bulan := t.bulan +1;
                    batas.tahun:= t.tahun;
                end else
                begin
                    batas.bulan:= t.bulan;
                    batas.tahun:= t.tahun;
                end;
            end else
            begin
                if (batas.tanggal>28) then
                begin
                    batas.tanggal := batas.tanggal - 28;
                    batas.bulan := t.bulan + 1;
                    batas.tahun:= t.tahun;
                end else
                begin
                    batas.bulan:= t.bulan;
                    batas.tahun:= t.tahun;
                end;
            end;	
        end;
    end;
    
	
	function hash(t: string) : string;
    (*Mengubah suatu string ke dalam hashnya dengan teknik menggeser urutan karakter sebanyak 13*)
    {Kamus Lokal}
	var
		i : integer;
		d : string;
    {Algoritma}
	begin
		d := '';
		for i:=1 to Length(t) do begin
			d := d + char(13 + ord(t[i]));
		end;
		hash := d;
	end;


    function unhash (t: string) : string;
    (*Mengembalikan string dari hasil hash ke dalam bentuk semula (Invers fungsi hash) *)
    {Kamus Lokal}
    var
		i : integer;
		d : string;
    {Algoritma}
	begin
		d := '';
		for i:=1 to Length(t) do begin
			d := d + char(ord(t[i])-13);
		end;
		unhash := d;
	end;
	
end.
