//Praktikum 2: MENERAPKAN PERULANGAN “WHILE” DAN “DO-WHILE”
void main() {
  int counter = 0;

  while (counter < 33) {
    print(counter);
    counter++;
  }

  do {
    print(counter);
    counter++;
  } while (counter < 77);
}
