part of 'package:mini_project_team_7/routes/routes.dart';

class ProductPage extends StatefulWidget {
  const ProductPage({super.key});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  final searchController = TextEditingController();
  List<ProductModel> products = [];
  List<ProductModel> filteredProducts = [];
  bool hasMoreData = true;

  @override
  void initState() {
    super.initState();
    context.read<ProductBloc>().add(LoadProductEvent());
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
        title: Text(
          'Mini Store 2',
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
          child: RefreshIndicator(
            onRefresh: () async {
              searchController.clear();
              context.read<ProductBloc>().add(LoadProductEvent());
            },
            child: BlocBuilder<ProductBloc, ProductState>(
              builder: (context, state) {
                if (state is ListProductLoading) {
                  return Center(
                    child: lottieLoading,
                  );
                }

                if (state is ListProductSuccess) {
                  products = state.products;
                  return ListView(children: [
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
                    const SizedBox(height: 16),
                    if (hasMoreData)
                      Center(
                        child: Text(
                          'No more data',
                          style: body.copyWith(
                            color: greyColor,
                          ),
                        ),
                      ),
                    const SizedBox(height: 128),
                  ]);
                }

                if (state is ListProductFailure) {
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
