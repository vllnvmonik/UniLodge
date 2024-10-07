import 'dart:io';
import 'package:flutter/material.dart';
import 'package:unilodge/core/configs/theme/app_colors.dart';
import 'package:unilodge/data/models/listing.dart';
import 'package:unilodge/presentation/widgets/listing/multiple_images.dart';
import 'package:go_router/go_router.dart';

class PostImage extends StatefulWidget {
  const PostImage({super.key, required this.listing});
  final Listing listing;

  @override
  _PostImageState createState() => _PostImageState();
}

class _PostImageState extends State<PostImage> {
  List<File> selectedImages = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                child: SingleChildScrollView(
                  padding: EdgeInsets.symmetric(horizontal: 16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 60),
                      const Text(
                        'Add property images',
                        style: TextStyle(
                          color: AppColors.primary,
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 7),
                      const Text(
                        'Upload at least 6 images',
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.normal,
                          color: AppColors.primary,
                        ),
                      ),
                      const SizedBox(height: 20),
                      // Pass callback to MultipleImages
                      MultipleImages(
                        onImagesSelected: (images) {
                          setState(() {
                            selectedImages = images;
                          });
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: Padding(
              padding: const EdgeInsets.all(1.0),
              child: Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: const BorderRadius.horizontal(),
                  boxShadow: [
                    BoxShadow(
                      color: const Color.fromARGB(255, 119, 119, 119)
                          .withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                padding: const EdgeInsets.symmetric(
                    vertical: 10.0, horizontal: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    OutlinedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: OutlinedButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.transparent,
                        side: const BorderSide(color: Colors.black, width: 1),
                        minimumSize: const Size(120, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text("Back"),
                    ),
                    const SizedBox(width: 20),
                    ElevatedButton(
                      onPressed: selectedImages.length >=
                              6 // Ensure at least 6 images
                          ? () {
                              // Pass the updated listing object to the PostReview page
                              context.push(
                                '/post-review',
                                extra: widget.listing.copyWith(
                                  imageUrl: selectedImages.map((e) => e.path).join(
                                      ','), // Convert to comma-separated string
                                ),
                              );
                            }
                          : null, // Disable if less than 6 images
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: const Color(0xff2E3E4A),
                        minimumSize: const Size(120, 50),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                        elevation: 0,
                      ),
                      child: const Text('Next'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
