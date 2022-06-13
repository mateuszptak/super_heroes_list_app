import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/super_hero_model.dart';
import '../widgets/add_hero_button.dart';

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: SafeArea(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.center,
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text(
                  'Meet the...',
                  style: GoogleFonts.abrilFatface(
                    fontSize: 25,
                    color: const Color.fromARGB(255, 113, 7, 85),
                  ),
                ),
              ),
            ),
            const SuperHeroModel(
              realName: 'Bruce Vayne',
              nickName: 'Batman',
              avatarImage:
                  'https://i1.sndcdn.com/avatars-000304411295-zx2krs-t500x500.jpg',
              quote:
                  'It\'s not who I am underneath, but what I do that defines me.',
            ),
            const AddHeroButton(),
          ],
        ),
      ),
    );
  }
}
