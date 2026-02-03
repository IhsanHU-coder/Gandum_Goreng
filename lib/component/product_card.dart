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

    return Card(
      color: AppColors.card,
      elevation: 1.5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: const BorderSide(color: AppColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ================= IMAGE + ACTION =================
          Expanded(
            child: Stack(
              children: [
                ClipRRect(
                  borderRadius: const BorderRadius.vertical(
                    top: Radius.circular(16),
                  ),
                  child: product.imageUrl != null
                      ? Image.network(
                          product.imageUrl!,
                          fit: BoxFit.cover,
                          width: double.infinity,
                          errorBuilder: (_, __, ___) =>
                              _imagePlaceholder(),
                        )
                      : _imagePlaceholder(),
                ),

                // ===== EDIT & DELETE BUTTON =====
                if (onEdit != null || onDelete != null)
                  Positioned(
                    top: 8,
                    right: 8,
                    child: Row(
                      children: [
                        if (onEdit != null)
                          _iconButton(
                            icon: Icons.edit,
                            color: AppColors.primary,
                            onTap: onEdit!,
                          ),
                        const SizedBox(width: 6),
                        if (onDelete != null)
                          _iconButton(
                            icon: Icons.delete,
                            color: AppColors.error,
                            onTap: onDelete!,
                          ),
                      ],
                    ),
                  ),
              ],
            ),
          ),

          // ================= CONTENT =================
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // NAME
                Text(
                  product.name,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: AppTextStyle.bodyMedium.copyWith(
                    fontWeight: FontWeight.w600,
                  ),
                ),

                const SizedBox(height: 4),

                // PRICE
                Text(
                  'Rp ${product.price}',
                  style: AppTextStyle.bodyMedium.copyWith(
                    color: AppColors.success,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 4),

                // STOCK
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

                const SizedBox(height: 10),

                // BUY BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 38,
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
        ],
      ),
    );
  }

  // ================= SMALL ICON BUTTON =================
  Widget _iconButton({
    required IconData icon,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        padding: const EdgeInsets.all(6),
        decoration: BoxDecoration(
          color: Colors.white.withOpacity(0.9),
          shape: BoxShape.circle,
        ),
        child: Icon(icon, size: 18, color: color),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      color: AppColors.primaryLight,
      child: const Center(
        child: Icon(
          Icons.inventory_2_outlined,
          color: AppColors.primary,
          size: 40,
        ),
      ),
    );
  }
}
