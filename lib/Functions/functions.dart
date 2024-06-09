import 'package:flutter/material.dart';

class Reviews extends StatelessWidget {
  const Reviews({
    super.key,
    required this.name,
    required this.imgURL,
    required this.rev,
    required this.constraints,
  });

  final String name, imgURL, rev;
  final BoxConstraints constraints;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(25.0),
      child: SizedBox(
        width: constraints.maxWidth / 3,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            FittedBox(
              fit: BoxFit.contain,
              child: Row(
                children: [
                  CircleAvatar(
                    backgroundImage: AssetImage(
                      imgURL,
                    ),
                    radius: 30,
                  ),
                  const SizedBox(
                    width: 20,
                  ),
                  Text(
                    name,
                    style: const TextStyle(
                        fontFamily: 'Unbounded',
                        fontSize: 30,
                        fontWeight: FontWeight.w300,
                        color: Color(0xcc1F3E3C)),
                  ),
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            // FittedBox(
            //   fit: BoxFit.fitHeight,
            Flexible(
                child: Text(
              rev,
              style: const TextStyle(
                fontFamily: 'Archivo',
                fontSize: 15,
                color: Color(0xff1F3E3C),
              ),
            )),
          ],
        ),
      ),
    );
  }
}

class FormInput extends StatelessWidget {
  const FormInput({
    super.key,
    required this.textController,
    required this.keyboardType,
    required this.label,
    required this.hint,
    this.obsTxt = false,
    this.vis = true
  });

  final TextEditingController textController;
  final TextInputType keyboardType;
  final String label, hint;
  final bool obsTxt, vis;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: keyboardType,
      obscureText: obsTxt,
      decoration: InputDecoration(
        labelText: label,
        hintText: hint,
        fillColor: Colors.white,
        contentPadding: const EdgeInsets.all(15),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(
            color: Colors.grey,
          ),
        ),
      ),
      validator: (value) {
        if ((value == null || value.isEmpty) && vis) {
          return 'Please enter value';
        }
        return null;
      },
    );
  }
}
