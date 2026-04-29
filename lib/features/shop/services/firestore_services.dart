import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sneaker_app/features/shop/models/shoe_model.dart';

class FirestoreServices {
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Stream<List<Shoe>> getShoeStream() {
    return firestore.collection('shoes').snapshots().map((snapshot) {
      return snapshot.docs.map((doc) {
        final data = doc.data();
        return Shoe.fromMap(data);
      }).toList();
    });
  }

  Future<void> uploadShoesToFirebase(List<Shoe> localShoeList) async {
    // Future.wait tells Flutter: "Pause here until all 5 of these background tasks are 100% finished."
    await Future.wait(
      localShoeList.map(
        (shoe) => firestore.collection('shoes').add(shoe.toMap()),
      ),
    );

    // NOW this print statement is telling the truth!
    print("ALL SHOES UPLOADED TO FIREBASE! 🚀");
  }
}
