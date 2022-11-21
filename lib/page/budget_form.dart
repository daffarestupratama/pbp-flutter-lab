import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/main.dart';
import 'package:flutter_assignment_app/page/drawer.dart';
import 'package:flutter_assignment_app/page/budget_data.dart';
import 'package:flutter_assignment_app/model/budget_class.dart';

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
        body: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Container(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      decoration: InputDecoration(
                          labelText: "Judul",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      onChanged: (String? value) {
                        setState(() {
                          _judul = value!;
                        });
                      },
                      onSaved: (String? value) {
                        setState(() {
                          _judul = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Judul tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          labelText: "Nominal",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          )),
                      onChanged: (String? value) {
                        setState(() {
                          _nominal = value!;
                        });
                      },
                      onSaved: (String? value) {
                        setState(() {
                          _nominal = value!;
                        });
                      },
                      validator: (String? value) {
                        if (value == null || value.isEmpty) {
                          return "Nominal tidak boleh kosong!";
                        }
                        return null;
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text("Pilih Jenis"),
                    trailing: DropdownButton(
                      value: _jenis,
                      items: listJenis.map((String iniJenis) {
                        return DropdownMenuItem(
                          value: iniJenis,
                          child: Text(iniJenis),
                        );
                      }).toList(),
                      onChanged: (String? newJenis) {
                        setState(() {
                          _jenis = newJenis!;
                        });
                      },
                    ),
                  ),
                  // create date picker inside list tile
                  Center(
                    child: ElevatedButton(
                      onPressed: () {
                        showDatePicker(
                          context: context,
                          initialDate: DateTime.now(),
                          firstDate: DateTime(2000),
                          lastDate: DateTime(2025),
                        ).then((value) {
                          setState(() {
                            _date = value;
                          });
                        });
                      },
                      child: Text("Pilih Tanggal"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
        floatingActionButton: Container(
          alignment: Alignment.bottomCenter,
          margin: const EdgeInsets.only(left: 30.0),
          child: TextButton(
            style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue),
              padding: MaterialStateProperty.all(
                const EdgeInsets.all(20.0),
              ),
            ),
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _formKey.currentState!.save();
                setState(() {
                  String tanggal = _date.toString();
                  tanggal = tanggal.substring(0, 10);
                  Budget newBudget = Budget(_judul, _nominal, _jenis, tanggal);
                  _budget.add(newBudget);
                });
                showDialog(
                  context: context,
                  builder: (context) {
                    String tanggal = _date.toString();
                    tanggal = tanggal.substring(0, 10);
                    return Dialog(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 15,
                      child: Container(
                        child: ListView(
                          padding: const EdgeInsets.only(top: 20, bottom: 20),
                          shrinkWrap: true,
                          children: <Widget>[
                            Center(
                                child: Column(
                              children: [
                                const Text(
                                  "Data berhasil disimpan!",
                                  style: TextStyle(
                                    fontSize: 15,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text("Judul: $_judul"),
                                Text("Nominal: $_nominal"),
                                Text("Jenis: $_jenis"),
                                Text("Tanggal: $tanggal"),
                              ],
                            )),
                            SizedBox(height: 20),
                            TextButton(
                              onPressed: () {
                                Navigator.pop(context);
                                setState(() {
                                  _judul = "";
                                  _nominal = "";
                                  _jenis = "Pemasukan";
                                });
                              },
                              child: Text('Kembali'),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }
            },
            child: const Text(
              "Simpan",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ));
  }
}
