import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:usedev_uninassau/src/models/product_model.dart';
import 'package:usedev_uninassau/src/service/cart_service.dart';
import 'package:usedev_uninassau/src/screens/cart_screen.dart';


class ProductDetailsScreen extends StatelessWidget {
  final ProductModel product;

  const ProductDetailsScreen({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Detalhes do Produto',
          style: GoogleFonts.orbitron(
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        actions: [
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
                  icon: const Icon(Icons.shopping_cart_outlined),
                ),
              );
            },
          ),
          const SizedBox(width: 15),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Área da Imagem com fundo leve
            Container(
              height: 350,
              color: const Color(0xFFEFEFEF),
              padding: const EdgeInsets.all(30),
              child: Image.network(
                product.image,
                fit: BoxFit.contain,
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nome do Produto
                  Text(
                    product.title.toUpperCase(),
                    style: TextStyle(
                      fontFamily: GoogleFonts.orbitron().fontFamily,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 15),
                  // Preço com a cor roxa do projeto
                  Text(
                    'R\$ ${product.price.toStringAsFixed(2)}',
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: const Color(0xFF780BF7),
                    ),
                  ),
                  const SizedBox(height: 30),
                  // Título da Descrição em Orbitron
                  Text(
                    'Descrição',
                    style: GoogleFonts.orbitron(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    product.description,
                    style: TextStyle(
                      fontFamily: GoogleFonts.poppins().fontFamily,
                      fontSize: 16,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton.icon(
                    onPressed: () {
                      CartService().addToCart(product);
                      ScaffoldMessenger.of(context).showSnackBar(
                         SnackBar(
                          content: Text('${product.title} adicionado ao carrinho!'),
                          duration: const Duration(seconds: 2),
                          action: SnackBarAction(
                            label: 'Ver Carrinho',
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CartScreen(),
                                ),
                              );
                            },
                          ),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF780BF7),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(horizontal: 60, vertical: 25),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    icon: const Icon(Icons.add_shopping_cart),
                    label: Text(
                      'Adicionar ao Carrinho',
                      style: TextStyle(
                        fontFamily: GoogleFonts.poppins().fontFamily,
                        fontSize: 18,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
