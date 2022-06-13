import 'package:cloud_firestore/cloud_firestore.dart';
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
        child: Column(
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
            StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
                stream:
                    FirebaseFirestore.instance.collection('heroes').snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  } else if (snapshot.connectionState ==
                      ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  final documents = snapshot.data!.docs;

                  return SuperHeroModel(
                    realName: (documents[0]['real_name']),
                    nickName: (documents[0]['nick_name']),
                    avatarImage: (documents[0]['avatar_image']),
                    quote: (documents[0]['quote']),
                  );
                }),
            const AddHeroButton(),
          ],
        ),
      ),
    );
  }
}
