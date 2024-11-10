import 'package:flutter/material.dart';
import 'package:health_online/core/app_colors.dart';

import '../../../core/configs/app_vector.dart';

class DetailsDoctorPage extends StatelessWidget {
  const DetailsDoctorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const Icon(Icons.arrow_back),
        title: const Text('Thông tin chi tiết'),
      ),
      body: Column(
        children: [
          _overViewCard(),
          _inforDoctor(),
          _chooseTimeBtn()
        ],
      ),
    );
  }

  Widget _overViewCard() {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            spreadRadius: 0,
            blurRadius: 10,
            color: Colors.grey.withOpacity(0.2)
          )
        ]
      ),
      height: 226,
      child: Column(
        children: [
          Container(
            height: 70,
            width: 70,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(image: AssetImage(AppVector.avatar)),
            ),
          ),
          const Text('PGS.TS. Phan Quốc Tuấn'),
          const Text('Chuyên khoa công nghệ phần mềm'),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Lượt hen khám'),
                  Text('55'),
                ],
              ),
              VerticalDivider(
                color: Colors.black,
                thickness: 1,
         
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text('Lượt tư vấn'),
                  Text('55'),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }


  Widget _inforDoctor()
  {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              spreadRadius: 0,
              blurRadius: 10,
              color: Colors.grey.withOpacity(0.1)
            )
          ]
        ),
        child: Column(
          children: [
            Align(
              alignment: Alignment.topCenter,
              child: Text('Thông tin bác sĩ'),
            ),
            Text('bác sĩ Tuấn với 100 năm kinh nghiệm trong nghề =)))')
          ],
        ),
      ),
    );
  }
  
  Widget _chooseTimeBtn()
  {
    return ElevatedButton(style: ElevatedButton.styleFrom(
      minimumSize: Size(double.infinity, 60),
      backgroundColor: AppColors.primary
    ),onPressed: (){}, child: Text('Chọn thời gian',style: TextStyle(color: Colors.white),));
  }
}
