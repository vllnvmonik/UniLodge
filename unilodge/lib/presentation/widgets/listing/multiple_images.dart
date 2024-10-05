import 'dart:io';
import 'package:flutter/material.dart';
import 'package:unilodge/presentation/widgets/listing/image_helper.dart';
import 'package:dotted_border/dotted_border.dart';

class MultipleImages extends StatefulWidget {
  const MultipleImages({super.key});

  @override
  State<MultipleImages> createState() => _MultipleImagesState();
}

class _MultipleImagesState extends State<MultipleImages> {
  List<File> _images = [];

  final double imageSize = 150.0;
  final double buttonSize = 100.0;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              GestureDetector(
                onTap: () async {
                  // Pick multiple images
                  final files = await ImageHelper().pickImage(multiple: true);
                  if (files.isNotEmpty) {
                    setState(() {
                      // Append new images to the existing ones
                      _images.addAll(files.map((e) => File(e!.path)).toList());
                    });
                  }
                },
                child: DottedBorder(
                  padding: const EdgeInsets.all(24.0),
                  borderType: BorderType.RRect,
                  radius: const Radius.circular(8.0),
                  color: Colors.grey,
                  strokeWidth: 2.0,
                  child: Container(
                    width: buttonSize,
                    height: buttonSize,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: const Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.add, size: 36.0, color: Colors.grey),
                        SizedBox(height: 8.0),
                        Text(
                          "Upload Photos",
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            color: Colors.grey,
                            fontSize: 16.0,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 10),
              if (_images.isNotEmpty)
                Image.file(
                  _images[0],
                  height: imageSize,
                  width: imageSize,
                  fit: BoxFit.cover,
                ),
            ],
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 10,
            runSpacing: 10,
            children: _images
                .skip(1)
                .map(
                  (e) => Image.file(
                    e,
                    height: imageSize,
                    width: imageSize,
                    fit: BoxFit.cover,
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}