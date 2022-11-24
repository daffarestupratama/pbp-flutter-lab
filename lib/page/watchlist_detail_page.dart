import 'package:flutter/material.dart';
import 'package:flutter_assignment_app/main.dart';
import 'package:flutter_assignment_app/page/drawer.dart';
import 'package:flutter_assignment_app/page/mywatchlist_page.dart';

import 'dart:convert';
import 'package:flutter_assignment_app/model/watchlist.dart';

class WatchlistDetailPage extends StatefulWidget {
  var movie;
  WatchlistDetailPage({super.key, this.movie});

  @override
  State<WatchlistDetailPage> createState() => _WatchlistDetailState();
}

class _WatchlistDetailState extends State<WatchlistDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Detail"),
      ),
      drawer: MyDrawer(),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Center(
              child: Text(
                "${widget.movie.fields.title}",
                style:
                    const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  "Release Date: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${widget.movie.fields.releaseDate}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  "Rating: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                Text("${widget.movie.fields.rating}/5"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: [
                const Text(
                  "Status: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
                if (widget.movie.fields.watched == "true") ...[
                  const Text("Watched")
                ] else ...[
                  const Text("Not Watched"),
                ],
                // Text("${widget.movie.fields.releaseDate}"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Row(
              children: const [
                Text(
                  "Review: ",
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10.0),
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "${widget.movie.fields.review}",
                    overflow: TextOverflow.visible,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.only(left: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 350,
              height: 50,
              child: FloatingActionButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)),
                child: const Text("Back"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
