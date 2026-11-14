import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';

class MediaService {
  MediaService({ImagePicker? picker}) : _picker = picker ?? ImagePicker();

  final ImagePicker _picker;

  Future<String?> pickImage({
    required ImageSource source,
    required String prefix,
    int maxWidth = 1600,
    int imageQuality = 88,
  }) async {
    final picked = await _picker.pickImage(
      source: source,
      maxWidth: maxWidth.toDouble(),
      imageQuality: imageQuality,
    );
    if (picked == null) return null;
    final dir = await getApplicationSupportDirectory();
    final mediaDir = Directory(p.join(dir.path, 'media'));
    if (!await mediaDir.exists()) await mediaDir.create(recursive: true);
    final extension = p.extension(picked.path).isEmpty
        ? '.jpg'
        : p.extension(picked.path);
    final target = File(
      p.join(
        mediaDir.path,
        '${prefix}_${DateTime.now().millisecondsSinceEpoch}$extension',
      ),
    );
    await File(picked.path).copy(target.path);
    return target.path;
  }

  Future<void> delete(String? path) async {
    if (path == null || path.trim().isEmpty) return;
    final file = File(path);
    if (await file.exists()) await file.delete();
  }
}
