import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AddHeroButton extends StatelessWidget {
  const AddHeroButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 30,
        bottom: 10,
        left: 20,
        right: 20,
      ),
      child: InkWell(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color.fromARGB(255, 113, 7, 85),
              width: 5,
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 8),
            child: Center(
              child: Text(
                'Add Super Hero!',
                style: GoogleFonts.abrilFatface(
                  fontSize: 40,
                  color: const Color.fromARGB(255, 113, 7, 85),
                ),
              ),
            ),
          ),
        ),
        onTap: () {},
      ),
    );
  }
}
