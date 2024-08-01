part of 'package:mini_project_team_7/routes/routes.dart';

class ManageUserPage extends StatefulWidget {
  const ManageUserPage({super.key});

  @override
  State<ManageUserPage> createState() => _ManageUserPageState();
}

class _ManageUserPageState extends State<ManageUserPage> {
  @override
  void initState() {
    userCubit(context).getListUser();
    super.initState();
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
        title: Text('Manage User', style: title),
      ),
      body: SafeArea(
        child: RefreshIndicator(
          onRefresh: () async {
            userCubit(context).getListUser();
          },
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16, top: 16),
            child: BlocBuilder<UserCubit, UserState>(
              builder: (context, state) {
                return ListView(
                  children: [
                    Center(
                      child: Text(
                        'List of Users',
                        style: subtitle.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    if (state is UserLoading)
                      const Center(child: CircularProgressIndicator()),
                    if (state is ListUserSuccess)
                      ...state.users.map(
                        (user) => Card(
                          color: Colors.primaries[state.users.indexOf(user) %
                              Colors.primaries.length],
                          child: ListTile(
                            title: Text(user.userName!,
                                style: title.copyWith(color: whiteColor)),
                            subtitle: Text(user.email!,
                                style: body.copyWith(color: whiteColor)),
                            leading: CircleAvatar(
                              backgroundColor: whiteColor,
                              child: Text(user.userName![0],
                                  style: title.copyWith(
                                      color: Colors.primaries[
                                          state.users.indexOf(user) %
                                              Colors.primaries.length])),
                            ),
                            trailing: IconButton(
                              icon: Icon(Icons.edit, color: whiteColor),
                              onPressed: () {
                                GoRouter.of(context).go(
                                    NamedRoutes.detailUserPath,
                                    extra: user);
                              },
                            ),
                          ),
                        ),
                      ),
                    if (state is UserFailure)
                      Center(
                        child: lottieNoInternet,
                      ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
              context: context,
              builder: (context) {
                return const AddUserModal();
              });
        },
        child: Icon(Icons.add, color: whiteColor),
      ),
    );
  }
}
