import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/main.dart';
import 'package:flutter_assignment_app/page/drawer.dart';
import 'package:flutter_assignment_app/page/watchlist_detail_page.dart';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:flutter_assignment_app/model/watchlist.dart';

class MyWatchListPage extends StatefulWidget {
  // var myBudget;
  MyWatchListPage({super.key});

  @override
  State<MyWatchListPage> createState() => _MyWatchListState();
}

class _MyWatchListState extends State<MyWatchListPage> {
  Future<List<WatchList>> fetchWatchList() async {
    var url = Uri.parse('https://daffailham.herokuapp.com/mywatchlist/json/');
    var response = await http.get(
      url,
      headers: {
        "Access-Control-Allow-Origin": "*",
        "Content-Type": "application/json",
      },
    );

    // melakukan decode response menjadi bentuk json
    var data = jsonDecode(utf8.decode(response.bodyBytes));

    // melakukan konversi data json menjadi object ToDo
    List<WatchList> listWatchList = [];
    for (var d in data) {
      if (d != null) {
        listWatchList.add(WatchList.fromJson(d));
      }
    }

    return listWatchList;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("My Watch List"),
        ),
        drawer: MyDrawer(
            // theBudget: widget.myBudget,
            ),
        body: FutureBuilder(
            future: fetchWatchList(),
            builder: (context, AsyncSnapshot snapshot) {
              if (snapshot.data == null) {
                return const Center(child: CircularProgressIndicator());
              } else {
                if (!snapshot.hasData) {
                  return Column(
                    children: const [
                      Text(
                        "Tidak ada to watch list :(",
                        style:
                            TextStyle(color: Color(0xff59A5D8), fontSize: 20),
                      ),
                      SizedBox(height: 8),
                    ],
                  );
                } else {
                  return ListView.builder(
                    itemCount: snapshot.data!.length,
                    // itemBuilder: (_, index) => Container(
                    //       margin: const EdgeInsets.symmetric(
                    //           horizontal: 16, vertical: 12),
                    //       padding: const EdgeInsets.all(20.0),
                    //       decoration: BoxDecoration(
                    //           color: Colors.white,
                    //           borderRadius: BorderRadius.circular(15.0),
                    //           boxShadow: const [
                    //             BoxShadow(
                    //                 color: Colors.black, blurRadius: 2.0)
                    //           ]),
                    //       child: Column(
                    //         mainAxisAlignment: MainAxisAlignment.start,
                    //         crossAxisAlignment: CrossAxisAlignment.start,
                    //         children: [
                    //           Text(
                    //             "${snapshot.data![index].fields.title}",
                    //             style: const TextStyle(
                    //               fontSize: 18.0,
                    //               fontWeight: FontWeight.bold,
                    //             ),
                    //           ),
                    //           const SizedBox(height: 10),
                    //           Text(
                    //               "Sudah ditonton: ${snapshot.data![index].fields.watched}"),
                    //         ],
                    //       ),
                    //     ));
                    itemBuilder: (_, index) => ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => WatchlistDetailPage(movie: snapshot.data[index]),
                          ),
                        );
                      },
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                      ),
                      child: Text(
                        "${snapshot.data![index].fields.title}",
                        style: const TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  );
                }
              }
            }));
  }
}
