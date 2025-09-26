void main() {
  var list = [1, 2, 3];
  var list2 = [0, ...list]; // spread operator
  print(list);             // perbaikan di sini
  print(list2);
  print(list2.length);

  var list1 = [1, 2, null];
  print(list1);

  var list3 = [0, ...?list1]; // Spread operator aman untuk nilai null
  print(list3.length);

  // Tambahan: list NIM menggunakan spread
  var nimList = [...'2341720173'.split('')];
  print(nimList);

  //langkah 4
  bool promoActive = true;
  var nav = ['Home', 'Furniture', 'Plants', if (promoActive) 'Outlet'];
  print(nav);

  bool promoActive1 = false;
  var nav1 = ['Home', 'Furniture', 'Plants', if (promoActive1) 'Outlet'];
  print(nav1);

  //langkah 5
  String login = 'Manager'; 
  var nav2 = ['Home', 'Furniture', 'Plants', if (login == 'Manager') 'Inventory'];
  print(nav2);

  String login3 = 'Guest'; 
  var nav3 = ['Home', 'Furniture', 'Plants', if (login3 == 'Manager') 'Inventory'];
  print(nav3);

  //langkah 6
  var listOfInts = [1, 2, 3];
  var listOfStrings = ['#0', for (var i in listOfInts) '#$i'];
  assert(listOfStrings[1] == '#1');
  print(listOfStrings);
}