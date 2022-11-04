import 'package:flutter/material.dart';
import 'package:movies/movie_model.dart';

import 'info_film.dart';

class BuildItem extends StatefulWidget {
  Movie movie;

  BuildItem(this.movie, {Key? key}) : super(key: key);

  @override
  State<BuildItem> createState() => _BuildItemState();
}

class _BuildItemState extends State<BuildItem> {
  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 12,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          FadeInImage(
            width: 120,
            image: NetworkImage(widget.movie.image!),
            placeholder: const AssetImage("assets/images/defaultImage.png"),
          ),
          const SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              InfoFilm("name", widget.movie.name!),
              InfoFilm("year", widget.movie.year.toString()),
              InfoFilm("genre", widget.movie.genre!),
            ],
          ),
          if (true) const SizedBox(width: 20),
        ],
      ),
    );
  }
}
