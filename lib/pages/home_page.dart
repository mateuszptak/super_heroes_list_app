import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/super_hero_model.dart';
import '../widgets/add_hero_button.dart';
import 'add_hero_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              stream: FirebaseFirestore.instance
                  .collection('heroes')
                  .orderBy('nick_name')
                  .snapshots(),
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
                return Expanded(
                  child: PageView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: snapshot.data?.docs.length,
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          SuperHeroModel(
                            realName: (documents[index]['real_name']),
                            nickName: (documents[index]['nick_name']),
                            avatarImage: (documents[index]['avatar_image']),
                            quote: (documents[index]['quote']),
                          ),
                          // delete hero
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              IconButton(
                                onPressed: () {
                                  FirebaseFirestore.instance
                                      .collection('heroes')
                                      .doc(documents[index].id)
                                      .delete();
                                },
                                icon: const Icon(
                                  Icons.delete,
                                  size: 35,
                                  color: Color.fromARGB(255, 82, 25, 48),
                                ),
                              ),
                              // edit hero
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.edit,
                                  size: 35,
                                  color: Color.fromARGB(255, 82, 25, 48),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
                );
              },
            ),
            AddHeroButton(
              text: 'Add Super Hero!',
              onPressed: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => const AddHeroPage(),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
