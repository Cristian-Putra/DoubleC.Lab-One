program Pencatatan_Pemasukan_dan_Pengeluaran_Keuangan;
uses crt;

type
    TPengeluaran = record
        Makanan, Transportasi, Belanja, Hiburan, Medis, Pendidikan, Tagihan: longint;
    end;

    TPemasukan = record
        Gaji, Bonus, Hadiah, Investasi, Lainnya: longint;
    end;

var
    Pengeluaran: TPengeluaran;
    Pemasukan: TPemasukan;
    TotalMasuk, TotalKeluar, TotalAkhir: longint;
    waktu: integer;
    waktuz: string;
    hariKerja, MingguKerja: integer;
    pilihanWaktu: array[1..3] of string = ('Harian', 'Mingguan', 'Bulanan');

// Prosedur untuk memilih waktu alokasi
procedure PilihWaktu(var waktu: integer; var waktuz: string);
begin
    repeat
        writeln('Pilih kapan kamu digaji?:');
        writeln('1. ', pilihanWaktu[1]);
        writeln('2. ', pilihanWaktu[2]);
        writeln('3. ', pilihanWaktu[3]);
        write('Pilihan: '); readln(waktu);
        
        if (waktu < 1) or (waktu > 3) then
            writeln('Pilihan tidak valid! Silakan coba lagi.');
    until (waktu >= 1) and (waktu <= 3);
    
    waktuz := pilihanWaktu[waktu];
end;

// Fungsi untuk menghitung total pemasukan
function HitungTotalPemasukan(P: TPemasukan; waktu: integer; hariKerja: integer; MingguKerja: integer): longint;
begin
    if waktu = 1 then // Gaji harian
        HitungTotalPemasukan := (P.Gaji * hariKerja) + P.Bonus + P.Hadiah + P.Investasi + P.Lainnya
    else if waktu = 2 then // Gaji mingguan
        HitungTotalPemasukan := (P.Gaji * MingguKerja) + P.Bonus + P.Hadiah + P.Investasi + P.Lainnya
    else  // Gaji bulanan
        HitungTotalPemasukan := P.Gaji + P.Bonus + P.Hadiah + P.Investasi + P.Lainnya;
end;

// Fungsi untuk menghitung total pengeluaran
function HitungTotalPengeluaran(K: TPengeluaran): longint;
begin
    HitungTotalPengeluaran := K.Makanan + K.Transportasi + K.Belanja + K.Hiburan + K.Medis + K.Pendidikan + K.Tagihan;
end;

// Prosedur untuk input data pemasukan
procedure InputPemasukan(var P: TPemasukan; waktu: integer);
begin
    writeln('=== Masukkan Data Pemasukan ===');
    if waktu = 1 then // Gaji harian
    begin
    repeat
        write('Gaji per hari: '); readln(P.Gaji);
        write('Jumlah hari kerja selama 1 bulan: '); readln(hariKerja);
         if (hariKerja > 31) then
            writeln('Tidak valid! Maksimal 31/31!');
    until (hariKerja < 32);
    end
    
    else if waktu = 2 then // Gaji mingguan
    begin
    repeat
        write('Gaji per minggu: '); readln(P.Gaji);
        write('Jumlah minggu kerja selama 1 bulan: '); readln(MingguKerja);
        if (MingguKerja > 4) then
            writeln('Tidak valid! Maksimal 4!');
    until (MingguKerja < 4);
    end
    else if waktu = 3 then // Gaji bulanan
    begin
        write('Gaji bulanan: '); readln(P.Gaji);
    end;
    write('Bonus    : '); readln(P.Bonus);
    write('Hadiah   : '); readln(P.Hadiah);
    write('Investasi: '); readln(P.Investasi);
    write('Lainnya  : '); readln(P.Lainnya);
end;

// Prosedur untuk input data pengeluaran
procedure InputPengeluaran(var K: TPengeluaran);
begin
    writeln('=== Masukkan Data Pengeluaran Perbulan ===');
    write('Makanan      : '); readln(K.Makanan);
    write('Transportasi : '); readln(K.Transportasi);
    write('Belanja      : '); readln(K.Belanja);
    write('Hiburan      : '); readln(K.Hiburan);
    write('Medis        : '); readln(K.Medis);
    write('Pendidikan   : '); readln(K.Pendidikan);
    write('Tagihan      : '); readln(K.Tagihan);
end;

// Prosedur untuk menampilkan detail keuangan
procedure TampilkanDetailKeuangan(TotalMasuk, TotalKeluar, TotalAkhir: longint; waktuz: string);
begin
    writeln('============================');
    writeln('Detail Keuangan ', waktuz);
    writeln('Total Pemasukan  : ', TotalMasuk);
    writeln('Total Pengeluaran: ', TotalKeluar);
    writeln('Saldo Akhir      : ', TotalAkhir);
    if TotalAkhir < 0 then writeln('Keuangan Anda Defisit')
    else if TotalAkhir = 0 then writeln('Keuangan Anda Stabil')
    else writeln('Keuangan Anda Surplus');
end;

begin
    clrscr;
    writeln('Selamat Datang Di Program Pencatatan Pemasukkan dan Pengeluaran Perbulan!');
    writeln;
    
    PilihWaktu(waktu, waktuz);
    writeln;

    // Input data pemasukan dan pengeluaran
    InputPemasukan(Pemasukan, waktu);
    writeln;
    InputPengeluaran(Pengeluaran);

    writeln;
    // Hitung total pemasukan, pengeluaran, dan saldo akhir
    TotalMasuk := HitungTotalPemasukan(Pemasukan, waktu, hariKerja, MingguKerja);
    TotalKeluar := HitungTotalPengeluaran(Pengeluaran);
    TotalAkhir := TotalMasuk - TotalKeluar;

    writeln;
    // Tampilkan detail keuangan
    TampilkanDetailKeuangan(TotalMasuk, TotalKeluar, TotalAkhir, waktuz);

    readln;
end.
