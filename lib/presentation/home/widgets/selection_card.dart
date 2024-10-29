import 'package:flutter/widgets.dart';
import 'package:health_online/core/app_colors.dart';

class SelectionCard extends StatelessWidget {
  final GestureTapCallback onPress;
  final String title;
  final String iconAsset;
  const SelectionCard({super.key, required this.onPress, required this.title, required this.iconAsset});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPress,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        height: 116,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(12)
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(title,style: const TextStyle(fontWeight: FontWeight.bold,fontSize: 20),),
            Image.asset(iconAsset,)
          ],
        ),
      ),
    );
  }
}
