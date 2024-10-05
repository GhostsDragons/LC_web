import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';
import 'package:lc_web/Firebase/_auth.dart';

class Storage {
  final user = Auth().getUser();
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Future<String> updateProfilePic(String folder, XFile? file) async {
    try {
      if (file != null) {
        Blob blob = Blob(await file.readAsBytes());
        final imagePath = "$folder/${user!.uid}/profilePicture.jpg";
        Reference imageRef = _storage.ref().child(imagePath);

        await imageRef.putBlob(blob.bytes);

        final downloadURL = await imageRef.getDownloadURL();
        return downloadURL;
      } else {
        return ("");
      }
    } catch (e) {
      // TODO: Error handling
      print(e);
    }
    return ("");
  }

  Future<void> updateDatabase(String collection, Map data) async {
    data.forEach((key, value) {
      _firestore.collection(collection).doc(user!.uid).update({
        key: value,
      });
    });
  }
}