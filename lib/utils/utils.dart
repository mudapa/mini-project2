part of 'package:mini_project_team_7/routes/routes.dart';

Box get settings => Hive.box('settings');
UserCubit userCubit(BuildContext context) => context.read<UserCubit>();
CameraCubit cameraCubit(BuildContext context) => context.read<CameraCubit>();

FirebaseStorage get storage => FirebaseStorage.instance;

void snackbar(
  BuildContext context, {
  required String msg,
  required Color backgroundColor,
  required Color textColor,
}) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(msg, style: TextStyle(color: textColor)),
      backgroundColor: backgroundColor,
    ),
  );
}

void pickImage(BuildContext context) async {
  final cubitImage = cameraCubit(context);
  final ImagePicker picker = ImagePicker();

  final XFile? image = await picker.pickImage(source: ImageSource.gallery);

  if (image?.path != null) {
    cubitImage.uploadImage(path: image!.path);
  }
}
