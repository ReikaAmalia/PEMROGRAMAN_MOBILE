void main() {
  for (int i = 0; i <= 201; i++) {
    if (isPrime(i)) {
      print("$i -> Reika Amalia Syahputri (NIM: 2341720173)");
    } else {
      print(i);
    }
  }
}

// Fungsi untuk cek bilangan prima
bool isPrime(int number) {
  if (number < 2) return false; // 0 dan 1 bukan prima
  for (int i = 2; i <= number ~/ 2; i++) {
    if (number % i == 0) return false;
  }
  return true;
}