import 'package:assignment10/core/ui.dart';
import 'package:assignment10/logic/cubits/product_cubit/product_cubit.dart';
import 'package:assignment10/logic/cubits/product_cubit/product_state.dart';
import 'package:assignment10/logic/services/formatter.dart';
import 'package:assignment10/presentation/screens/product/product_details_screen.dart';
import 'package:assignment10/presentation/widgets/gap_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserFeedScreen extends StatefulWidget {
  const UserFeedScreen({super.key});

  @override
  State<UserFeedScreen> createState() => _UserFeedScreenState();
}

class _UserFeedScreenState extends State<UserFeedScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        if (state is ProductLoadingState && state.products.isEmpty) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        } else if (state is ProductErrorState && state.products.isEmpty) {
          return Center(
            child: Text(state.message),
          );
        }

        return ListView.builder(
          itemCount: state.products.length,
          itemBuilder: (context, index) {
            final product = state.products[index];

            return CupertinoButton(
              onPressed: () {
                Navigator.pushNamed(
                  context,
                  ProductDetailsScreen.routeName,
                  arguments: product,
                );
              },
              padding: EdgeInsets.zero,
              child: Row(
                children: [
                  CachedNetworkImage(
                    width: MediaQuery.of(context).size.width / 3,
                    imageUrl: '${product.images?[0]}',
                  ),
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          '${product.title}',
                          style: TextStyles.body1.copyWith(
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        Text(
                          '${product.description}',
                          style: TextStyles.body2.copyWith(
                            color: AppColors.textLight,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const GapWidget(),
                        Text(
                          Formatter.formatPrice(product.price!),
                          style: TextStyles.heading3,
                        )
                      ],
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
