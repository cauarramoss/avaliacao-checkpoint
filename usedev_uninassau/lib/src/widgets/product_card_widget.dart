import 'package:flutter/material.dart';


class ProductCardWidget extends StatelessWidget {
  const ProductCardWidget({
    required this.url,
    required this.nome,
    required this.preco,
    super.key});


  final String url;
  final String nome;
  final String preco;


  @override
  Widget build(BuildContext context) {
    return Card(
      margin: .all(20),
      color: Color(0xFFEFEFEF),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(0)),
      child: Column(
        crossAxisAlignment: .stretch,
        children: [
          Image.network(
            url,
            height: 200,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              nome,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 25,
                fontWeight: .bold,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20.0),
            child: Text(
              preco,
              style: TextStyle(
                fontSize: 30,
                fontWeight: .bold,
                fontFamily: 'Montserrat',
              ),
          )
          )],
    ));
  }
}