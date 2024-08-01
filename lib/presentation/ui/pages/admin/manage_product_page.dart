part of 'package:mini_project_team_7/routes/routes.dart';

class ManageProductPage extends StatefulWidget {
  const ManageProductPage({super.key});

  @override
  State<ManageProductPage> createState() => _ManageProductPageState();
}

class _ManageProductPageState extends State<ManageProductPage> {
  final searchController = TextEditingController();
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(FetchListProduct());
    searchController.addListener(_filterProducts);
  }

  @override
  void dispose() {
    searchController.removeListener(_filterProducts);
    searchController.dispose();
    super.dispose();
  }

  void _filterProducts() {
    final query = searchController.text.toLowerCase();
    setState(() {
      filteredProducts = products
          .where((product) => product.title!.toLowerCase().contains(query))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: blackColor),
          onPressed: () {
            GoRouter.of(context).go(NamedRoutes.mainPagePath);
          },
        ),
        title: Text('Manage Product', style: title),
        actions: [
          IconButton.filled(
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
              ),
              backgroundColor: WidgetStateProperty.all(greenColor),
            ),
            icon: Icon(Icons.add_rounded, color: whiteColor),
            onPressed: () {
              GoRouter.of(context).go(NamedRoutes.addProductPath);
            },
          ),
        ],
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading) {
                return Center(
                  child: lottieLoading,
                );
              }

              if (state is ProductListSuccess) {
                products = state.products;
                return ListView(
                  children: [
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: whiteColor,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(
                          color: greyColor,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: CustomTextForm(
                                  hintText: 'Backpack ..',
                                  controller: searchController,
                                  labelText: 'Search Product',
                                ),
                              ),
                              const SizedBox(width: 16),
                              InkWell(
                                onTap: _filterProducts,
                                child: Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                    color: primaryColor,
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Icon(
                                    Icons.search_rounded,
                                    color: whiteColor,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Wrap(
                      spacing: 16,
                      runSpacing: 16,
                      children: filteredProducts.isEmpty
                          ? products
                              .map((product) =>
                                  CustomTileProduct(product: product))
                              .toList()
                          : filteredProducts
                              .map((product) =>
                                  CustomTileProduct(product: product))
                              .toList(),
                    ),
                  ],
                );
              }

              if (state is ProductFailure) {
                return Center(
                  child: lottieNoInternet,
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
