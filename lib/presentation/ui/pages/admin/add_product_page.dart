part of 'package:mini_project_team_7/routes/routes.dart';

class AddProductPage extends StatelessWidget {
  const AddProductPage({super.key});

  @override
  Widget build(BuildContext context) {
    final titleController = TextEditingController();
    final priceController = TextEditingController();
    final descriptionController = TextEditingController();
    final categoryController = TextEditingController();
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: blackColor),
          onPressed: () {
            GoRouter.of(context).go(NamedRoutes.manageProductPath);
          },
        ),
        title: Text('Add Product', style: title),
      ),
      body: SafeArea(
        child: Container(
          padding: const EdgeInsets.all(16),
          margin: const EdgeInsets.all(16),
          height: 400,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: greyColor,
            ),
          ),
          child: ListView(
            children: [
              CustomTextForm(
                labelText: 'Title',
                hintText: 'Enter title',
                controller: titleController,
              ),
              CustomTextForm(
                labelText: 'Price',
                hintText: 'Enter price',
                controller: priceController,
                keyboardType: TextInputType.number,
              ),
              CustomTextForm(
                labelText: 'Description',
                hintText: 'Enter description',
                controller: descriptionController,
              ),
              CustomTextForm(
                labelText: 'Category',
                hintText: 'Enter category',
                controller: categoryController,
              ),
              const SizedBox(height: 16),
              BlocConsumer<ProductBloc, ProductState>(
                listener: (context, state) {
                  if (state is ProductSuccess) {
                    GoRouter.of(context).go(NamedRoutes.manageProductPath);
                    snackbar(
                      context,
                      msg: 'Success add product',
                      backgroundColor: greenColor,
                      textColor: whiteColor,
                    );
                  }

                  if (state is ProductFailure) {
                    snackbar(
                      context,
                      msg: state.message,
                      backgroundColor: redColor,
                      textColor: whiteColor,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is ProductLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }

                  return CustomButton(
                    title: 'Add Product',
                    color: greenColor,
                    colorText: whiteColor,
                    onPressed: () {
                      final priceText = priceController.text;
                      double? price = double.tryParse(priceText);

                      if (price == null) {
                        snackbar(
                          context,
                          msg: 'Invalid price. Please enter a valid number.',
                          backgroundColor: redColor,
                          textColor: whiteColor,
                        );
                        return;
                      }

                      context.read<ProductBloc>().add(
                            AddProduct(
                              title: titleController.text,
                              price: price,
                              description: descriptionController.text,
                              category: categoryController.text,
                            ),
                          );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
