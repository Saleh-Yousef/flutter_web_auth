import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomTextField extends StatefulWidget {
  final TextEditingController controller;
  final FocusNode? focusNode;
  final String? hintText;
  final String? errorMessage;

  final bool? readOnly;
  final bool? enabled;
  final bool? isFieldNotEmpty;
  final bool? obscureText;
  final bool? enableSuggestions;
  final bool? autocorrect;

  final TextInputType? keyboardType;
  final Widget? suffixIcon;
  final Widget? prefixIcon;

  List<TextInputFormatter>? inputFormatters;

  final Function(String text)? onChange;

  CustomTextField(
      {required this.controller,
      this.focusNode,
      required this.hintText,
      this.errorMessage = '',
      this.readOnly = false,
      this.enabled = true,
      this.isFieldNotEmpty = false,
      this.obscureText = false,
      this.enableSuggestions = true,
      this.autocorrect = true,
      this.keyboardType,
      this.suffixIcon,
      this.prefixIcon,
      this.inputFormatters,
      this.onChange});

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  StreamController<bool> textKeyboadVisibilityStream = StreamController<bool>.broadcast();
  @override
  void initState() {
    if (widget.focusNode != null) {
      widget.focusNode!.addListener(fieldListen);
      widget.controller.addListener(fieldListen);
    }

    super.initState();
  }

  void fieldListen() {
    textKeyboadVisibilityStream.sink.add(widget.focusNode!.hasFocus);
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<bool>(
        initialData: false,
        stream: textKeyboadVisibilityStream.stream,
        builder: (context, snapshot) {
          return TextField(
            obscureText: widget.obscureText!,
            readOnly: widget.readOnly!,
            keyboardAppearance: Brightness.light,
            inputFormatters: widget.inputFormatters,
            enabled: widget.enabled,
            focusNode: widget.focusNode,
            enableSuggestions: widget.enableSuggestions!,
            autocorrect: widget.autocorrect!,
            style: const TextStyle(color: Color(0xff191C1F), fontSize: 14),
            controller: widget.controller,
            keyboardType: widget.keyboardType,
            cursorColor: const Color(0xff191C1F),
            decoration: InputDecoration(
                errorText: widget.errorMessage!.isNotEmpty && widget.isFieldNotEmpty! ? widget.errorMessage : null,
                errorStyle: const TextStyle(color: Color(0xffE04E4D), fontSize: 14),
                labelText: widget.hintText,
                labelStyle: snapshot.data! || widget.controller.text.isNotEmpty
                    ? TextStyle(color: widget.isFieldNotEmpty! ? const Color(0xffE04E4D) : const Color(0xff1F1F1F))
                    : const TextStyle(color: Color(0xff384048)),
                enabledBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.isFieldNotEmpty! ? const Color(0xffE04E4D) : const Color(0xffE8E8E8)),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.isFieldNotEmpty! ? const Color(0xffE04E4D) : const Color(0xffE8E8E8)),
                ),
                border: OutlineInputBorder(
                  borderSide: BorderSide(color: widget.isFieldNotEmpty! ? const Color(0xffE04E4D) : const Color(0xffE8E8E8)),
                ),
                suffixIcon: widget.suffixIcon,
                prefixIcon: widget.prefixIcon,
                filled: true,
                fillColor: const Color(0xffFFFFFF)),
            onChanged: (text) {
              if (widget.onChange != null) {
                widget.onChange!(text);
              }
            },
          );
        });
  }
}
