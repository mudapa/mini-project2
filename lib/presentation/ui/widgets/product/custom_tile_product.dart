part of 'package:mini_project_team_7/routes/routes.dart';

class CustomTileProduct extends StatelessWidget {
  final ProductModel product;
  const CustomTileProduct({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProfileBloc, ProfileState>(
      builder: (context, state) {
        if (state is ProfileLoadingState) {
          return Center(
            child: lottieLoading,
          );
        }
        if (state is ProfileLoadedState) {
          final user = state.profile;
          return InkWell(
            onTap: () {
              if (user.role == 0) {}

              if (user.role == 1) {
                GoRouter.of(context)
                    .go(NamedRoutes.detailProductPath, extra: product);
              }
            },
            child: Container(
              margin: const EdgeInsets.only(bottom: 8),
              padding: const EdgeInsets.all(16),
              width: 180,
              height: 380,
              decoration: BoxDecoration(
                color: whiteColor,
                borderRadius: BorderRadius.circular(8),
                border: Border.all(
                  color: greyColor,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      product.image!,
                      width: 200,
                      height: 200,
                      fit: BoxFit.cover,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    product.title!,
                    style: body.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    children: [
                      Text(
                        '\$ ${product.price!}',
                        style: caption.copyWith(
                          fontWeight: FontWeight.w700,
                          color: primaryColor,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const Spacer(),
                      if (user.role == 1)
                        Row(
                          children: [
                            Icon(
                              Icons.star_rounded,
                              color: orangeColor,
                            ),
                            Text(
                              product.rating!.rate.toString(),
                              style: caption.copyWith(
                                fontWeight: FontWeight.w700,
                                color: greyColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      if (user.role == 0)
                        Row(
                          children: [
                            Text('Count: ', style: caption),
                            Text(
                              product.rating!.count.toString(),
                              style: caption.copyWith(
                                fontWeight: FontWeight.w700,
                                color: greyColor,
                              ),
                              maxLines: 2,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  if (user.role == 1)
                    Text(
                      product.description!,
                      style: caption.copyWith(
                        fontWeight: FontWeight.w700,
                        color: greyColor,
                      ),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  if (user.role == 0)
                    CustomButton(
                      icon: Icon(Icons.edit_rounded, color: whiteColor),
                      title: 'Edit',
                      colorText: whiteColor,
                      color: primaryColor,
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
            ),
          );
        }

        return const SizedBox();
      },
    );
  }
}
