// void main() {
//   var gifts = {
//     // Key:    Value
//     'first': 'partridge',
//     'second': 'turtledoves',
//     'fifth': 1
//   };

//   var nobleGases = {
//     2: 'helium',
//     10: 'neon',
//     18: 2,
//   };

//   print(gifts);
//   print(nobleGases);
// }

void main() {
  // Map awal
  var gifts = {
    'first': 'partridge',
    'second': 'turtledoves',
    'fifth': 1
  };

  var nobleGases = {
    2: 'helium',
    10: 'neon',
    18: 2,
  };

  // Menambahkan / memperbarui elemen menggunakan Map literal
  var mhs1 = Map<String, String>();
  gifts['first'] = 'partridge';
  gifts['second'] = 'turtledoves';
  gifts['fifth'] = 'golden rings';
  // Tambahan nama dan NIM
  gifts['name'] = 'Reika Amalia';
  gifts['nim']  = '2341720173';

  var mhs2 = Map<int, String>();
  nobleGases[2]  = 'helium';
  nobleGases[10] = 'neon';
  nobleGases[18] = 'argon';
  // Tambahan nama dan NIM
  nobleGases[99] = 'Reika Amalia';
  nobleGases[100] = '2341720173';

  mhs1['name'] = 'Reika Amalia';
  mhs1['nim']  = '2341720173';

  mhs2[1] = 'Reika Amalia';
  mhs2[2] = '2341720173';

  // Cetak seluruh map
  print(gifts);
  print(nobleGases);
  print(mhs1);
  print(mhs2);
}