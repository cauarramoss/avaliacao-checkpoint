import 'package:flutter/material.dart';
import 'package:usedev_uninassau/src/screens/cart_screen.dart';
import 'package:usedev_uninassau/src/service/cart_service.dart';

class CustomAppBarWidget extends StatelessWidget
    implements PreferredSizeWidget {
  final String? title;

  const CustomAppBarWidget({this.title, super.key});

  @override
  Widget build(BuildContext context) {
    final bool canPop = Navigator.canPop(context);

    return AppBar(
      leading: canPop
          ? IconButton(
              icon: const Icon(Icons.arrow_back, size: 40),
              onPressed: () => Navigator.of(context).pop(),
            )
          : const Icon(Icons.menu, size: 40),
      title: title != null
          ? Text(title!, style: const TextStyle(fontWeight: FontWeight.bold))
          : Image.asset('assets/logo_usedev.png', height: 40),
      centerTitle: true,
      actions: [
        const Icon(Icons.person_outline, size: 40),
        const SizedBox(width: 10),
        ListenableBuilder(
          listenable: CartService(),
          builder: (context, child) {
            final itemCount = CartService().itemCount;
            return Badge(
              label: Text(itemCount.toString()),
              isLabelVisible: itemCount > 1,
              backgroundColor: const Color(0xFF780BF7),
              child: IconButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const CartScreen()),
                  );
                },
                icon: const Icon(Icons.shopping_cart_outlined, size: 40),
              ),
            );
          },
        ),
        const SizedBox(width: 25),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
}
