part of 'package:mini_project_team_7/routes/routes.dart';

class CustomTextForm extends StatelessWidget {
  final TextEditingController? controller;
  final String hintText;
  final String labelText;
  final TextInputType? keyboardType;
  final int? maxLength;
  final int? maxLine;
  final bool obscureText;
  final bool? readOnly;
  final Function(String)? onChanged;
  final Function(String)? onFieldSubmitted;
  final Function()? onEditingComplete;
  final String Function(String?)? validator;
  final String? initialValue;
  const CustomTextForm({
    super.key,
    this.controller,
    required this.hintText,
    required this.labelText,
    this.keyboardType,
    this.maxLength,
    this.obscureText = false,
    this.onChanged,
    this.validator,
    this.initialValue,
    this.onFieldSubmitted,
    this.onEditingComplete,
    this.maxLine,
    this.readOnly,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          TextFormField(
            readOnly: readOnly ?? false,
            maxLines: maxLine ?? 1,
            initialValue: initialValue,
            validator: validator,
            onChanged: onChanged,
            onFieldSubmitted: onFieldSubmitted,
            onEditingComplete: onEditingComplete,
            controller: controller,
            obscureText: obscureText,
            decoration: InputDecoration(
              hintText: hintText,
              filled: true,
              fillColor: greyColor.withOpacity(0.1),
              labelText: labelText,
              labelStyle: body,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  8,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(
                  16,
                ),
                borderSide: BorderSide(
                  color: blackColor,
                ),
              ),
            ),
            keyboardType: keyboardType,
            maxLength: maxLength,
          ),
        ],
      ),
    );
  }
}
