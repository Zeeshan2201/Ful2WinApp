import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

/// Opens a bottom sheet to select media (camera or gallery).
Future<List<XFile>?> selectMediaWithSourceBottomSheet({
  required BuildContext context,
  bool allowPhoto = true,
  bool allowVideo = false,
  bool allowMultiple = false,
}) async {
  final picker = ImagePicker();

  if (allowMultiple && allowPhoto) {
    return await picker.pickMultiImage();
  } else if (allowPhoto) {
    final file = await picker.pickImage(source: ImageSource.gallery);
    return file != null ? [file] : null;
  } else if (allowVideo) {
    final file = await picker.pickVideo(source: ImageSource.gallery);
    return file != null ? [file] : null;
  }

  return null;
}

/// Validates file extension.
bool validateFileFormat(String path, BuildContext context) {
  final validExtensions = ['jpg', 'jpeg', 'png', 'gif', 'mp4', 'mov'];
  final ext = path.split('.').last.toLowerCase();
  return validExtensions.contains(ext);
}
