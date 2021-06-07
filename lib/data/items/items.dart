import 'package:cloud_firestore/cloud_firestore.dart';
import '../../models/category/category.dart';

import '../../models/item/item.dart';

///
final List<Item> itemsForSale = [
  Item(
      id: '1',
      sellerId: 'ghlgyYBrKkWkzuGtBROPDmrGuaE3',
      title: 'Slightly used hand mixer for grabs',
      description: 'This nice mixer is just for you!',
      condition: 'used',
      price: 500,
      category: const Category(categoryId: '', name: 'Kitchen'),
      mainImageUrl: 'assets/hand_mixer.jpg',
      otherImageUrls: const [
        'assets/oven.jpg',
        'assets/pacoleta.jpg',
        'assets/utensils.jpg',
        'assets/soap.jpg'
      ],
      timestamp: Timestamp.now()),
  Item(
      id: '2',
      sellerId: 'ghlgyYBrKkWkzuGtBROPDmrGuaE3',
      title: 'A nice electronic oven for sale',
      description: 'A wonderful oven for easy life',
      condition: 'used',
      price: 500,
      category: const Category(categoryId: '', name: 'Kitchen'),
      mainImageUrl: 'assets/oven.jpg',
      otherImageUrls: const [
        'assets/hand_mixer.jpg',
        'assets/pacoleta.jpg',
        'assets/utensils.jpg',
        'assets/soap.jpg'
      ],
      timestamp: Timestamp.now()),
  Item(
      id: '3',
      sellerId: 'ghlgyYBrKkWkzuGtBROPDmrGuaE3',
      title: 'Electric kettle',
      description: 'An affordable electric kettle to make life easy for you',
      condition: 'used',
      price: 500,
      category: const Category(categoryId: '', name: 'Kitchen'),
      mainImageUrl: 'assets/pacoleta.jpg',
      otherImageUrls: const [
        'assets/utensils.jpg',
        'assets/oven.jpg',
        'assets/hand_mixer.jpg',
        'assets/soap.jpg'
      ],
      timestamp: Timestamp.now()),
  Item(
      id: '4',
      sellerId: 'ghlgyYBrKkWkzuGtBROPDmrGuaE3',
      title: 'Complete kitchen utensils set',
      description: 'A complete set of kitchen items for sale',
      condition: 'used',
      price: 500,
      category: const Category(categoryId: '', name: 'Kitchen'),
      mainImageUrl: 'assets/utensils.jpg',
      otherImageUrls: const [
        'assets/pacoleta.jpg',
        'assets/oven.jpg',
        'assets/hand_mixer.jpg',
        'assets/soap.jpg'
      ],
      timestamp: Timestamp.now()),
  Item(
      id: '4',
      sellerId: 'ghlgyYBrKkWkzuGtBROPDmrGuaE3',
      title: 'Complete kitchen utensils set',
      description: 'A complete set of kitchen items for sale',
      condition: 'used',
      price: 500,
      category: const Category(categoryId: '', name: 'Kitchen'),
      mainImageUrl: 'assets/soap.jpg',
      otherImageUrls: const [
        'assets/hand_mixer.jpg',
        'assets/pacoleta.jpg',
        'assets/oven.jpg',
        'assets/utensils.jpg'
      ],
      timestamp: Timestamp.now()),
];
