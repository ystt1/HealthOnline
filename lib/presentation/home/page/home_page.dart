import 'package:flutter/material.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/core/configs/app_vector.dart';
import 'package:health_online/presentation/home/widgets/selection_card.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            const SizedBox(
              height: 68,
            ),
            _titleAndUserProfile(context),
            const SizedBox(height: 16,),
            SelectionCard(onPress: (){}, title: 'Thông tin cá nhân', iconAsset: AppVector.firstSelection),
            const SizedBox(height: 16,),
            SelectionCard(onPress: (){}, title: 'Đặt lịch khám', iconAsset: AppVector.secondSelection),
            const SizedBox(height: 16,),
            SelectionCard(onPress: (){}, title: 'Lịch sử khám', iconAsset: AppVector.thirdSelection),
            const SizedBox(height: 16,),
            SelectionCard(onPress: (){}, title: 'Messages', iconAsset: AppVector.fourthSelection),

          ],
        ),
      ),
    );
  }

  Widget _titleAndUserProfile(BuildContext context) {
    return Container(
      height: 46,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Image.asset(
                AppVector.waveHand,
                width: 46,
              ),
              const SizedBox(
                width: 10,
              ),
              const Text(
                "hello A",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
              )
            ],
          ),
          Container(
            width: 46,
            alignment: Alignment.centerRight,
            padding: const EdgeInsets.all(8),
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.background,
            ),
            child: Container(
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(AppVector.avatar), fit: BoxFit.contain),
              ),
            ),
          )
        ],
      ),
    );
  }
}
