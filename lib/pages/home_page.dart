import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/super_hero_model.dart';
import '../widgets/add_hero_button.dart';
import 'add_hero_page.dart';
import 'edit_hero_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final nameTextController = TextEditingController();
  final nickNameTextController = TextEditingController();
  final imageTextController = TextEditingController();
  final quoteTextController = TextEditingController();

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
                                onPressed: () {
                                  editData(context, documents, index);
                                },
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

  Future<dynamic> editData(BuildContext context,
      List<QueryDocumentSnapshot<Map<String, dynamic>>> documents, int index) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          actions: [
            TextField(
              controller: nameTextController,
              decoration: const InputDecoration(
                labelText: 'Name',
              ),
            ),
            TextField(
              controller: nickNameTextController,
              decoration: const InputDecoration(
                labelText: 'Nick name',
              ),
            ),
            TextField(
              controller: imageTextController,
              decoration: const InputDecoration(
                labelText: 'Image URL',
              ),
            ),
            TextField(
              controller: quoteTextController,
              decoration: const InputDecoration(
                labelText: 'Quote',
              ),
            ),
            TextButton(
              onPressed: () {
                FirebaseFirestore.instance
                    .collection('heroes')
                    .doc(documents[index].id)
                    .update({
                  'real_name': nameTextController.text,
                  'nick_name': nickNameTextController.text,
                  'avatar_image': imageTextController.text,
                  'quote': quoteTextController.text,
                });
                nameTextController.clear();
                nickNameTextController.clear();
                quoteTextController.clear();
                imageTextController.clear();
                Navigator.of(context).pop();
              },
              child: const Text('Update your data'),
            ),
          ],
        );
      },
    );
  }
}
