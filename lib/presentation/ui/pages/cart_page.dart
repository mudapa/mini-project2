part of 'package:mini_project_team_7/routes/routes.dart';

class CartPage extends StatelessWidget {
  const CartPage({super.key});

  @override
  Widget build(BuildContext context) {
    context.read<CartBloc>().add(FetchListCart());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Shopping Cart',
          style: title.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
            child: BlocBuilder<CartBloc, CartState>(
              builder: (context, state) {
                if (state is CartLoadingState) {
                  return Center(
                    child: lottieLoading,
                  );
                }
                if (state is CartLoadedState) {
                  final data = state.cart;
                  if (data.isNotEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Cart',
                          style: title.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: greyColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              lottieCartEmpty,
                              Text(
                                'Your cart is empty',
                                style: body.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: placeholderColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CustomButton(
                                onPressed: () {
                                  context.read<PageCubit>().setPage(0);
                                },
                                width: 200,
                                color: primaryColor,
                                colorText: whiteColor,
                                title: 'Start Shopping',
                              ),
                            ],
                          ),
                        ),
                        HistoryCart(data: data),
                      ],
                    );
                  }

                  if (data.isEmpty) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 16),
                        Text(
                          'Cart',
                          style: title.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                            vertical: 16,
                          ),
                          padding: const EdgeInsets.all(16),
                          width: double.infinity,
                          decoration: BoxDecoration(
                            color: whiteColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(
                              color: greyColor,
                            ),
                          ),
                          child: Column(
                            children: [
                              lottieCartEmpty,
                              Text(
                                'Your cart is empty',
                                style: body.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: placeholderColor,
                                ),
                              ),
                              const SizedBox(height: 16),
                              CustomButton(
                                onPressed: () {
                                  context.read<PageCubit>().setPage(0);
                                },
                                width: 200,
                                color: primaryColor,
                                colorText: whiteColor,
                                title: 'Start Shopping',
                              ),
                            ],
                          ),
                        ),
                      ],
                    );
                  }
                }

                if (state is CartErrorState) {
                  return Center(
                    child: lottieNoInternet,
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ),
      ),
    );
  }
}
