part of 'package:mini_project_team_7/routes/routes.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  bool isNotificationActive = false;

  @override
  void initState() {
    _checkNotifStatus();
    super.initState();
  }

  Future<void> _checkNotifStatus() async {
    final isNotificationActive =
        await context.read<NotificationCubit>().loadNotificationStatus();
    setState(() {
      this.isNotificationActive = isNotificationActive;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Mini Store 3',
          style: title.copyWith(
            fontWeight: FontWeight.w700,
          ),
        ),
        actions: [
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
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
          ),
          child: BlocBuilder<ProfileBloc, ProfileState>(
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Center(child: lottieLoading);
              }

              if (state is ProfileLoadedState) {
                return ListView(
                  children: [
                    const SizedBox(height: 16),
                    Card(
                      color: whiteColor,
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            state.profile.image == null ||
                                    state.profile.image == ""
                                ? CircleAvatar(
                                    backgroundColor:
                                        primaryColor.withOpacity(0.8),
                                    radius: 32,
                                    child: Text(
                                      state.profile.userName![0].toUpperCase(),
                                      style: title.copyWith(
                                        color: whiteColor,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 32,
                                    backgroundImage: NetworkImage(
                                      state.profile.image!,
                                    ),
                                  ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                state.profile.name == null
                                    ? Text(
                                        '${state.profile.userName}',
                                        style: title.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      )
                                    : Text(
                                        '${state.profile.name!.firstname} ${state.profile.name!.lastname}',
                                        style: title.copyWith(
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                Text(
                                  state.profile.email!,
                                  style: body.copyWith(
                                    fontWeight: FontWeight.w600,
                                    color: placeholderColor,
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(width: 32),
                            IconButton.filled(
                              style: ButtonStyle(
                                shape: WidgetStateProperty.all(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                                backgroundColor: WidgetStateProperty.all(
                                  orangeColor,
                                ),
                              ),
                              icon: Icon(Icons.edit_rounded, color: whiteColor),
                              onPressed: () {
                                GoRouter.of(context).go(
                                  NamedRoutes.updateProfilePath,
                                  extra: state.profile,
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    Card(
                      color: whiteColor,
                      elevation: 4,
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Icon(
                              Icons.notifications_rounded,
                              size: 32,
                              color: greyColor,
                            ),
                            SizedBox(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Notification',
                                    style: subtitle.copyWith(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Get notified when new product is available',
                                    style: caption.copyWith(
                                      color: placeholderColor,
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ],
                              ),
                            ),
                            BlocConsumer<NotificationCubit, NotificationState>(
                              listener: (context, state) {
                                if (state is NotificationActive) {
                                  setState(() {
                                    isNotificationActive =
                                        state.isNotificationActive;
                                  });
                                }

                                if (state is NotificationFailed) {
                                  snackbar(
                                    context,
                                    msg: state.error,
                                    backgroundColor: redColor,
                                    textColor: whiteColor,
                                  );
                                }
                              },
                              builder: (context, state) {
                                return Switch.adaptive(
                                  value: isNotificationActive,
                                  onChanged: (value) {
                                    context
                                        .read<NotificationCubit>()
                                        .toggleNotification(value);
                                  },
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 16),
                    state.profile.address == null
                        ? const SizedBox()
                        : Card(
                            color: whiteColor,
                            elevation: 4,
                            child: Padding(
                              padding: const EdgeInsets.all(16),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text('Your Address',
                                          style: title.copyWith(
                                              fontWeight: FontWeight.w600)),
                                      const Spacer(),
                                      TextButton(
                                        onPressed: () {},
                                        child: Text(
                                          'Change Address >',
                                          style: body.copyWith(
                                            color: greyColor,
                                            fontWeight: FontWeight.w600,
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    '${state.profile.address!.city}, ${state.profile.address!.street!}, ${state.profile.address!.number}, ${state.profile.address!.zipcode!}',
                                    style: body,
                                  ),
                                  const SizedBox(height: 16),
                                  MiniMap(
                                    center: LatLng(
                                      double.parse(state
                                          .profile.address!.geolocation!.lat!),
                                      double.parse(state
                                          .profile.address!.geolocation!.long!),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                    const SizedBox(height: 128),
                  ],
                );
              }
              if (state is ProfileErrorState) {
                return Center(
                  child: lottieNoInternet,
                );
              }

              return const SizedBox();
            },
          ),
        ),
      ),
    );
  }
}
