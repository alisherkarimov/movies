import 'package:flutter/cupertino.dart';

class InfoFilm extends StatelessWidget {
  String keyName;
  String value;

  InfoFilm(this.keyName, this.value, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("$keyName: ",
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
          Text(value,
              style:
                  const TextStyle(fontSize: 20, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
