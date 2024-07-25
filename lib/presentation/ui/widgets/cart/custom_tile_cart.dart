part of 'package:mini_project_team_7/routes/routes.dart';

class CustomTileCart extends StatelessWidget {
  final ProductCart product;
  const CustomTileCart({
    super.key,
    required this.product,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<ProductModel>(
      future: context.read<ProductBloc>().getProduct(product.productId),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Failed to load product'));
        }

        if (snapshot.hasData) {
          final data = snapshot.data;
          return Container(
            margin: const EdgeInsets.symmetric(
              vertical: 8,
            ),
            child: Row(
              children: [
                Container(
                  height: 80,
                  width: 80,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(
                        data!.image!,
                      ),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Text(
                        data.title!,
                        style: body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                    Text(
                      '\$${data.price}',
                      style: body.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      '${product.quantity} items',
                      style: body.copyWith(
                        color: primaryColor,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
                const Icon(
                  Icons.chevron_right_rounded,
                ),
              ],
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
