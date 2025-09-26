void main() {
  // Membuat list berisi 1, 2, 3
  // var list = [1, 2, 3];

  // Mengecek panjang list dan nilai index ke-1
  // assert(list.length == 3);
  // assert(list[1] == 2);

  // Menampilkan panjang list dan nilai index ke-1
  // print(list.length); 
  // print(list[1]);     

  // Mengganti nilai index ke-1 menjadi 1
  // list[1] = 1;

  // Mengecek kembali nilai index ke-1
  // assert(list[1] == 1);

  // Menampilkan nilai index ke-1 setelah diubah
  // print(list[1]);     // output: 1

  // file: main.dart

  //LANGKAH 3
  // Membuat list dengan panjang 5, default value = null
  final List<String?> list = List<String?>.filled(5, null);

  // Mengisi elemen index ke-1 dan ke-2
  list[1] = 'Reika Amalia Syahputri';   
  list[2] = '2341720173';    

  // Menampilkan seluruh isi list
  print(list);
}
