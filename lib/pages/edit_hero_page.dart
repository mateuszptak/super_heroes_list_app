import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../widgets/add_hero_button.dart';

class EditHeroPage extends StatefulWidget {
  const EditHeroPage({Key? key}) : super(key: key);

  @override
  State<EditHeroPage> createState() => _AddHeroPageState();
}

class _AddHeroPageState extends State<EditHeroPage> {
  final nameTextController = TextEditingController();
  final nickNameTextController = TextEditingController();
  final imageTextController = TextEditingController();
  final quoteTextController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          children: [
            Align(
              alignment: Alignment.topLeft,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: Colors.black,
                    size: 50,
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ),
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    EditHeroTextField(
                      controller: nameTextController,
                      hintText: 'Name',
                      onClear: () {},
                    ),
                    EditHeroTextField(
                      controller: nickNameTextController,
                      hintText: 'Nick Name',
                      onClear: () {
                        nameTextController.clear();
                      },
                    ),
                    EditHeroTextField(
                      controller: imageTextController,
                      hintText: 'Image URL: https:// ... .jpg',
                      onClear: () {
                        nameTextController.clear();
                      },
                    ),
                    EditHeroTextField(
                      controller: quoteTextController,
                      hintText: 'Quote',
                      onClear: () {
                        nameTextController.clear();
                      },
                    ),
                    AddHeroButton(
                      onPressed: () {
                        FirebaseFirestore.instance.collection('heroes').add({
                          'real_name': nameTextController.text,
                          'nick_name': nickNameTextController.text,
                          'avatar_image': imageTextController.text,
                          'quote': quoteTextController.text,
                        });
                        Navigator.of(context).pop();
                      },
                      text: 'Edit hero!',
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class EditHeroTextField extends StatelessWidget {
  const EditHeroTextField({
    Key? key,
    required this.controller,
    required this.hintText,
    required this.onClear,
  }) : super(key: key);

  final TextEditingController controller;
  final String hintText;
  final VoidCallback onClear;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          border: Border.all(
            color: const Color.fromARGB(255, 113, 7, 85),
            width: 3,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: controller,
            textInputAction: TextInputAction.done,
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: hintText,
              hintStyle: const TextStyle(fontSize: 24),
              suffixIcon: IconButton(
                icon: const Icon(
                  Icons.clear,
                  color: Colors.black,
                ),
                onPressed: () {
                  onClear;
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
