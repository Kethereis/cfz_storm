import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../utils/colors.dart';

class CustomTextField extends StatelessWidget {
  final String labelText;
  final TextEditingController controller;
  final ValueChanged<String>? onChanged;
  final int? convenioDadosId;
  final bool? inputEnabled;
  final TextInputFormatter? mask;
  const CustomTextField({
    Key? key,
    this.onChanged,
    this.mask,
    required this.labelText,
    required this.controller,
    this.convenioDadosId,
    this.inputEnabled,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
      child: SizedBox(
        width: MediaQuery.of(context).size.width * 0.12,
        height: MediaQuery.of(context).size.height * 0.07,
        child: TextFormField(
          enabled: inputEnabled,
          onChanged: onChanged,
          controller: controller,
          textCapitalization: TextCapitalization.words,
          keyboardType: TextInputType.text,
          inputFormatters: mask != null ? [mask!] : null,
          decoration: InputDecoration(
            filled: true,
            labelText: labelText,
            hintText: '',
            border: const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(0.0)),
              borderSide: BorderSide(
                  color: Colors.white,
                  width: 1.0),
            ),
            enabledBorder:
            const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(0.0)),
              borderSide: BorderSide(
                  color: Colors.black12,
                  width: 1.0),
            ),
            focusedBorder:
            const OutlineInputBorder(
              borderRadius: BorderRadius.all(
                  Radius.circular(0.0)),
              borderSide: BorderSide(
                  color: Colors.black12,
                  width: 1.0),
            ),
            contentPadding:
            const EdgeInsets.symmetric(
                vertical: 10.0,
                horizontal: 10.0),
            fillColor: Colors.white
                .withOpacity(0.4),
          ),
        ),
      ),
    );
  }
}
