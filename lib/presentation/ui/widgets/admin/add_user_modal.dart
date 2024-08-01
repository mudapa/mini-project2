part of 'package:mini_project_team_7/routes/routes.dart';

class AddUserModal extends StatefulWidget {
  const AddUserModal({super.key});

  @override
  State<AddUserModal> createState() => _AddUserModalState();
}

class _AddUserModalState extends State<AddUserModal> {
  final userNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.of(context).size.height * 0.6,
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
        ),
        child: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Text(
                'Add User',
                style: title.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 16),
              CustomTextForm(
                controller: userNameController,
                labelText: 'User Name',
                hintText: 'User Name',
              ),
              CustomTextForm(
                controller: emailController,
                labelText: 'Email',
                hintText: 'Email',
              ),
              CustomTextForm(
                controller: passwordController,
                labelText: 'Password',
                hintText: 'Password',
                obscureText: true,
              ),
              const SizedBox(height: 16),
              BlocConsumer<UserCubit, UserState>(
                listener: (context, state) {
                  if (state is UserRegisterSuccess) {
                    Navigator.pop(context);
                    userCubit(context).getListUser();
                    snackbar(
                      context,
                      msg: 'Add User Success',
                      backgroundColor: greenColor,
                      textColor: whiteColor,
                    );
                  }
                  if (state is UserFailure) {
                    snackbar(
                      context,
                      msg: state.message,
                      backgroundColor: redColor,
                      textColor: whiteColor,
                    );
                  }
                },
                builder: (context, state) {
                  if (state is UserLoading) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  return CustomButton(
                    title: 'ADD',
                    onPressed: () {
                      context.read<UserCubit>().signUp(
                            email: emailController.text,
                            password: passwordController.text,
                            userName: userNameController.text,
                          );
                    },
                    color: greenColor,
                    colorText: whiteColor,
                    width: double.infinity,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    userNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }
}
