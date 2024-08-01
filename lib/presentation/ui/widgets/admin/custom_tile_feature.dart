part of 'package:mini_project_team_7/routes/routes.dart';

class CustomTileFeature extends StatelessWidget {
  final String name;
  final IconData icon;
  final String? count;
  final VoidCallback onTap;
  const CustomTileFeature({
    super.key,
    required this.name,
    required this.onTap,
    required this.icon,
    this.count,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(16),
        width: 180,
        height: 150,
        decoration: BoxDecoration(
          color: whiteColor,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(
            color: greyColor,
          ),
          boxShadow: [
            BoxShadow(
              color: greyColor.withOpacity(0.8),
              spreadRadius: 1,
              blurRadius: 4,
              offset: const Offset(3, 3),
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              color: primaryColor,
            ),
            const SizedBox(height: 8),
            Text(
              name,
              style: body.copyWith(
                fontWeight: FontWeight.w700,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 8),
            count == null
                ? const SizedBox()
                : Text(
                    count!,
                    style: title.copyWith(
                      fontWeight: FontWeight.w700,
                      color: primaryColor,
                    ),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
          ],
        ),
      ),
    );
  }
}
