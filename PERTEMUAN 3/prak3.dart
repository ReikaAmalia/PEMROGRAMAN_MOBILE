void main() {
  // Langkah 1 + 2: perulangan for
  for (int index = 10; index < 27; index++) {
    // Langkah 3: break-continue
    if (index == 21) {
      print(index); 
      break;        // lalu hentikan loop
    } else if (index > 1 && index < 7) {
      continue;     // lewati angka 2-6 (meski di kasus ini tidak terpakai)
    }

    print(index); // cetak index jika tidak terkena continue/break
  }
}