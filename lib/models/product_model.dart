import 'package:cloud_firestore/cloud_firestore.dart';

class ProductModel {
  String id;

  String name;
  int price;
  int stock;
  bool isActive;

  String? imageUrl;
  String? sku;
  String? description;
  String? categoryId;

  int sold;
  int views;

  int? costPrice;
  int? discountPrice;
  bool isDiscount;

  Timestamp? createdAt;
  Timestamp? updatedAt;

  ProductModel({
    required this.id,
    required this.name,
    required this.price,
    required this.stock,
    required this.isActive,

    this.imageUrl,
    this.sku,
    this.description,
    this.categoryId,

    this.sold = 0,
    this.views = 0,

    this.costPrice,
    this.discountPrice,
    this.isDiscount = false,

    this.createdAt,
    this.updatedAt,
  });

  factory ProductModel.fromFirestore(
      String id,
      Map<String, dynamic> data,
      ) {
    return ProductModel(
      id: id,
      name: data['name'] ?? '',
      price: (data['price'] ?? 0) as int,
      stock: (data['stock'] ?? 0) as int,
      isActive: data['isActive'] ?? true,

      imageUrl: data['imageUrl'],
      sku: data['sku'],
      description: data['description'],
      categoryId: data['categoryId'],

      sold: data['sold'] ?? 0,
      views: data['views'] ?? 0,

      costPrice: data['costPrice'],
      discountPrice: data['discountPrice'],
      isDiscount: data['isDiscount'] ?? false,

      createdAt: data['createdAt'],
      updatedAt: data['updatedAt'],
    );
  }

  Map<String, dynamic> toFirestore({bool isCreate = false}) {
    return {
      'name': name,
      'price': price,
      'stock': stock,
      'isActive': isActive,

      'imageUrl': imageUrl,
      'sku': sku,
      'description': description,
      'categoryId': categoryId,

      'sold': sold,
      'views': views,

      'costPrice': costPrice,
      'discountPrice': discountPrice,
      'isDiscount': isDiscount,

      'updatedAt': FieldValue.serverTimestamp(),
      if (isCreate) 'createdAt': FieldValue.serverTimestamp(),
    };
  }

  ProductModel copyWith({
    String? id,
    String? name,
    int? price,
    int? stock,
    bool? isActive,
    String? imageUrl,
    String? sku,
    String? description,
    String? categoryId,
    int? sold,
    int? views,
    int? costPrice,
    int? discountPrice,
    bool? isDiscount,
    Timestamp? createdAt,
    Timestamp? updatedAt,
  }) {
    return ProductModel(
      id: id ?? this.id,
      name: name ?? this.name,
      price: price ?? this.price,
      stock: stock ?? this.stock,
      isActive: isActive ?? this.isActive,
      imageUrl: imageUrl ?? this.imageUrl,
      sku: sku ?? this.sku,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      sold: sold ?? this.sold,
      views: views ?? this.views,
      costPrice: costPrice ?? this.costPrice,
      discountPrice: discountPrice ?? this.discountPrice,
      isDiscount: isDiscount ?? this.isDiscount,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

}

