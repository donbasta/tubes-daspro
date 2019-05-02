unit proses_user_program;

interface

	uses crt, tipe_data, konversi, proses_data, proses_buku;

    procedure Riwayat (var H : tabPinjam ; var B : TabBuku ; var active_user : tuser );
	(*Procedure ini berfungsi untuk melihat riwayat peminjaman seorang user*)

    procedure Statistik (var U : TabUser;  var B : TabBuku; var active_user : tuser);
	(*Procedure ini berfungsi untuk melihat statistik perpustakaan*)

    procedure cariAnggota (var array_user : tabUser; var active_user : tuser);
	(*Procedure ini mencari anggota perpustakaan berdasarkan keyword username*)

    procedure exiting_program(var array_buku : tabBuku; var array_user : tabUser; var array_pinjam : tabPinjam; var array_kembali : tabKembali; var array_hilang : tabHilang; var nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang: string; var willExit,isLogin,isSave : boolean );
    (*Procedure ini berfungsi untuk keluar dari program dan menyimpan data*)
	
	procedure registerAnggota( var array_user : tabUser; var active_user : tuser; var isSave: Boolean);
	(*Procedure ini berfungsi untuk mendaftarkan anggota baru dan hanya dapat dilakukan oleh admin*)
	
	procedure loginAnggota(var array_user : tabUser; var nama_file_user:string; var active_user: tuser; var isLogin: boolean);
	(*Procedure ini beru=fungsi untuk anggota perpustakaan login ke sistem*)

	procedure tampilMenuBelumLogin();
	(*Procedure ini menampilkan interface aplikasi perpustakaan sebelum login*)

	procedure tampilMenu(var role_active_user:string);
	(*Procedure ini menampilkan interface aplikasi ketika sedang ada yang login, bergantung pada*)
	
	procedure showHelp(var isLogin: boolean);
	(*Procedure ini menampilkan pilihan menu yang dapat diakses oleh user*)

	procedure logout(var array_buku : tabBuku; var array_user : tabUser; var array_pinjam : tabPinjam; var array_kembali : tabKembali; var array_hilang : tabHilang; var nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang: string; var isSave, isLogin : Boolean);
	(*Procedure untuk keluar dari program*)

