part of 'package:mini_project_team_7/routes/routes.dart';

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    Widget buildContent(int currentIndex) {
      switch (currentIndex) {
        case 0:
          return const ProductPage();
        case 1:
          return const CartPage();
        case 2:
          return const ProfilePage();
        default:
          return const ProductPage();
      }
    }

    Widget customButtonNavigation() {
      return Align(
        alignment: Alignment.bottomCenter,
        child: Container(
          width: double.infinity,
          height: 60,
          margin: const EdgeInsets.only(
            bottom: 30,
            left: 16,
            right: 16,
          ),
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [
              BoxShadow(
                color: greyColor.withOpacity(0.8),
                spreadRadius: 1,
                blurRadius: 4,
                offset: const Offset(0, 3),
              ),
            ],
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              CustomBottomNavigationItem(
                index: 0,
                icon: iconHome,
              ),
              CustomBottomNavigationItem(
                index: 1,
                icon: iconList,
              ),
              CustomBottomNavigationItem(
                index: 2,
                icon: iconSetting,
              ),
            ],
          ),
        ),
      );
    }

    return BlocBuilder<PageCubit, int>(
      builder: (context, currentIndex) {
        return Scaffold(
          body: Stack(
            children: [
              buildContent(currentIndex),
              customButtonNavigation(),
            ],
          ),
        );
      },
    );
  }
}
