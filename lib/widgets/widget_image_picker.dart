import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:alpaca/pages/moment/moment_add_controller.dart';
import 'dart:io';

class ImagePickerWidget extends StatelessWidget {
  final List<String> selectedImages;
  final Function(String) onImageAdded;
  final Function(int) onImageRemoved;

  ImagePickerWidget({
    required this.selectedImages,
    required this.onImageAdded,
    required this.onImageRemoved,
  });

  final ImagePicker _imagePicker = ImagePicker();

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 8.0,
        mainAxisSpacing: 8.0,
        childAspectRatio: 1.0,
      ),
      itemCount: selectedImages.length + 1,
      itemBuilder: (context, index) {
        if (index < selectedImages.length) {
          return Stack(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.file(
                  File(selectedImages[index]),
                  fit: BoxFit.cover,
                ),
              ),
              Positioned(
                top: -4.0,
                right: -4.0,
                child: Container(
                  width: 24.0,
                  height: 24.0,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.red.withOpacity(0.7),
                  ),
                  child: IconButton(
                    icon: Icon(
                      Icons.close,
                      size: 16.0,
                      color: Colors.white,
                    ),
                    onPressed: () => onImageRemoved(index),
                  ),
                ),
              ),
            ],
          );
        } else {
          return selectedImages.length < 9
              ? _buildAddImageButton()
              : Container();
        }
      },
    );
  }

  Widget _buildAddImageButton() {
    return InkWell(
      borderRadius: BorderRadius.circular(8.0),
      onTap: _pickImage,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8.0),
          border: Border.all(color: Colors.grey.withOpacity(0.3)),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.add,
              color: Colors.grey,
              size: 32.0,
            ),
            const SizedBox(height: 4.0),
            Text(
              '添加图片',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 12.0,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _pickImage() async {
    final pickedFile = await _imagePicker.pickImage(
      source: ImageSource.gallery,
    );

    if (pickedFile != null) {
      onImageAdded(pickedFile.path);
    }
  }
}