implementation

    procedure Riwayat (var H : tabPinjam ; var B : TabBuku ; var active_user : tuser );
	(*Procedure ini berfungsi untuk melihat riwayat peminjaman seorang user*)
	{Kamus Lokal}
	var
		U : string;
		i,j : integer;
		total : integer;

	begin
		if(active_user.role = 'pengunjung') then begin

            writeln('');
            writeln('Fitur ini hanya dapat diakses oleh admin. Kontak admin terdekat.');
            writeln('');

        end else begin

			total := 0;
			// Input
			writeln('');
			write('Masukkan username pengunjung: ');
			readln(U);
			writeln('Riwayat: ');

			// Menuliskan riwayat pinjam buku user sesuai ketentuan -- menggunakan pengulangan untuk menampilkan data
			for i:=1 to H.Neff do
			begin
			if (H.T[i].Username = U) then
				begin
					total := total +1;
					for j:=1 to B.Neff do begin
					if(H.T[i].ID_Buku = B.T[j].ID_Buku) then begin
						writeln(H.T[i].Tanggal_Peminjaman, ' | ',H.T[i].ID_Buku,' | ',B.T[j].Judul_Buku)
					end;
					end;
				end;
			end;

			if(total = 0) then writeln('Tidak ada data yang ditemukan.');
			writeln('');

		end;

    end;


    procedure Statistik (var U : TabUser;  var B : TabBuku; var active_user : tuser);
	(*Procedure ini berfungsi untuk melihat statistik perpustakaan*)
	{Kamus Lokal}
    var
    	i,admin,pengunjung,sastra,sains,manga,sejarah,programming : integer;

    begin

		if(active_user.role = 'pengunjung') then begin

            writeln('');
            writeln('Fitur ini hanya dapat diakses oleh admin. Kontak admin terdekat.');
            writeln('');

    	end else begin

			writeln('');
			// menggunakan pengulangan untuk menghitung jumlah data
			admin := 0; pengunjung := 0;
			for i:=1 to U.Neff do
			begin
				if (U.T[i].Role = 'admin') then
				begin
					admin := admin + 1;
				end else if (U.T[i].Role = 'pengunjung') then
				begin
					pengunjung := pengunjung + 1;
				end;
			end;

			// menggunakan pengulangan untuk menghitung jumlah data
			sastra := 0; sains := 0; manga := 0; sejarah := 0; programming := 0;
			for i:=1 to B.Neff do  // menggunakan pengulangan untuk menghitung jumlah data
			begin
				if (B.T[i].Kategori = 'sastra') then
				begin
					sastra := sastra + (B.T[i].Jumlah_Buku);
				end else if (B.T[i].Kategori = 'sains') then
				begin
					sains := sains + (B.T[i].Jumlah_Buku);
				end else if (B.T[i].Kategori = 'manga') then
				begin
					manga := manga + (B.T[i].Jumlah_Buku);
				end else if (B.T[i].Kategori = 'sejarah') then
				begin
					sejarah := sejarah + (B.T[i].Jumlah_Buku);
				end else if (B.T[i].Kategori = 'programming') then
				begin
					programming := programming + (B.T[i].Jumlah_Buku);
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

			writeln('');
		
		end;

    end;


    procedure cariAnggota (var array_user : tabUser; var active_user : tuser);
	(*Procedure ini mencari anggota perpustakaan berdasarkan keyword username*)
	{Kamus Lokal}
    var
        isFound : Boolean;
        i : integer;
		keyword : string;

    begin

		 if(active_user.role = 'pengunjung') then begin

            writeln('');
            writeln('Fitur ini hanya dapat diakses oleh admin. Kontak admin terdekat.');
            writeln('');

        end else begin

			writeln('');
			isFound := False;
			write('Masukkan username yang ingin dicari: ');
			readln(keyword);
			for i:= 1 to array_user.Neff do begin
				if (array_user.T[i].username = keyword) then begin
					writeln('Nama Anggota: ', array_user.T[i].nama);
					writeln('Alamat Anggota: ', array_user.T[i]. alamat);
					isFound := true;
					Break;
				end;
			end;

			if (not isFound) then begin
				writeln('Maaf, username tidak ditemukan.')
			end;

			writeln('');

		end;
    end;


    procedure exiting_program(var array_buku : tabBuku; var array_user : tabUser; var array_pinjam : tabPinjam; var array_kembali : tabKembali; var array_hilang : tabHilang; var nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang: string; var willExit,isLogin,isSave : boolean );
    (*Procedure ini berfungsi untuk keluar dari program dan menyimpan data*)
    {Kamus Lokal}
    var
		pilihan_menu : string;

    begin

		if(not isLogin) then begin

            writeln('');
            writeln('Apakah anda yakin ingin keluar? (Y/N) ');
            readln(pilihan_menu);
                if (pilihan_menu = 'Y') then begin
                    willExit := True;
                end;

        end else begin

			if(not isSave) then begin
                writeln('');
                write('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ?');
            	writeln('');
                readln(pilihan_menu);
                if(pilihan_menu = 'Y') then begin
                   save(array_buku,array_user,array_pinjam ,array_kembali,array_hilang,nama_file_kembali,nama_file_pinjam,nama_file_user,nama_file_buku,nama_file_hilang,isSave);
                end;
            end;

            writeln('');
            writeln('Apakah anda yakin ingin keluar? (Y/N) ');
            writeln('');
            readln(pilihan_menu);
            if (pilihan_menu = 'Y') then begin
                willExit := True;
            end;
			  
		end;

	end;


	procedure tampilMenuBelumLogin();
	(*Procedure ini menampilkan interface aplikasi perpustakaan sebelum login*)
	begin
		writeln('1.Login');
		writeln('2.Cari Buku Per Kategori');
		writeln('3.Cari Buku Per Tahun Terbit');
		writeln('4.Keluar');
	end;
	

	procedure tampilMenu(var role_active_user:string);
	(*Procedure ini menampilkan interface aplikasi ketika sedang ada yang login, bergantung pada*)

	begin

			if(role_active_user = 'pengunjung') then begin
				writeln('1.Cari Buku Per Kategori');
				writeln('2.Cari Buku Per Tahun Terbit');
				writeln('3.Pinjam Buku');
				writeln('4.Kembalikan Buku');
				writeln('5.Melaporkan buku hilang');
				writeln('6.Log Out');
			end else if(role_active_user = 'admin') then begin
				writeln('1.Register Akun Baru');
				writeln('2.Tambah Buku Baru');
				writeln('3.Tambah Jumlah Buku');
				writeln('4.Lihat riwayat peminjaman');
				writeln('5.Statistik perpustakaan');
				writeln('6.Cari Anggota');
				writeln('7.Log Out');
			end;

	end;

	

	procedure registerAnggota( var array_user : tabUser; var active_user : tuser; var isSave: Boolean);
	(*Procedure ini berfungsi untuk mendaftarkan anggota baru dan hanya dapat dilakukan oleh admin*)
	(*Variabel lokal*)
	var
		nama, alamat, uname, password, role : string;
		
	begin

        if(active_user.role = 'pengunjung') then begin

            writeln('');
            writeln('Fitur ini hanya dapat diakses oleh admin. Kontak admin terdekat.');
            writeln('');

        end else begin
                           
			writeln('');
			writeln('Registrasi Pengguna Baru');
			write('Nama Lengkap: ');
			readln(nama);
			write('Alamat: ');
			readln(alamat);
			write('Username: ');
			readln(uname);
			write('Password: ');
			readln(password);
			write('Role: ');
			readln(role);
			
			array_user.Neff := array_user.Neff + 1;
			array_user.T[ array_user.Neff ].Nama := nama;
			array_user.T[ array_user.Neff ].Alamat := alamat;
			array_user.T[ array_user.Neff ].Username	:= uname;
			array_user.T[ array_user.Neff ].Password := hash(password);
			array_user.T[ array_user.Neff ].Role := role;

			writeln('Registrasi Berhasil Dilakukan!');
			writeln('');

			isSave := False;

		end;
	
	end;
	

	procedure loginAnggota(var array_user : tabUser; var nama_file_user:string; var active_user: tuser; var isLogin: boolean);
	(*Procedure ini beru=fungsi untuk anggota perpustakaan login ke sistem*)
	{Kamus Lokal}
	var
		in_Uname, in_Pass, check: string;
		ch : char = #0;
		i, user_masuk : integer;
		status: boolean;

	begin
		writeln('');
		write('Masukkan Username Anda: ');
		readln(in_Uname);
		
		in_Pass:='';
		write('Masukkan Password Anda: ');
		while true do begin
    		ch :=ReadKey;
    		if (ch=#13) then break;
      		if (ch=#8) then begin
        		if (Length(in_Pass)=0) then continue;
        		Delete(in_Pass,Length(in_Pass),1);
        		write(ch);
    			ClrEol;
				Continue;
			end;
 			in_Pass := in_Pass + ch;
 			write('*');
		end;
		writeln('');
		
		status:= False;
		for i:=1 to array_user.Neff do begin
			check := unhash(array_user.T[i].password);
			if(in_Uname = array_user.T[i].username) and (in_Pass = check) then begin
				status := True;
				user_masuk := i;
			end;
		end;
	
	    if (status = True) then begin

			active_user.nama := array_user.T[user_masuk].nama;
			active_user.password := unhash(array_user.T[user_masuk].password);
			active_user.username := array_user.T[user_masuk].username;
			active_user.role := array_user.T[user_masuk].role;
			active_user.alamat := array_user.T[user_masuk].alamat;

			writeln('Login Berhasil!');
			writeln('User ', in_Uname ,' berhasil login ke sistem perpustakaan');
			writeln('Selamat menikmati!');
			writeln('');
			writeln('Ketik "help" untuk menampilkan menu' );
			writeln('');
			isLogin := True;

	   	end else begin
			writeln('Pasangan username dan password salah! Masukkan yang benar!')
		end;

	end;


	procedure showHelp(var isLogin: boolean);
	(*Procedure ini menampilkan pilihan menu yang dapat diakses oleh user*)
	begin
		if (not isLogin) then begin {Jika tidak ada yang login}

			writeln('');
			writeln('login : Masuk ke akun anda.');
			writeln('cari : Cari buku dari 5 kategori: manga, programming, sastra, sains, dan sejarah.');
			writeln('caritahunterbit : Cari buku berdasarkan tahun terbit.');
			writeln('exit : Keluar dari program.');
			writeln('');

		end else begin {isLogin = True}

			writeln('');
			writeln('============================DAFTAR PERINTAH YANG TERSEDIA======================');
			writeln('==== register                                                                  ');
			writeln('==== cari : Cari buku dari 5 kategori: manga,programming,sastra,sains,sejarah. ');
			writeln('==== caritahunterbit : Cari buku berdasarkan tahun terbit.                     ');
			writeln('==== pinjam_buku : Meminjam buku.                                              ');
			writeln('==== kembalikan_buku : Mengembalikan buku.		                                ');
			writeln('==== lapor_hilang : Lapor apabila ada kehilangan buku.                         ');
			writeln('==== lihat_laporan : Lihat laporan kehilangan.		                            ');
			writeln('==== tambah_buku : Tambah buku baru ke perpustakaan.	                        ');
			writeln('==== tambah_jumlah_buku : Tambah jumlah buku yang tersedia.                    ');
			writeln('==== riwayat : Lihat riwayat peminjaman.                                       ');
			writeln('==== statistik : Lihat statistik perpustakaan.                                 ');
			writeln('==== save : Simpan perubahan yang telah dilakukan.                             ');
			writeln('==== cari_anggota : Cari anggota perpustakaan.                                 ');
			writeln('==== logout : Keluar dari akun Anda.                                           ');
			writeln('==== exit : Keluar dari program.                                               ');
			writeln('===============================================================================');
			writeln('');
			
		end;
	  
	end;

	procedure logout(var array_buku : tabBuku; var array_user : tabUser; var array_pinjam : tabPinjam; var array_kembali : tabKembali; var array_hilang : tabHilang; var nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang: string; var isSave, isLogin : Boolean);
	(*Procedure untuk keluar dari program*)
	{KAMUS LOKAL}
	var
		pilihan_menu : string;
	{ALGORITMA}
	begin
	  
	  	 if(not isSave) then begin
            writeln('');
            write('Apakah anda mau melakukan penyimpanan file yang sudah dilakukan (Y/N) ? ');
            readln(pilihan_menu);
            if(pilihan_menu = 'Y') then begin
                save(array_buku,array_user,array_pinjam ,array_kembali,array_hilang,nama_file_kembali,nama_file_pinjam,nama_file_user,nama_file_buku,nama_file_hilang,isSave);
            end;
        end;

        writeln('Apakah anda yakin ingin logout? (Y/N)');
        readln(pilihan_menu);
        if (pilihan_menu = 'Y') then begin
            isLogin := False;
        end;

	end;

end.
