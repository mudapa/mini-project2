part of 'package:mini_project_team_7/routes/routes.dart';

class DetailUserPage extends StatefulWidget {
  final UserModel user;
  const DetailUserPage({super.key, required this.user});

  @override
  State<DetailUserPage> createState() => _DetailUserPageState();
}

class _DetailUserPageState extends State<DetailUserPage> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  int selectedRole = 1;

  @override
  void initState() {
    emailController.text = widget.user.email!;
    userNameController.text = widget.user.userName!;
    selectedRole = widget.user.role!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget inputSection() {
      return Column(
        children: [
          CustomTextForm(
            labelText: 'User Name',
            hintText: 'New User Name',
            controller: userNameController,
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            labelText: 'Email',
            hintText: 'New Email',
            controller: emailController,
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: DropdownButtonFormField<int>(
              value: selectedRole,
              items: const [
                DropdownMenuItem<int>(
                  value: 0,
                  child: Text('Admin'),
                ),
                DropdownMenuItem<int>(
                  value: 1,
                  child: Text('User'),
                ),
              ],
              onChanged: (int? newValue) {
                setState(() {
                  selectedRole = newValue!;
                });
              },
              decoration: const InputDecoration(
                labelText: 'Role',
              ),
            ),
          ),
        ],
      );
    }

    Widget buttonSection() {
      Widget saveButton() {
        return BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserUpdateSuccess) {
              GoRouter.of(context).pop();
              GoRouter.of(context).go(NamedRoutes.manageUserPath);
              snackbar(
                context,
                msg: 'Success update user',
                backgroundColor: greenColor,
                textColor: whiteColor,
              );
            }

            if (state is UserUpdateFailure) {
              snackbar(
                context,
                msg: state.message,
                backgroundColor: redColor,
                textColor: whiteColor,
              );
            }
          },
          builder: (context, state) {
            if (state is UserUpdateLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomButton(
              title: 'SAVE',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text(
                              'Are you sure want to update this user?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              child: const Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () {
                                context.read<UserCubit>().updateUser(
                                      id: widget.user.id!,
                                      userName: userNameController.text,
                                      role: selectedRole,
                                      email: emailController.text,
                                      image: widget.user.image ?? '',
                                    );
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        ));
              },
              color: greenColor,
              colorText: whiteColor,
              width: double.infinity,
            );
          },
        );
      }

      Widget deleteButton() {
        return BlocConsumer<UserCubit, UserState>(
          listener: (context, state) {
            if (state is UserDeleteSuccess) {
              GoRouter.of(context).pop();
              GoRouter.of(context).go(NamedRoutes.manageUserPath);
              snackbar(
                context,
                msg: 'Success delete user',
                backgroundColor: greenColor,
                textColor: whiteColor,
              );
            }

            if (state is UserDeleteFailure) {
              snackbar(
                context,
                msg: state.message,
                backgroundColor: redColor,
                textColor: whiteColor,
              );
            }
          },
          builder: (context, state) {
            if (state is UserDeleteLoading) {
              return const Center(child: CircularProgressIndicator());
            }

            return CustomButton(
              title: 'DELETE',
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                          title: const Text('Confirmation'),
                          content: const Text(
                              'Are you sure want to delete this user?'),
                          actions: [
                            TextButton(
                              onPressed: () {
                                GoRouter.of(context).pop();
                              },
                              child: const Text('CANCEL'),
                            ),
                            TextButton(
                              onPressed: () {
                                context
                                    .read<UserCubit>()
                                    .deleteUser(widget.user.id!);
                              },
                              child: const Text('YES'),
                            ),
                          ],
                        ));
              },
              color: redColor,
              colorText: whiteColor,
              width: double.infinity,
            );
          },
        );
      }

      return Column(
        children: [
          saveButton(),
          const SizedBox(height: 16),
          deleteButton(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Detail User',
          style: title,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: blackColor),
          onPressed: () {
            GoRouter.of(context).go(NamedRoutes.manageUserPath);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          height: 450,
          decoration: BoxDecoration(
            color: whiteColor,
            borderRadius: BorderRadius.circular(16),
            boxShadow: [
              BoxShadow(
                color: blackColor.withOpacity(0.1),
                blurRadius: 10,
                spreadRadius: 5,
              ),
            ],
          ),
          child: ListView(
            children: [
              inputSection(),
              const SizedBox(height: 16),
              buttonSection(),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    emailController.dispose();
    userNameController.dispose();
    super.dispose();
  }
}
