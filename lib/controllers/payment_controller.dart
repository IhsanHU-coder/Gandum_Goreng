import 'dart:convert';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import '../models/product_model.dart';
import '../services/midtrans_service.dart';

class PaymentController extends GetxController {
  var isLoading = false.obs;

  Future<void> payProduct(ProductModel product) async {
    try {
      isLoading.value = true;

      final token = await _createTransaction(product);

      if (token == null) {
        print("Error: Token is null");
        return;
      }

      final url =
          "https://app.sandbox.midtrans.com/snap/v4/redirection/$token";

      // 🔥 AUTO buka WebView
      Get.to(() => SnapWebView(url: url));
    } catch (e) {
      //Get.snackbar("Payment Error", e.toString());
      print("payment Error: $e");
    } finally {
      isLoading.value = false;
    }
  }

  Future<String?> _createTransaction(ProductModel product) async {
    final response = await http.post(
      Uri.parse("http://10.251.24.248:3000/create-transaction"),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "order_id":
            "ORDER-${product.id}-${DateTime.now().millisecondsSinceEpoch}",
        "gross_amount": product.price,
        "item_name": product.name,
      }),
    );

    print("STATUS: ${response.statusCode}");
    print("BODY: ${response.body}");

    if (response.statusCode != 200) return null;

    final data = jsonDecode(response.body);
    return data["token"];
  }
}
