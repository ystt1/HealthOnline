import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/helper/app_navigator.dart';
import 'package:health_online/common/widget/back_and_title.dart';
import 'package:health_online/core/configs/app_vector.dart';
import 'package:health_online/domain/booking/entity/doctor.dart';
import 'package:health_online/presentation/booking/bloc/get_list_doctor_cubit.dart';
import 'package:health_online/presentation/booking/bloc/get_list_doctor_state.dart';
import 'package:health_online/presentation/booking/page/details_doctor_page.dart';

import '../../../core/app_colors.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text('Chọn thông tin bác sĩ'),
      ),
      body: BlocProvider<GetListDoctorCubit>(
        create: (BuildContext context) {
          var cubit = GetListDoctorCubit();
          cubit.getList("");
          return cubit;
        },
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
          child: Column(
            children: [
              _searchBar(),
              const SizedBox(
                height: 15,
              ),
              _doctors(context),
            ],
          ),
        ),
      ),
    );
  }

  Widget _searchBar() {
    return Builder(builder: (context) {
      return TextField(
        onChanged: (text) {
          return context.read<GetListDoctorCubit>().getList(text);
        },
        decoration: const InputDecoration(
            fillColor: Color(0xff6B779A),
            hintText: 'Tìm kiếm bác sĩ',
            prefixIcon: Icon(Icons.search),
            border: OutlineInputBorder(
              borderSide: BorderSide(width: 0, color: AppColors.primary),
            )),
      );
    });
  }

  Widget _doctors(BuildContext context) {
    return Expanded(
      child: BlocBuilder<GetListDoctorCubit, GetListDoctorState>(
        builder: (context, state) {
          if (state is GetListDoctorSuccess) {
            return GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: 20,
              mainAxisSpacing: 16,
              children: [
                ...state.doctors.map((doctor) {
                  return _doctorCard(doctor, context);
                })
              ],
            );
          }
          if (state is GetListDoctorFailure) {
            return const Center(
              child: Text('Something went wrong'),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }

  Widget _doctorCard(DoctorEntity doctor, BuildContext context) {
    return GestureDetector(
      onTap: () =>
          AppNavigator.push(context, DetailsDoctorPage(doctor: doctor)),
      child: Container(
        height: 170,
        width: 150,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
                spreadRadius: 0,
                blurRadius: 15,
                color: const Color(0xff979797).withOpacity(0.1)),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(height: 15),
            Container(
              height: 70,
              width: 70,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(image: AssetImage(AppVector.avatar)),
              ),
            ),
            Text(doctor.name),
            Text(doctor.specialized),
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.star,
                    color: Colors.yellowAccent,
                  ),
                  Text(
                      '${doctor.averageStar.toStringAsFixed(2)} (${doctor.numberReview})')
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
