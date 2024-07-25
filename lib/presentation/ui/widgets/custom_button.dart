part of 'package:mini_project_team_7/routes/routes.dart';

class CustomButton extends StatelessWidget {
  final String? title;
  final VoidCallback? onPressed;
  final Color? color;
  final Color? colorText;
  final Icon? icon;
  final double? width;
  final double? height;
  final double? fontSize;
  const CustomButton({
    super.key,
    this.title,
    this.onPressed,
    this.color,
    this.colorText,
    this.icon,
    this.width,
    this.height,
    this.fontSize,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? double.infinity,
      height: height ?? 55,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(
              16,
            ),
          ),
          backgroundColor: color,
        ),
        child: icon != null
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    icon!.icon,
                    color: colorText,
                  ),
                  const SizedBox(width: 16),
                  Text(
                    title!,
                    style: TextStyle(
                      color: colorText,
                      fontSize: fontSize,
                    ),
                  ),
                ],
              )
            : Text(
                title!,
                style: TextStyle(
                  color: colorText,
                ),
              ),
      ),
    );
  }
}
