import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:jewelme_application/core/utils/getimage.dart';
import 'package:jewelme_application/features/auth/presentation/view/dashboard_page.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';

class OrderConfirmationPage extends StatefulWidget {
  final OrderEntity order;

  const OrderConfirmationPage({Key? key, required this.order}) : super(key: key);

  @override
  State<OrderConfirmationPage> createState() => _OrderConfirmationPageState();
}

class _OrderConfirmationPageState extends State<OrderConfirmationPage> {
  final TextEditingController _locationController = TextEditingController();

  @override
  void dispose() {
    _locationController.dispose();
    super.dispose();
  }

  void _confirmOrder() {
    if (_locationController.text.trim().isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter your location."),backgroundColor: Colors.green,),
      );
      return;
    }

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("Order Confirmed!"),backgroundColor: Colors.green,),
    );

    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (_) => const DashboardPage()), // Replace with your actual HomePage
      (route) => false,
    );
  }

  @override
  Widget build(BuildContext context) {
    final dateFormatted = DateFormat.yMMMMd().format(widget.order.createdAt);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Order Confirmation"),
        centerTitle: true,
        elevation: 1,
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(16, 16, 16, 80),
        child: Column(
          children: [
            _buildOrderHeader(dateFormatted),
            const SizedBox(height: 20),
            Expanded(child: _buildProductList()),
            const Divider(height: 32),
            _buildOrderTotal(),
            const SizedBox(height: 16),
            _buildLocationField(),
          ],
        ),
      ),
      bottomSheet: Container(
        color: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        width: double.infinity,
        child: ElevatedButton(
          onPressed: _confirmOrder,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.red,
            padding: const EdgeInsets.symmetric(vertical: 14),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
          child: const Text("Confirm Order", style: TextStyle(fontSize: 16, color: Colors.white)),
        ),
      ),
    );
  }

  Widget _buildOrderHeader(String dateFormatted) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red.shade50,
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.red.shade100),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Order ID: ${widget.order.id}", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 6),
          Text("Date: $dateFormatted", style: TextStyle(fontSize: 14, color: Colors.red.shade700)),
        ],
      ),
    );
  }

  Widget _buildProductList() {
    return ListView.separated(
      itemCount: widget.order.products.length,
      separatorBuilder: (_, __) => const SizedBox(height: 12),
      itemBuilder: (context, index) {
        final product = widget.order.products[index];
        return Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: const [BoxShadow(color: Colors.black12, blurRadius: 4, offset: Offset(0, 2))],
            borderRadius: BorderRadius.circular(10),
          ),
          child: ListTile(
            contentPadding: const EdgeInsets.all(12),
            leading: product.filepath.isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      getBackendImageUrl(product.filepath),
                      width: 60,
                      height: 60,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) =>
                          const Icon(Icons.broken_image, size: 50, color: Colors.grey),
                    ),
                  )
                : const Icon(Icons.image_not_supported, size: 50, color: Colors.grey),
            title: Text(product.name, style: const TextStyle(fontWeight: FontWeight.w600)),
            subtitle: Text("Quantity: ${product.quantity}"),
            trailing: Text(
              "Rs. ${product.price.toStringAsFixed(2)}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        );
      },
    );
  }

  Widget _buildOrderTotal() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Text("Total: ", style: TextStyle(fontSize: 18, color: Colors.grey.shade800)),
        Text(
          "Rs. ${widget.order.totalAmount.toStringAsFixed(2)}",
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Colors.red),
        ),
      ],
    );
  }

  Widget _buildLocationField() {
    return TextField(
      controller: _locationController,
      decoration: InputDecoration(
        labelText: "Delivery Location",
        hintText: "e.g.Baneshwor near Eyeplex",
        filled: true,
        fillColor: Colors.grey.shade100,
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
      ),
    );
  }
}
