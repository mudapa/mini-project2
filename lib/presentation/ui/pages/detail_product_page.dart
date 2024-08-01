part of 'package:mini_project_team_7/routes/routes.dart';

class DetailProductPage extends StatelessWidget {
  final ProductModel product;
  const DetailProductPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _buildBody(context),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            _buildImage(context),
            _buildAppBar(context),
          ],
        ),
        _buildContent(context),
      ],
    );
  }

  Widget _buildAppBar(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: 24,
        vertical: 24,
      ),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(
        color: transparentColor,
      ),
      child: Row(
        children: [
          GestureDetector(
            onTap: () {
              GoRouter.of(context).go(NamedRoutes.mainPagePath);
            },
            child: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: greyColor.withOpacity(0.3),
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.chevron_left_rounded,
                color: whiteColor,
              ),
            ),
          ),
          const Spacer(),
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: greyColor.withOpacity(0.3),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: Icon(
                Icons.favorite_border_rounded,
                color: whiteColor,
              ),
              onPressed: () {
                showDialog(
                  context: context,
                  builder: (context) => AlertDialog(
                    title: const Text(
                      'Add to Favorite',
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          GoRouter.of(context).pop();

                          snackbar(
                            context,
                            msg: 'Coming Soon',
                            backgroundColor: orangeColor,
                            textColor: whiteColor,
                          );
                        },
                        child: const Text('Yes'),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildImage(BuildContext context) {
    return Stack(
      children: [
        Image.network(
          product.image!,
          width: double.infinity,
          height: 270,
          fit: BoxFit.cover,
        ),
        Container(
          height: 270,
          width: double.infinity,
          decoration: BoxDecoration(
            color: blackColor.withOpacity(0.4),
          ),
        ),
      ],
    );
  }

  Widget _buildContent(BuildContext context) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(24),
        width: double.infinity,
        decoration: BoxDecoration(
          color: whiteColor,
        ),
        child: ListView(
          children: [
            Text(
              product.title!,
              style: title.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              product.description!,
              style: body.copyWith(
                color: greyColor,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Category',
                  style: subtitle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  product.category!,
                  style: subtitle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: greenColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Text(
                  'Price',
                  style: subtitle.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const Spacer(),
                Text(
                  '\$${product.price}',
                  style: subtitle.copyWith(
                    fontWeight: FontWeight.w700,
                    color: greenColor,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 32),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                CustomButton(
                  width: 150,
                  height: 50,
                  title: 'Add to Cart',
                  color: primaryColor,
                  colorText: whiteColor,
                  onPressed: () {
                    snackbar(
                      context,
                      msg: 'Coming Soon',
                      backgroundColor: orangeColor,
                      textColor: whiteColor,
                    );
                  },
                ),
                CustomButton(
                  width: 150,
                  height: 50,
                  title: 'Buy Now',
                  color: greenColor,
                  colorText: whiteColor,
                  onPressed: () {
                    snackbar(
                      context,
                      msg: 'Coming Soon',
                      backgroundColor: orangeColor,
                      textColor: whiteColor,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
