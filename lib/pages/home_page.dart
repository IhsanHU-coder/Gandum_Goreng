import 'package:flutter/material.dart';
import 'package:gandum_goreng/component/button_component.dart';
import 'package:gandum_goreng/component/product_card.dart';
import 'package:gandum_goreng/component/text_fild.dart';
import 'package:gandum_goreng/controllers/controller_product.dart';
import 'package:gandum_goreng/controllers/payment_controller.dart';
import 'package:gandum_goreng/services/midtrans_service.dart';
import 'package:gandum_goreng/utils/colors_app.dart';
import 'package:gandum_goreng/utils/text_app.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final ProductController controller = Get.put(ProductController());
final PaymentController paymentController =
    Get.put(PaymentController());
    

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: Text('Products', style: AppTextStyle.headingMedium),
        backgroundColor: AppColors.card,
        elevation: 0,
      ),
      body: Column(
        children: [
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return const Center(child: CircularProgressIndicator());
              }

              if (controller.products.isEmpty) {
                return Center(
                  child: Text('Produk kosong', style: AppTextStyle.bodyMedium),
                );
              }

              return ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 8),
                itemCount: controller.products.length,
                itemBuilder: (context, index) {
                  final product = controller.products[index];
                  return ProductCard(
                    product: product,
                    onEdit: () {
                      controller.selectProduct(product);
                      showEditProductDialog();
                    },
                    onDelete: () {
                      controller.selectProduct(product);
                      showDeleteConfirm();
                    },
                    onBuy: () {
                      paymentController.payProduct(product);
                    },
                  );
                },
              );
            }),
          ),

          Container(
            padding: const EdgeInsets.all(16),
            decoration: const BoxDecoration(
              color: AppColors.card,
              border: Border(top: BorderSide(color: AppColors.border)),
            ),
            child: AppButton(
              text: 'Tambah Produk',
              onPressed: showAddProductDialog,
            ),
          ),
        ],
      ),
    );
  }

  Widget productImagePicker(ProductController controller) {
    return Obx(() {
      final image = controller.selectedImage.value;

      return GestureDetector(
        onTap: controller.pickImage,
        child: Container(
          height: 140,
          width: 140, // 🔴 FIX: JANGAN infinity
          decoration: BoxDecoration(
            color: AppColors.card,
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: AppColors.border),
          ),
          child: image == null
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.add_a_photo, color: AppColors.textSecondary),
                    const SizedBox(height: 8),
                    Text('Tambah Foto', style: AppTextStyle.bodySmall),
                  ],
                )
              : ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: Image.file(image, fit: BoxFit.cover),
                ),
        ),
      );
    });
  }

  void showAddProductDialog() {
    controller.clearForm();

    Get.dialog(
      AlertDialog(
        title: Text('Tambah Produk', style: AppTextStyle.headingMedium),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: productImagePicker(controller),
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: controller.nameC,
                label: 'Nama Produk',
                isRequired: true,
              ),
              const SizedBox(height: 12),

              AppTextField(
                controller: controller.priceC,
                label: 'Harga',
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12),

              AppTextField(
                controller: controller.stockC,
                label: 'Stock',
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12),

              AppTextField(
                controller: controller.skuC,
                label: 'SKU (Opsional)',
              ),
              const SizedBox(height: 12),

              AppTextField(
                controller: controller.categoryC,
                label: 'Kategori (Opsional)',
              ),
              const SizedBox(height: 12),

              AppTextField(
                controller: controller.descriptionC,
                label: 'Deskripsi (Opsional)',
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('Batal', style: AppTextStyle.bodyMedium),
          ),
          AppButton(text: 'Simpan', onPressed: controller.addProduct),
        ],
      ),
    );
  }

  void showDeleteConfirm() {
    Get.dialog(
      AlertDialog(
        title: Text('Hapus Produk', style: AppTextStyle.headingMedium),
        content: Text(
          'Yakin ingin menghapus produk ini?',
          style: AppTextStyle.bodyMedium,
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('Batal', style: AppTextStyle.bodyMedium),
          ),
          AppButton(text: 'Hapus', onPressed: controller.deleteSelectedProduct),
        ],
      ),
    );
  }

  void showEditProductDialog() {
    controller.fillForm();

    Get.dialog(
      AlertDialog(
        title: Text('Edit Produk', style: AppTextStyle.headingMedium),
        content: SingleChildScrollView(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Center(
                child: productImagePicker(controller),
              ),
              const SizedBox(height: 16),

              AppTextField(
                controller: controller.nameC,
                label: 'Nama Produk',
                isRequired: true,
              ),
              const SizedBox(height: 12),

              AppTextField(
                controller: controller.priceC,
                label: 'Harga',
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12),

              AppTextField(
                controller: controller.stockC,
                label: 'Stock',
                keyboardType: TextInputType.number,
                isRequired: true,
              ),
              const SizedBox(height: 12),

              AppTextField(controller: controller.skuC, label: 'SKU'),
              const SizedBox(height: 12),

              AppTextField(controller: controller.categoryC, label: 'Kategori'),
              const SizedBox(height: 12),

              AppTextField(
                controller: controller.descriptionC,
                label: 'Deskripsi',
                maxLines: 3,
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: Get.back,
            child: Text('Batal', style: AppTextStyle.bodyMedium),
          ),
          AppButton(text: 'Update', onPressed: controller.submitUpdate),
        ],
      ),
    );
  }
}