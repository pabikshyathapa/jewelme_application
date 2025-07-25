import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:jewelme_application/core/common/snackbar/my_snack_bar.dart';
import 'package:jewelme_application/core/utils/user_session.dart';
import 'package:jewelme_application/features/auth/presentation/view/login_page.dart';
import 'package:jewelme_application/features/order/domain/entity/order_entity.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_event.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_state.dart';
import 'package:jewelme_application/features/order/presenttaion/view_model/order_view_model.dart';
import 'package:jewelme_application/features/profile/domain/entity/user_entity.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_event.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_state.dart';
import 'package:jewelme_application/features/profile/presenttaion/view_model/user_view_model.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _phoneController;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController();
    _emailController = TextEditingController();
    _phoneController = TextEditingController();

    final userId = UserSession.instance.userId;
    if (userId != null) {
      context.read<UserViewModel>().add(
        GetUserProfileEvent(context: context, userId: userId),
      );
      context.read<OrderViewModel>().add(
        FetchOrdersByUserEvent(context: context, userId: userId),
      );
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  void _onUpdatePressed() {
    final userId = UserSession.instance.userId;
    if (userId == null) return;

    final updatedUser = UserEntity(
      id: userId,
      name: _nameController.text.trim(),
      email: _emailController.text.trim(),
      phone: _phoneController.text.trim(),
    );

    context.read<UserViewModel>().add(
      UpdateUserProfileEvent(
        context: context,
        userId: userId,
        updatedUser: updatedUser,
      ),
    );
  }

  Widget _buildOrderCard(OrderEntity order) {
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
      elevation: 4,
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              contentPadding: EdgeInsets.zero,
              leading: const Icon(
                Icons.shopping_bag_outlined,
                color: Color(0xFFD9534F),
              ),
              title: Text(
                'Order ID: ${order.id}',
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 4),
                  Text('Total: Rs ${order.totalAmount.toStringAsFixed(2)}'),
                  Text('Date: ${DateFormat.yMMMd().format(order.createdAt)}'),
                ],
              ),
              isThreeLine: true,
            ),
            const Divider(),
            const Text(
              'Products:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 6),
            ...order.products.map(
              (item) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 2),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        item.name,
                        style: const TextStyle(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    Text(
                      'Qty: ${item.quantity}',
                      style: const TextStyle(fontSize: 14, color: Colors.grey),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildGradientButton() {
    return GestureDetector(
      onTap: _onUpdatePressed,
      child: Container(
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFD9534F), Color(0xFFB02A37)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(14),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              offset: const Offset(0, 6),
              blurRadius: 10,
            ),
          ],
        ),
        padding: const EdgeInsets.symmetric(vertical: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: const [
            Icon(Icons.save, color: Colors.white),
            SizedBox(width: 10),
            Text(
              'Update Profile',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 16,
                letterSpacing: 0.8,
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Profile'),
        centerTitle: true,
        backgroundColor: Colors.white,
        foregroundColor: Colors.white,
        elevation: 1,
      ),
      body: BlocConsumer<UserViewModel, UserState>(
        listener: (context, state) {
          if (state.errorMessage != null) {
            showMySnackBar(
              context: context,
              message: state.errorMessage!,
              color: Colors.red,
            );
            context.read<UserViewModel>().add(ClearUserMessageEvent());
          }

          if (state.user != null) {
            _nameController.text = state.user!.name;
            _emailController.text = state.user!.email;
            _phoneController.text = state.user!.phone;
          }
        },
        builder: (context, userState) {
          if (userState.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (userState.user == null) {
            return const Center(child: Text('No user data available.'));
          }

          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView(
              children: [
                const Text(
                  'Profile Info',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFD9534F),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _nameController,
                  decoration: InputDecoration(
                    labelText: 'Name',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.person_outline),
                  ),
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _emailController,
                  decoration: InputDecoration(
                    labelText: 'Email',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.email_outlined),
                  ),
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 14),
                TextField(
                  controller: _phoneController,
                  decoration: InputDecoration(
                    labelText: 'Phone',
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    prefixIcon: const Icon(Icons.phone_outlined),
                  ),
                  keyboardType: TextInputType.phone,
                ),
                const SizedBox(height: 20),
                _buildGradientButton(),
                const SizedBox(height: 30),
                const Divider(thickness: 1.4),
                const SizedBox(height: 16),
                const Text(
                  'My Orders',
                  style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 10),
                BlocBuilder<OrderViewModel, OrderState>(
                  builder: (context, orderState) {
                    if (orderState.isLoading) {
                      return const Center(
                        child: Padding(
                          padding: EdgeInsets.only(top: 20),
                          child: CircularProgressIndicator(),
                        ),
                      );
                    } else if (orderState.errorMessage != null) {
                      return Center(
                        child: Text(
                          orderState.errorMessage!,
                          style: const TextStyle(color: Colors.red),
                        ),
                      );
                    } else if (orderState.orders == null ||
                        orderState.orders!.isEmpty) {
                      return const Center(
                        child: Text("You have no orders yet."),
                      );
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        ...orderState.orders!.map(_buildOrderCard).toList(),
                        const SizedBox(height: 30),
                        // 👇 Add the logout button here
                        Container(
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFFD9534F), Color(0xFFB02A37)],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(14),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                offset: const Offset(0, 6),
                                blurRadius: 10,
                              ),
                            ],
                          ),
                          child: TextButton.icon(
                            onPressed: () {
                              Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const LoginPage(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.logout, color: Colors.white),
                            label: const Text(
                              'Logout',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            style: TextButton.styleFrom(
                              padding: const EdgeInsets.symmetric(vertical: 14),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(14),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
