import 'dart:io';

import 'package:flutter/material.dart';
import 'package:gandum_goreng/services/service.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../models/product_model.dart';


class ProductController extends GetxController {
  final AppService service = AppService();

  RxList<ProductModel> products = <ProductModel>[].obs;
  RxBool isLoading = true.obs;

  final ImagePicker picker = ImagePicker();
  Rx<File?> selectedImage = Rx<File?>(null);

  Rx<ProductModel?> selectedProduct = Rx<ProductModel?>(null);

  final TextEditingController nameC = TextEditingController();
  final TextEditingController priceC = TextEditingController();
  final TextEditingController stockC = TextEditingController();
  final TextEditingController skuC = TextEditingController();
  final TextEditingController descriptionC = TextEditingController();
  final TextEditingController categoryC = TextEditingController();

  @override
  void onInit() {
    super.onInit();
    listenProducts();
  }

  void listenProducts() {
    service.streamProducts().listen((data) {
      products.value = data;
      isLoading.value = false;
    });
  }

  Future<void> pickImage() async {
    final XFile? image = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 75,
    );

    if (image != null) {
      selectedImage.value = File(image.path);
    }
  }

  void clearImage() {
    selectedImage.value = null;
  }

  Future<void> addProduct() async {
    try {
      isLoading.value = true;

      final docRef =
      FirebaseFirestore.instance.collection('products').doc();
      final productId = docRef.id;

      String? imageUrl;

      if (selectedImage.value != null) {
        debugPrint('IMAGE EXISTS, UPLOADING...');
        imageUrl = await service.uploadProductImage(
          selectedImage.value!,
          productId,
        );
        debugPrint('UPLOAD RESULT: $imageUrl');
      } else {
        debugPrint('NO IMAGE SELECTED');
      }

      imageUrl = imageUrl?.isNotEmpty == true ? imageUrl : null;

      final product = ProductModel(
        id: productId,
        name: nameC.text.trim(),
        price: int.tryParse(priceC.text) ?? 0,
        stock: int.tryParse(stockC.text) ?? 0,
        isActive: true,
        imageUrl: imageUrl,
        sku: skuC.text.isEmpty ? null : skuC.text.trim(),
        description:
        descriptionC.text.isEmpty ? null : descriptionC.text.trim(),
        categoryId:
        categoryC.text.isEmpty ? null : categoryC.text.trim(),
        createdAt: Timestamp.now(),
      );

      await service.addProduct(product);

      clearForm();
      Get.back();
    } catch (e) {
      Get.snackbar(
        'Gagal',
        'Gagal upload gambar, produk tetap disimpan',
      );
    } finally {
      isLoading.value = false;
    }
  }

  void selectProduct(ProductModel product) {
    selectedProduct.value = product;
  }

  void fillForm() {
    final product = selectedProduct.value;
    if (product == null) return;

    nameC.text = product.name;
    priceC.text = product.price.toString();
    stockC.text = product.stock.toString();
    skuC.text = product.sku ?? '';
    categoryC.text = product.categoryId ?? '';
    descriptionC.text = product.description ?? '';

    selectedImage.value = null;
  }

  Future<void> submitUpdate() async {
    final oldProduct = selectedProduct.value;
    if (oldProduct == null) return;

    try {
      isLoading.value = true;

      String? imageUrl = oldProduct.imageUrl;

      if (selectedImage.value != null) {
        final uploadedUrl = await service.uploadProductImage(
          selectedImage.value!,
          oldProduct.id,
        );

        if (uploadedUrl != null) {
          imageUrl = uploadedUrl;
        }
      }

      final updatedProduct = ProductModel(
        id: oldProduct.id,
        name: nameC.text.trim(),
        price: int.tryParse(priceC.text) ?? oldProduct.price,
        stock: int.tryParse(stockC.text) ?? oldProduct.stock,
        isActive: oldProduct.isActive,
        imageUrl: imageUrl,
        sku: skuC.text.isEmpty ? null : skuC.text.trim(),
        categoryId:
        categoryC.text.isEmpty ? null : categoryC.text.trim(),
        description:
        descriptionC.text.isEmpty ? null : descriptionC.text.trim(),
        sold: oldProduct.sold,
        views: oldProduct.views,
        updatedAt: Timestamp.now(),
      );

      await service.updateProduct(updatedProduct);

      clearForm();
      selectedProduct.value = null;
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  Future<void> deleteSelectedProduct() async {
    final product = selectedProduct.value;
    if (product == null) return;

    try {
      isLoading.value = true;
      await service.deleteProduct(product.id);
      selectedProduct.value = null;
      Get.back();
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  void clearForm() {
    nameC.clear();
    priceC.clear();
    stockC.clear();
    skuC.clear();
    descriptionC.clear();
    categoryC.clear();
    selectedImage.value = null;
  }

  @override
  void onClose() {
    nameC.dispose();
    priceC.dispose();
    stockC.dispose();
    skuC.dispose();
    descriptionC.dispose();
    categoryC.dispose();
    super.onClose();
  }
}