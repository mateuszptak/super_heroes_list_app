import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SuperHeroModel extends StatefulWidget {
  const SuperHeroModel({
    Key? key,
    required this.realName,
    required this.nickName,
    required this.avatarImage,
    required this.quote,
  }) : super(key: key);

  final String realName;
  final String nickName;
  final String avatarImage;
  final String quote;

  @override
  State<SuperHeroModel> createState() => _SuperHeroModelState();
}

class _SuperHeroModelState extends State<SuperHeroModel> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.7,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              '${widget.realName}:',
              textAlign: TextAlign.center,
              style: GoogleFonts.shadowsIntoLight(
                fontWeight: FontWeight.bold,
                fontSize: 40,
                height: 0.1,
                color: const Color.fromARGB(255, 113, 7, 85),
              ),
            ),
            Text(
              widget.nickName,
              textAlign: TextAlign.center,
              style: GoogleFonts.dancingScript(
                fontWeight: FontWeight.w900,
                fontSize: 60,
                height: 1,
                color: const Color.fromARGB(255, 113, 7, 85),
              ),
            ),
            CircleAvatar(
              backgroundColor: Colors.black,
              radius: 130,
              child: CircleAvatar(
                radius: 123,
                backgroundImage: NetworkImage(widget.avatarImage),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 20, right: 20),
              child: Text(
                widget.quote,
                maxLines: 3,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: Color.fromARGB(255, 82, 25, 48),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
