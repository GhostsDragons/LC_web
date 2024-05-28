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
        width: constraints.maxWidth/3,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              children: [
                Image.asset(
                  imgURL,
                  scale: 3,),
                const SizedBox(width: 10,),
                Text(name,),
              ],
            ),
            const SizedBox(width: 100,),
            Flexible(
                child: Text(
                    rev)),
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
  });

  final TextEditingController textController;
  final TextInputType keyboardType;
  final String label, hint;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: textController,
      keyboardType: keyboardType,
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
        if (value == null || value.isEmpty) {
          return 'Please enter value';
        }
        return null;
      },
    );
  }
}
