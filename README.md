# Tugas PBP Flutter
Nama : Daffa Ilham Restupratama  
NPM : 2106751013  
Kelas : PBP-B
<br> <br> <br>

# Tugas 7

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

<br> <br> <br>

# Tugas 8

## Perbedaan ```Navigator.push``` dan ```Navigator.pushReplacement```
- ```Navigator.push``` berfungsi untuk manambahkan route layar baru ke dalam navigasi
- ```Navigator.pushReplacement`` berfungsi untuk mengganti seluruh route yang telah ada di stack dengan yang baru.  

## Widget yang Dipakai
- Container, berfungsi untuk menampung widget-widget lainnya
- Drawer, berfungsi untuk membuat drawer/hamburger menu pada sisi layar
- ListTile, berfungsi untuk membuat elemen yang berisikan teks
- ListView, berfungsi untuk menampilkan list
- Form, berfungsi untuk membuat input form
- Column, berfungsi untuk menampung widget-widget secara vertikal
- SingleChildScrollView, berfungsi untuk membuat widget didalamnya menjadi scrollable
- DropdownButton, berfungsi untuk membuat tombol dropdown
- ElevatedButton, berfungsi untuk membuat tombol elevated  

## Jenis Event di Flutter
- onPressed, terjadi ketika widget ditekan
- onTap, terjadi ketika widget di-tap
- onChanged, terjadi ketika widget berubah
- onSaved, terjadi ketika widget disimpan  

## Cara Kerja Navigator
Navigator mengatur *stack of route* dan menyediakan dua cara untuk mengaturnya, yaitu secara *declarative* dan *imperative*. *Declarative* menggunakan ```Navigator.pages```, sedangkan *imperative* ```Navigator.push``` dan ```Navigator.pop```.  

## Implementasi Tugas
1. Membuat drawer di dalam file terpisah dan mengatur route layar
```dart
class MyDrawer extends StatefulWidget {
  var theBudget;
  MyDrawer({super.key, this.theBudget});

  @override
  State<MyDrawer> createState() => _MyDrawerState();
}

class _MyDrawerState extends State<MyDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: [
          ListTile(
            title: const Text("counter_7"),
            onTap: () {
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => const MyApp()));
            },
          ),
          ListTile(
            title: const Text("Tambah Budget"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => FormBudget(myBudget: widget.theBudget,)),
              );
            },
          ),
          ListTile(
            title: const Text("Data Budget"),
            onTap: () {
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DataBudget(
                            myBudget: widget.theBudget,
                          )));
            },
          ),
        ],
      ),
    );
  }
}
```

2. Membuat kelas untuk instansiasi data budget
```dart
class Budget {
  String judul;
  String nominal;
  String jenis;
  String date;

  Budget(this.judul, this.nominal, this.jenis, this.date);
}
```

3. Membuat halaman baru untuk menampilkan input form budget
```dart
...
...
class FormBudget extends StatefulWidget {
  var myBudget;
  FormBudget({super.key, this.myBudget});

  @override
  State<FormBudget> createState() => _FormBudgetState();
}

class _FormBudgetState extends State<FormBudget> {
  List<Budget> _budget = [];
  final _formKey = GlobalKey<FormState>();
  String _judul = "";
  String _nominal = "";
  String _jenis = "Pemasukan";
  List<String> listJenis = ["Pemasukan", "Pengeluaran"];

  // create variable for date from date picker
  DateTime? _date;

  @override
  Widget build(BuildContext context) {
    if (widget.myBudget != null) {
      _budget.addAll(widget.myBudget);
    }
    return Scaffold(
        appBar: AppBar(
          title: Text("Form Budget"),
        ),
        drawer: MyDrawer(
          theBudget: _budget,
        ),
...
...
```

4. Membuat halaman baru untuk menampilkan data budget
```dart
...
...
class DataBudget extends StatefulWidget {
  var myBudget;
  DataBudget({super.key, this.myBudget});

  @override
  State<DataBudget> createState() => _DataBudgetState();
}

class _DataBudgetState extends State<DataBudget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data Budget"),
      ),
      drawer: MyDrawer(
        theBudget: widget.myBudget,
      ),
...
...
```

5. Menghubungkan/menampilkan drawer pada tiap screen
```dart
...
...
   drawer: MyDrawer(),
...
...
```