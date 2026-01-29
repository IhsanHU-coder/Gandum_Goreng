import 'package:flutter/material.dart';
import 'package:gandum_goreng/utils/colors_app.dart';
import 'package:gandum_goreng/utils/text_app.dart';
import '../../models/product_model.dart';

class ProductCard extends StatelessWidget {
  final ProductModel product;
  final VoidCallback? onDelete;
  final VoidCallback? onEdit;
  final VoidCallback? onBuy;

  const ProductCard({
    super.key,
    required this.product,
    this.onDelete,
    this.onEdit,
    this.onBuy,
  });

  @override
  Widget build(BuildContext context) {
    final bool isOutOfStock = product.stock <= 0;

    return InkWell(
      borderRadius: BorderRadius.circular(12),
      onTap: onEdit,
      child: Card(
        color: AppColors.card,
        elevation: 1.5,
        margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
          side: const BorderSide(color: AppColors.border),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12),
          child: Column(
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: 56,
                    height: 56,
                    decoration: BoxDecoration(
                      color: AppColors.primaryLight,
                      borderRadius: BorderRadius.circular(8),
                    ),
                    clipBehavior: Clip.antiAlias,
                    child: product.imageUrl != null
                        ? Image.network(
                      product.imageUrl!,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) {
                        return const Icon(
                          Icons.inventory_2_outlined,
                          color: AppColors.primary,
                        );
                      },
                    )
                        : const Icon(
                      Icons.inventory_2_outlined,
                      color: AppColors.primary,
                    ),
                  ),

                  const SizedBox(width: 12),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          product.name,
                          style: AppTextStyle.bodyLarge.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),

                        if (product.sku != null)
                          Padding(
                            padding: const EdgeInsets.only(top: 2),
                            child: Text(
                              product.sku!,
                              style: AppTextStyle.caption,
                            ),
                          ),

                        const SizedBox(height: 4),

                        Text(
                          'Rp ${product.price}',
                          style: AppTextStyle.bodyMedium.copyWith(
                            color: AppColors.success,
                            fontWeight: FontWeight.w500,
                          ),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          isOutOfStock
                              ? 'Stok habis'
                              : 'Stock: ${product.stock}',
                          style: AppTextStyle.bodySmall.copyWith(
                            color: isOutOfStock
                                ? AppColors.error
                                : AppColors.textSecondary,
                          ),
                        ),
                      ],
                    ),
                  ),

                  Column(
                    children: [
                      if (onEdit != null)
                        IconButton(
                          icon: const Icon(
                            Icons.edit,
                            color: AppColors.warning,
                          ),
                          onPressed: onEdit,
                        ),
                      if (onDelete != null)
                        IconButton(
                          icon: const Icon(
                            Icons.delete,
                            color: AppColors.error,
                          ),
                          onPressed: onDelete,
                        ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 40,
                child: ElevatedButton(
                  onPressed: isOutOfStock ? null : onBuy,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    disabledBackgroundColor: AppColors.border,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    isOutOfStock ? 'Stok Habis' : 'Buy',
                    style: AppTextStyle.button,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}