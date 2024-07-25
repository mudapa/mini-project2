part of 'package:mini_project_team_7/routes/routes.dart';

class HistoryCart extends StatelessWidget {
  final List<CartModel> data;

  const HistoryCart({
    super.key,
    required this.data,
  });

  @override
  Widget build(BuildContext context) {
    bool hasMoreData = true;
    return SizedBox(
      height: 500,
      child: ListView(
        padding: const EdgeInsets.only(
          bottom: 128,
        ),
        children: [
          for (final item in data)
            Container(
              padding: const EdgeInsets.all(8),
              margin: const EdgeInsets.symmetric(
                vertical: 8,
              ),
              decoration: BoxDecoration(
                border: Border.all(
                  color: greyColor,
                ),
                borderRadius: BorderRadius.circular(8),
                color: whiteColor,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      Column(
                        children: item.products.map((e) {
                          return Column(
                            children: [
                              CustomTileCart(product: e),
                              const Divider(),
                            ],
                          );
                        }).toList(),
                      ),
                      Text(
                        'Total Product: ${item.products.length}',
                        style: body.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('dd-MM-yyyy').format(item.date),
                        style: body.copyWith(
                          fontWeight: FontWeight.w600,
                          color: placeholderColor,
                        ),
                        textAlign: TextAlign.end,
                      ),
                      InkWell(
                        onTap: () {},
                        child: Container(
                          height: 32,
                          width: 120,
                          decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                'Buy Again',
                                style: body.copyWith(
                                  color: whiteColor,
                                ),
                              ),
                              Icon(
                                Icons.refresh_outlined,
                                color: whiteColor,
                                size: 18,
                              )
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          if (hasMoreData)
            Center(
              child: Text(
                'No more data',
                style: body.copyWith(
                  color: greyColor,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
