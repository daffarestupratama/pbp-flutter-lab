import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/main.dart';
import 'package:flutter_assignment_app/page/budget_form.dart';
import 'package:flutter_assignment_app/page/budget_data.dart';
import 'package:flutter_assignment_app/page/mywatchlist_page.dart';

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
          ListTile(
            title: const Text("My Watch List"),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => MyWatchListPage()));
            },
          ),
        ],
      ),
    );
  }
}