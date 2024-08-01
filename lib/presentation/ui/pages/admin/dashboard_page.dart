part of 'package:mini_project_team_7/routes/routes.dart';

class DashboardPage extends StatelessWidget {
  final UserModel user;
  const DashboardPage({super.key, required this.user});

  @override
  Widget build(BuildContext context) {
    context.read<UserCubit>().getListUser();
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Mini Store 3',
                  style: title.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Hello, ${user.userName}',
                  style: caption,
                ),
              ],
            ),
            Text('Manage', style: title.copyWith(color: greenColor)),
            BlocConsumer<UserCubit, UserState>(
              listener: (context, state) {
                if (state is UserSignOutSuccess) {
                  GoRouter.of(context).go(NamedRoutes.splashPath);
                  snackbar(
                    context,
                    msg: 'Logout Success',
                    backgroundColor: greenColor,
                    textColor: whiteColor,
                  );
                }
              },
              builder: (context, state) {
                return IconButton.filled(
                  style: ButtonStyle(
                    shape: WidgetStateProperty.all(
                      RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    backgroundColor: WidgetStateProperty.all(redColor),
                  ),
                  icon: Icon(Icons.logout_rounded, color: whiteColor),
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        return AlertDialog(
                          title: const Text('Logout'),
                          content: const Text('Are you sure want to logout?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                context.read<UserCubit>().signOut();
                                GoRouter.of(context).pop();
                              },
                              child: const Text('Yes'),
                            ),
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              child: const Text('No'),
                            ),
                          ],
                        );
                      },
                    );
                  },
                );
              },
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: RefreshIndicator(
            onRefresh: () async {
              context.read<UserCubit>().getListUser();
            },
            child: ListView(
              children: [
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Dashboard',
                    style: subtitle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    BlocBuilder<UserCubit, UserState>(
                      builder: (context, state) {
                        if (state is UserLoading) {
                          return const Center(
                            child: CircularProgressIndicator(),
                          );
                        }
                        return CustomTileFeature(
                          onTap: () {},
                          icon: Icons.people_alt_rounded,
                          name: 'Total User',
                          count: state is ListUserSuccess
                              ? state.users.length.toString()
                              : '0',
                        );
                      },
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                Center(
                  child: Text(
                    'Feature',
                    style: subtitle.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                Wrap(
                  spacing: 16,
                  runSpacing: 16,
                  children: [
                    CustomTileFeature(
                      onTap: () {
                        GoRouter.of(context).go(NamedRoutes.manageUserPath);
                      },
                      icon: Icons.manage_accounts_rounded,
                      name: 'Manage User',
                    ),
                    CustomTileFeature(
                      onTap: () {
                        GoRouter.of(context).go(NamedRoutes.manageProductPath);
                      },
                      icon: Icons.shopping_bag_rounded,
                      name: 'Manage Product',
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
