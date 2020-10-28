part of 'shared.dart';

Future<File> getImageGallery() async {
  var image = await ImagePicker.pickImage(source: ImageSource.gallery);
  return image;
}

Future<File> getImageCamera() async {
  var image = await ImagePicker.pickImage(source: ImageSource.camera);
  return image;
}

Future<String> uploadImage(File image, StorageUploadTask uploadTask) async {
 String fileName = basename(image.path);

  StorageReference ref = FirebaseStorage.instance.ref().child(fileName);
  uploadTask = ref.putFile(image);
  StorageTaskSnapshot snapshot = await uploadTask.onComplete;

  return await snapshot.ref.getDownloadURL();
}

Widget generateDashedDivider(double width) {
  int n = width ~/ 5;
  return Row(
    children: List.generate(
        n,
        (index) => (index % 2 == 0)
            ? Container(
                height: 2,
                width: width / n,
                color: Color(0xFFE4E4E4),
              )
            : SizedBox(
                width: width / n,
              )),
  );
}
