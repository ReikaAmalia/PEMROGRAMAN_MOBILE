void main() {
  var record = ('first', a: 2, b: true, 'last');
  print(record);

  (int, int) tukar((int, int) record) {
  var (a, b) = record;
  return (b, a);
}
  var swapped = tukar((10, 20));
  print(swapped);

  //langkah 4
  (String, int) mahasiswa = ('Reika Amalia', 2341720173);
  print(mahasiswa);

  //langkah 5
  var mahasiswa2 = ('Reika Amalia', a: 2341720173, b: true, 'last');

  print(mahasiswa2.$1); // Prints 'Reika Amalia'
  print(mahasiswa2.a); // Prints 2341720173
  print(mahasiswa2.b); // Prints true
  print(mahasiswa2.$2); // Prints 'last'
}