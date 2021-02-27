import 'package:firebase_storage/firebase_storage.dart';

abstract class DB {
  Stream getData();
  Future<void> saveData(value);
  Future<void> updateData(value);
  Future<void> deleteData(value);
  getId();

  deleteImage({img}) async {
    try {
      StorageReference storage =
          await FirebaseStorage.instance.getReferenceFromUrl(img);
      await storage.delete();
    } catch (e) {
      print(e);
    }
  }
}
