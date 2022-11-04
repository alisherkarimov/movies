import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:movies/movie_model.dart';
import 'package:movies/src/pages/input_page.dart';

import 'home_metods/build_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final moviesRef = FirebaseFirestore.instance
        .collection('movies')
        .withConverter<Movie>(
            fromFirestore: (snapshot, _) => Movie.fromJson(snapshot.data()!),
            toFirestore: (movie, _) => movie.toJson());

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          title: const Text('Kinolar'),
          centerTitle: true,
          elevation: 0.0,
          actions: [
            IconButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const InputPage(),
                      ));
                },
                icon: const Icon(Icons.add, size: 30)),
            const SizedBox(width: 8),
          ],
        ),
        body: StreamBuilder<QuerySnapshot<Movie>>(
          stream: moviesRef.snapshots(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            }
            final data = snapshot.requireData;
            return ListView.separated(
              separatorBuilder: (context, index) {
                return const Divider(height: 2, color: Colors.greenAccent);
              },
              itemCount: data.size,
              itemBuilder: (context, index) {
                final movieData = data.docs[index].data();
                return BuildItem(movieData);
              },
            );
          },
        ),
      ),
    );
  }
}
