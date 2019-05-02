unit parser;

interface

    const 
        mark = ',';

    function csv (t: string) : string;
	(*Menambahkan tanda petik ganda ke ujung-ujung string dan mengubah tanda petik ganda
	di string menjadi dua petik ganda*)

    procedure csv_comma_solver(var f : Text; var a : string);
    (*Prosedur ini membaca data dari file csv apabila terdapat tanda koma dan tanda petik ganda yang 
    berbelit-belit.*)

implementation

    function csv (t: string) : string;
    (*Menambahkan tanda petik ganda pada ujung-ujung data dan mengubah tanda petik ganda 
    di dalam data menjadi dua buah untuk menyiasati keberadaan tanda koma pada data.*)
    {Kamus Lokal}
	var
		data_baru : string;
        i : integer;
    {Algoritma}
	begin
        data_baru := '"';
        for i:=1 to Length(t) do begin
            if(t[i] = '"') then begin
                data_baru := data_baru + '""';
            end else begin
                data_baru := data_baru + t[i];
            end;
        end;

        data_baru := data_baru + '"';
        csv := data_baru;
	end;
    

    procedure csv_comma_solver(var f: Text; var a : string);
    {Kamus Lokal}
    var
        chara : char;
        quote_count : integer;
        inside_count : boolean;
        i: integer;
    (*Algoritma*)
    begin

            a := '';
            inside_count := False; (*Menyatakan apakah data diapit oleh petik ganda atau tidak*)
            quote_count := 0; 

            read(f, chara);
            while(chara = '"') do begin (*Meghitung banyak petik ganda di awal data*)
                quote_count := quote_count + 1;
                read(f, chara);
            end;

            if((quote_count mod 2) = 1) then begin (*Jika banyak petik ganda ganjil, berarti data diapit*)
                inside_count := True;
                for i:=1 to ((quote_count-1) div 2) do a := a + '"';
            end; 

            if(inside_count = True) then begin (*Jika diapit, perlu diketahui di mana pengapit di sebelah kanannya*)
                repeat
                    quote_count := 0;
                    while(chara = '"') do begin
                        quote_count := quote_count + 1;
                        if (not eof(f)) then begin
                            read(f, chara);
                        end else begin
                            break;
                        end;
                    end;

                    if(quote_count > 0) then begin
                        if(quote_count mod 2 = 1) then begin
                            inside_count := False;
                            for i:=1 to ((quote_count-1) div 2) do a := a + '"';
                        end else begin
                            for i:=1 to (quote_count div 2 ) do a := a + '"'; 
                            a := a + chara;
                            read(f,chara);
                        end;
                    end else begin
                        a := a + chara;
                        read(f, chara);
                    end;

                until (inside_count = False);

                if(EOLn(f)) and (not eof(f)) then begin
                    read(f,chara);
                end;

            end else begin (*Jika tidak diapit, baca perkarakter hingga end of line atau end of file atau menemui mark*)
    
                a := a + chara;
                read(f, chara);
                while(chara <> ',') and (not EOLn(f)) do begin
                    a := a + chara;
                    read(f, chara);
                end;
                if(EOLn(f)) then begin
                    a := a + chara;
                    if(not eof(f)) then begin
                    read(f,chara);
                    end;
                end;

            end;
    
    end;

end.