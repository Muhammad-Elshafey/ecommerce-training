import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';

import '../../core/controllers/product_cubit/product_cubit.dart';
import '../../core/controllers/product_cubit/product_states.dart';
import '../../models/product_model.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({super.key, required this.product});

  final Product? product;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductCubit, ProductStates>(
        listener: (context, state) {},
        builder: (context, state) {
          var cubit = ProductCubit.get(context);
          if (cubit.productsModel == null) {
            return Scaffold(
              appBar: AppBar(
                title: const Text('Products Detalis'),
              ),
              body: const Center(child: CircularProgressIndicator()),
            );
          }

          return Scaffold(
            appBar: AppBar(
              title: const Text('Products Detalis'),
              centerTitle: true,
            ),
            body: Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image(image: NetworkImage(product!.image!)),
                  const SizedBox(
                    height: 60.0,
                  ),
                  Text(
                    product!.name!,
                    style: const TextStyle(
                      fontSize: 32.0,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 6.0,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          product!.company!,
                          style: const TextStyle(
                              fontSize: 16.0, color: Colors.grey),
                        ),
                        Row(
                          children: [
                            const Text(
                              '\$',
                              style:
                                  TextStyle(fontSize: 16.0, color: Colors.red),
                            ),
                            Text(
                              product!.price!.toString(),
                              style: const TextStyle(
                                  fontSize: 16.0, color: Colors.red),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 32.0,
                  ),
                  Container(
                    height: 50,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: HexColor('#07094D'),
                      borderRadius: BorderRadius.circular(20.0),
                    ),
                    child: MaterialButton(
                      onPressed: () {},
                      child: Text(
                        'Buy'.toUpperCase(),
                        style: const TextStyle(color: Colors.white),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          );
        });
  }
}
