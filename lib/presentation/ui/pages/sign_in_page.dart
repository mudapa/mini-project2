part of 'package:mini_project_team_7/routes/routes.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();
  bool _isSignIn = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: ListView(
              children: [
                Text(
                  'Mini Store 2',
                  style: title.copyWith(fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                ),
                lottieSplash,
                const SizedBox(height: 16),
                Card(
                  elevation: 4,
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      children: [
                        Text(
                          _isSignIn ? 'Sign In' : 'Sign Up',
                          style: title.copyWith(
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                        const SizedBox(height: 16),
                        CustomTextForm(
                          hintText: 'Username',
                          labelText: 'Username',
                          controller: _userNameController,
                        ),
                        if (!_isSignIn)
                          CustomTextForm(
                            hintText: 'Email',
                            labelText: 'Email',
                            controller: _emailController,
                          ),
                        CustomTextForm(
                          hintText: 'Password',
                          labelText: 'Password',
                          controller: _passwordController,
                          obscureText: true,
                        ),
                        if (!_isSignIn)
                          CustomTextForm(
                            hintText: 'Confirm Password',
                            labelText: 'Confirm Password',
                            controller: _confirmPasswordController,
                            obscureText: true,
                          ),
                        const SizedBox(height: 16),
                        BlocConsumer<UserCubit, UserState>(
                          listener: (context, state) {
                            if (state is UserSignInSuccess) {
                              setState(() {
                                _isSignIn = true;
                              });
                              _userNameController.clear();
                              _emailController.clear();
                              _passwordController.clear();
                              _confirmPasswordController.clear();
                              GoRouter.of(context).go(NamedRoutes.mainPagePath);
                              snackbar(
                                context,
                                msg: 'Sign In Success',
                                backgroundColor: greenColor,
                                textColor: whiteColor,
                              );
                            }

                            if (state is UserRegisterSuccess) {
                              setState(() {
                                _isSignIn = true;
                              });
                              _userNameController.clear();
                              _emailController.clear();
                              _passwordController.clear();
                              _confirmPasswordController.clear();
                              snackbar(
                                context,
                                msg: 'Register Success',
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
                              title: _isSignIn ? 'Sign In' : 'Sign Up',
                              onPressed: () {
                                _isSignIn ? signIn() : signUp();
                              },
                              color: primaryColor,
                              colorText: whiteColor,
                            );
                          },
                        ),
                        const SizedBox(height: 16),
                        TextButton(
                          onPressed: () {
                            setState(() {
                              _isSignIn = !_isSignIn;
                            });
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                _isSignIn
                                    ? 'Don\'t have an account? '
                                    : 'Already have an account? ',
                                style: body,
                              ),
                              Text(
                                _isSignIn ? 'Sign Up' : 'Sign In',
                                style: body.copyWith(
                                  color: primaryColor,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void signIn() {
    if (_userNameController.text.isEmpty || _passwordController.text.isEmpty) {
      snackbar(
        context,
        msg: 'Username and Password must be filled',
        backgroundColor: redColor,
        textColor: whiteColor,
      );
    } else {
      context.read<UserCubit>().signIn(
            userName: _userNameController.text,
            password: _passwordController.text,
          );
    }
  }

  void signUp() {
    if (_passwordController.text != _confirmPasswordController.text) {
      snackbar(
        context,
        msg: 'Password and Confirm Password must be the same',
        backgroundColor: redColor,
        textColor: whiteColor,
      );
    } else {
      context.read<UserCubit>().signUp(
            email: _emailController.text,
            userName: _userNameController.text,
            password: _passwordController.text,
          );
    }
  }

  @override
  void dispose() {
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }
}
