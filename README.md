# Tugas PBP Flutter
Nama : Daffa Ilham Restupratama  
NPM : 2106751013  
Kelas : PBP-B

## Perbedaan stateless widget dan stateful widget
- Stateless widget merupakan widget yang bersifat tetap sehingga tampilan dan data di dalamnya tidak dapat berubah (terhadap pengguna).
- Stateful widget merupakan widget yang bersifat dinamis sehingga dapat berubah-ubah, dapat berinteraksi dengan data, hingga dapat merespons event atau interaksi dari pengguna.

## Widget yang dipakai pada proyek ini
- FloatingActionButton
- Scaffold
- AppBar
- Column
- Row
- Text
- Padding
- Spacer
- Icon

## Fungsi dari setState()
setState() berfungsi untuk mentrigger framework bahwa objek ataupun data-data di dalamnya telah berubah sehingga tampilan pada layar perlu di-update. Setelah fungsi setState() dipangggil, maka framework akan menjalankan build() untuk meng-update/me-reload tampilan UI.

## Perbedaan const dan final
Keduanya sama-sama tidak dapat diubah lagi setelah diinisialisasi, sedangkan perbedaannya yaitu
- Const : Value harus diketahui saat waktu compile  
Contoh penerapannya :
```dart
const tahun = 2022;
```
- Final : Value harus diketahui saat runtime, dan jika yang bertipe final adalah objek maka child di dalam objek tersebut masih dapat diubah selama tidak bertipe final atau const.
Contoh penerapannya :
```dart
final tahun = getTahun()
```

## Implementasi checklist
1) Membuat variabel yang menyimpan nilai counter dan membuat fungsi yang dapat menambah atau mengurangi nilai counter.
```dart
int _counter = 0;

void _incrementCounter() {
    setState(() {
        _counter++;
    });
}

void _decrementCounter() {
    setState(() {
      
        _counter--;
    });
}
```

2) Membuat tampilan nilai counter dan paritas counter dengan conditional statement di dalam kolom body
```dart
children: <Widget>[
    if (_counter % 2 == 0) ...[
        const Text(
            'GENAP',
            style: TextStyle(color: Colors.red),
        ),
    ] else ...[
        const Text(
            'GANJIL',
            style: TextStyle(color: Colors.blue),
        ),
    ],
    Text(
       '$_counter',
        style: Theme.of(context).textTheme.headline4,
    ),
],
```

3) Membuat floating button dan menghubungkannya dengan fungsi penambah dan pengurang nilai counter
```dart
floatingActionButton: Padding(
    padding: const EdgeInsets.only(left: 32),
    child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            if (_counter > 0) ...[
                FloatingActionButton(
                    onPressed: _decrementCounter,
                    tooltip: 'Decrement',
                    child: const Icon(Icons.remove),
                )
            ],
            const Spacer(),
            FloatingActionButton(
                onPressed: _incrementCounter,
                tooltip: 'Increment',
                child: const Icon(Icons.add),
            ),
        ],
    ),
),
```