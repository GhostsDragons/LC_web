import 'package:flutter/material.dart';
import 'package:lc_web/Functions/sidebar.dart';

class CourseCatalog extends StatelessWidget {
  CourseCatalog({super.key});

    final List<Product> products = [
    Product(
      imageUrl: 'assets/ABZ.jpg', 
      title: 'Product 1',
      subtitle: 'Description of Product 1',
      price: 29.99,
    ),
    Product(
      imageUrl: 'assets/ABZ.jpg',
      title: 'Product 2',
      subtitle: 'Description of Product 2',
      price: 14.99,
    ),
    Product(
      imageUrl: 'assets/ABZ.jpg', 
      title: 'Product 3',
      subtitle: 'Description of Product 3',
      price: 29.99,
    ),
    Product(
      imageUrl: 'assets/ABZ.jpg',
      title: 'Product 4',
      subtitle: 'Description of Product 4',
      price: 14.99,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Sidebar(
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: Container(
                width: MediaQuery.of(context).size.width,
                height: 30,
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.black, width: 3),
                  image: DecorationImage(
                    image: const AssetImage('assets/BG.jpg'),
                    colorFilter: ColorFilter.mode(
                      Colors.black.withOpacity(0.5), 
                      BlendMode.darken, 
                    ),
                    fit: BoxFit.cover,
                  )
                ), 

                child: const Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Course Catalog',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold
                      ),
                    ),

                    SizedBox(
                      height: 8,
                    ),

                    Text(
                      'Start your learning journey',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold
                      ),
                    ),
                  ],
                ),
              )
            ),

            Expanded(
              flex: 3,
              child: Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: GridView.builder(
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                      ),
                      itemCount: products.length,
                      itemBuilder: (context, index) {
                        return ProductCard(product: products[index]);
                      },
                    ),
                  ),

                  const Expanded(
                    flex: 1,
                    child: Placeholder(),
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


class Product {
  final String imageUrl;
  final String title;
  final String subtitle;
  final double price;

  Product({
    required this.imageUrl,
    required this.title,
    required this.subtitle,
    required this.price,
  });
}

class ProductCard extends StatelessWidget {
  final Product product;

  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 20),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3),
            ),
          ],
        ),
      
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Image.asset(product.imageUrl),
            ),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    product.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    product.subtitle,
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    '\$${product.price.toStringAsFixed(2)}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
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