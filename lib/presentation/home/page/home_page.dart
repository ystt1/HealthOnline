import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/bloc/auth/auth_state_cubit.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/core/configs/app_vector.dart';
import 'package:health_online/core/user_storage.dart';
import 'package:health_online/presentation/booking/page/booking_page.dart';
import 'package:health_online/presentation/history/page/history_page.dart';
import 'package:health_online/presentation/home/widgets/selection_card.dart';
import 'package:health_online/presentation/profile/page/profile_page.dart';
import 'package:health_online/presentation/splash/page/splash_page.dart';

import '../../../common/helper/app_navigator.dart';

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
            const SizedBox(
              height: 16,
            ),
            SelectionCard(
                onPress: () {
                  AppNavigator.push(context, const ProfilePage());
                },
                title: 'Thông tin cá nhân',
                iconAsset: AppVector.firstSelection),
            const SizedBox(
              height: 16,
            ),
            SelectionCard(
                onPress: () {
                  AppNavigator.push(context, const BookingPage());
                },
                title: 'Đặt lịch khám',
                iconAsset: AppVector.secondSelection),
            const SizedBox(
              height: 16,
            ),
            SelectionCard(
                onPress: () {
                  AppNavigator.push(context, const HistoryPage());
                },
                title: 'Lịch sử khám',
                iconAsset: AppVector.thirdSelection),
            const SizedBox(
              height: 16,
            ),
            SelectionCard(
                onPress: () {},
                title: 'Messages',
                iconAsset: AppVector.fourthSelection),
            const SizedBox(
              height: 16,
            ),
            SelectionCard(
                onPress: () {
                  context.read<AuthStateCubit>().logOut();
                  AppNavigator.pushAndRemove(context, SplashPage());
                },
                title: 'LogOut',
                iconAsset: AppVector.logOutSelection),
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
              Text(
                "hello ${UserStorage.getFullName()}",
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
