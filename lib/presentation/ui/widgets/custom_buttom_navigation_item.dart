part of 'package:mini_project_team_7/routes/routes.dart';

class CustomBottomNavigationItem extends StatelessWidget {
  final int index;
  final IconData icon;

  const CustomBottomNavigationItem({
    super.key,
    required this.index,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.read<PageCubit>().setPage(index);
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const SizedBox(),
          Icon(
            icon,
            color: context.read<PageCubit>().state == index
                ? Colors.blue
                : Colors.grey,
          ),
          Container(
            width: 30,
            height: 2,
            decoration: BoxDecoration(
              color: context.read<PageCubit>().state == index
                  ? Colors.blue
                  : Colors.grey,
              borderRadius: BorderRadius.circular(18),
            ),
          ),
        ],
      ),
    );
  }
}
