// import 'package:cloud_firestore/cloud_firestore.dart';

// import '../../models/item/donation.dart';
// import '../../models/item/item.dart';
// import '../../utils/paths.dart';
// import '../item/item_repository.dart';

// ///
// class DonationRepository extends ItemRepository {
//   final _firebaseFirestore = FirebaseFirestore.instance;

//   ///
//   Future<void> donate(Item item) async {
//     final _donation = Donation(
//         id: item.id,
//         donorId: item.sellerId,
//         donorPhone: item.sellerPhoneNumber,
//         mainImageUrl: item.mainImageUrl,
//         title: item.title,
//         description: item.description,
//         category: item.category,
//         condition: item.condition,
//         donatedAt: item.createdAt);

//     await _firebaseFirestore
//         .collection(Paths.donations)
//         .add(_donation.toDocument());

//     await delete(item);
//   }
// }
