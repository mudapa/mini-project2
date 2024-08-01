part of 'package:mini_project_team_7/routes/routes.dart';

class DetailProfilePage extends StatefulWidget {
  final UserModel user;
  const DetailProfilePage({super.key, required this.user});

  @override
  State<DetailProfilePage> createState() => _DetailProfilePageState();
}

class _DetailProfilePageState extends State<DetailProfilePage> {
  final emailController = TextEditingController();
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  void initState() {
    emailController.text = widget.user.email!;
    userNameController.text = widget.user.userName!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Widget inputSection() {
      return Column(
        children: [
          BlocBuilder<CameraCubit, CameraState>(
            builder: (context, state) {
              final imagePath = state.linkGambar;
              return InkWell(
                onTap: () {
                  pickImage(context);
                },
                child: Stack(
                  children: [
                    SizedBox(
                        width: 150,
                        height: 150,
                        child: imagePath != null && imagePath.isNotEmpty
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(75),
                                child: Image.network(
                                  state.linkGambar!,
                                  loadingBuilder:
                                      (context, child, loadingProgress) {
                                    if (loadingProgress == null) return child;

                                    final loaded =
                                        (loadingProgress.cumulativeBytesLoaded);
                                    final expected =
                                        (loadingProgress.expectedTotalBytes ??
                                            0);

                                    if (loaded < expected) {
                                      return Container(
                                        alignment: Alignment.center,
                                        child: CircularProgressIndicator(
                                          value: loaded / expected,
                                        ),
                                      );
                                    }

                                    return child;
                                  },
                                  errorBuilder: (context, error, stackTrace) {
                                    return const Center(
                                      child: Text('Failed to load image'),
                                    );
                                  },
                                ),
                              )
                            : widget.user.image == null ||
                                    widget.user.image == ""
                                ? CircleAvatar(
                                    backgroundColor:
                                        primaryColor.withOpacity(0.8),
                                    radius: 50,
                                    child: Text(
                                      widget.user.userName![0].toUpperCase(),
                                      style: title.copyWith(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    backgroundColor:
                                        primaryColor.withOpacity(0.8),
                                    radius: 50,
                                    child: Text(
                                      widget.user.userName![0].toUpperCase(),
                                      style: title.copyWith(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )),
                    IconButton.filled(
                      iconSize: 24,
                      style: ButtonStyle(
                        backgroundColor: WidgetStateProperty.all(
                            greenColor.withOpacity(0.8)),
                      ),
                      onPressed: () {
                        pickImage(context);
                      },
                      icon: const Icon(Icons.camera_alt_rounded),
                    ),
                  ],
                ),
              );
            },
          ),
          const SizedBox(height: 16),
          CustomTextForm(
            labelText: 'User Name',
            hintText: 'New User Name',
            controller: userNameController,
          ),
          const SizedBox(height: 8),
          CustomTextForm(
            labelText: 'Email',
            hintText: 'New Email',
            controller: emailController,
          ),
          const SizedBox(height: 8),
          CustomTextForm(
            labelText: 'Confirm Password',
            hintText: 'Password',
            controller: passwordController,
            obscureText: true,
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
              GoRouter.of(context).go(NamedRoutes.mainPagePath);
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
                            BlocBuilder<CameraCubit, CameraState>(
                              builder: (context, state) {
                                return TextButton(
                                  onPressed: () {
                                    if (passwordController.text.isEmpty) {
                                      GoRouter.of(context).pop();
                                      snackbar(
                                        context,
                                        msg: 'Verify your password',
                                        backgroundColor: redColor,
                                        textColor: whiteColor,
                                      );
                                    }

                                    if (widget.user.password ==
                                        passwordController.text) {
                                      context.read<UserCubit>().updateUser(
                                            id: widget.user.id!,
                                            userName: userNameController.text,
                                            email: emailController.text,
                                            image: state.linkGambar ??
                                                widget.user.image!,
                                            role: widget.user.role!,
                                          );
                                    }
                                  },
                                  child: const Text('YES'),
                                );
                              },
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

      return Column(
        children: [
          saveButton(),
        ],
      );
    }

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Edit User',
          style: title,
        ),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_rounded, color: blackColor),
          onPressed: () {
            GoRouter.of(context).go(NamedRoutes.mainPagePath);
          },
        ),
      ),
      body: SafeArea(
        child: Container(
          margin: const EdgeInsets.all(16),
          padding: const EdgeInsets.all(16),
          height: 500,
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
    passwordController.dispose();
    super.dispose();
  }
}
