program main_modular;

uses 
    crt, parser, konversi, tipe_data, proses_user_program, proses_data, proses_buku;
    (*Unit yang dibutuhkan dalam eksekusi program utama ini*)

var

    array_buku : tabBuku; //array data buku 

    array_user : tabUser; //array data user

    array_pinjam : tabPinjam; //array data pinjam

    array_kembali : tabKembali; //array data kembali

    array_hilang : tabHilang; //array data kehilangan
    
    pilihan_menu : string; //variabel yang menyimpan input menu pilihan
	
    active_user : tuser; //variabel yang menyimpan nama username yg lagi login
	
    isLogin : boolean; //variabel yang menentukan apakah lagi ada user yang aktif
    
    isSave : boolean; //variabel yang menyatakan apakah data sudah disimpan atau belum
	
    willExit : Boolean; //variabel yang menentukan apakah program akan berhenti
	
    nama_file_buku, nama_file_user, nama_file_pinjam, nama_file_kembali, nama_file_hilang: string;
    //nama file csv yang dimuat oleh program

begin

    isLogin := False; (*State awal tidak ada yang sedang login*)
    willExit := False; (*State awal aplikasi sedang berjalan dan belum akan keluar*)

    writeln('');
    writeln('Muat database terlebih dahulu...');
    writeln('');

    (*Prosedur load dijalankan pertama kali*)
    writeln('$ load'); 
    writeln('');
    load(array_buku,array_user,array_pinjam,array_kembali,array_hilang,nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang);
    
    clrscr;

    writeln('==========================================================================================');
    writeln('==========================================================================================');
    writeln('----------------------Selamat datang di Perpustakaan Ba Sing Tse!-------------------------');
    writeln('------Gunakan keyword "help" untuk melihat semua menu pada aplikasi perpustakaan ini------');
    writeln('--------------------Kontak administrator terdekat untuk membuat akun!---------------------');
    writeln('==========================================================================================');
    writeln('==========================================================================================');
    
    repeat

        isSave := True; (*Awalnya belum ada perubahan data array sehingga tidak diperlukan penyimpanan*)

        repeat 

            writeln(''); write('$ '); readln(pilihan_menu);

            case (pilihan_menu) of (*Percabangan yang disesuaikan dengan input user*)

                'login' : loginAnggota(array_user,nama_file_user,active_user,isLogin);

                'cari' : CetakKategori(array_buku);

                'caritahunterbit' : CetakDariTahun(array_buku);

                'exit' : exiting_program(array_buku, array_user, array_pinjam, array_kembali, array_hilang, nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang, willExit,isLogin,isSave);
                    
                'help' : showHelp(isLogin); 

            end;

        until (willExit or isLogin); (*Menu awal saat belum ada yang log in*)

        if (not willExit) then begin (*Menu ketika sudah ada yang login*)

            repeat

                write('$ '); readln(pilihan_menu);

                case (pilihan_menu) of

                    'register' : registerAnggota( array_user, active_user, isSave);
                
                    'cari' : CetakKategori(array_buku);

                    'caritahunterbit' : CetakDariTahun(array_buku);

                    'exit' : exiting_program(array_buku,array_user,array_pinjam,array_kembali,array_hilang,nama_file_kembali, nama_file_pinjam, nama_file_user, nama_file_buku, nama_file_hilang,willExit,isLogin,isSave);
                        
                    'help' : showHelp(isLogin);

                    'pinjam_buku': pinjam_buku(array_buku,array_pinjam,active_user,isSave);

                    'kembalikan_buku' : kembalikan_buku (array_buku, array_pinjam, array_kembali, active_user, isSave ) ;
        
                    'lapor_hilang' : RegLost (array_hilang, isSave);

                    'lihat_laporan' : SeeLost (array_hilang, active_user);
                        
                    'tambah_buku' : AddBook (array_buku, active_user, isSave);
                        
                    'tambah_jumlah_buku' : AddJumlahBuku (array_buku, active_user, isSave);        

                    'riwayat' : Riwayat (array_pinjam, array_buku, active_user);
                        
                    'statistik' : Statistik (array_user, array_buku, active_user);
                    
                    'save' : save(array_buku,array_user,array_pinjam ,array_kembali,array_hilang,nama_file_kembali,nama_file_pinjam,nama_file_user,nama_file_buku,nama_file_hilang,isSave);       

                    'cari_anggota' : cariAnggota(array_user, active_user);
                        
                    'logout' : logout(array_buku,array_user,array_pinjam ,array_kembali,array_hilang,nama_file_kembali,nama_file_pinjam,nama_file_user,nama_file_buku,nama_file_hilang,isSave,isLogin);

                end;

            until (not isLogin) or willExit; (*Ulangi input user hingga logout atau keluar dari aplikasi.*)

        end;

    until(willExit); (*Jika willExit bernilai true, user keluar dari aplikasi*)

end.
