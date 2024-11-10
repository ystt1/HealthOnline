import 'package:flutter/material.dart';
import 'package:health_online/common/widget/back_and_title.dart';
import 'package:health_online/core/configs/app_vector.dart';

import '../../../core/app_colors.dart';

class BookingPage extends StatelessWidget {
  const BookingPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Chọn thông tin bác sĩ'),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 20),
        child: Column(
          children: [

            _searchBar(),
            const SizedBox(height: 15,),
            _doctors(),
          ],
        ),
      ),
    );
  }

  Widget _searchBar() {
    return const TextField(
      decoration: InputDecoration(
          fillColor: Color(0xff6B779A),
          hintText: 'Tìm kiếm bác sĩ',
          prefixIcon: Icon(Icons.search),
          border: OutlineInputBorder(
            borderSide: BorderSide(width: 0, color: AppColors.primary),
          )),
    );
  }

  Widget _doctors() {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 16,
        children: [
          _doctorCard(),
          _doctorCard(),
          _doctorCard(),
          _doctorCard(),
          _doctorCard(),
          _doctorCard(),
          _doctorCard(),
        ],
      ),
    );
  }

  Widget _doctorCard() {
    return Container(
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
          const Text('Dr.Phan Quoc Tuan'),
          const Text('Khoa Nhi'),
          Container(
            child: const Row(
              children: [Icon(Icons.star), Text('4.5 (136 Reviews)')],
            ),
          )
        ],
      ),
    );
  }
}
