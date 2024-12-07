import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/helper/app_navigator.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/domain/booking/entity/doctor.dart';
import 'package:health_online/presentation/booking/bloc/get_review_cubit.dart';
import 'package:health_online/presentation/booking/bloc/get_review_state.dart';
import 'package:health_online/presentation/booking/page/choose_time_page.dart';

import '../../../core/configs/app_vector.dart';
import '../../../domain/booking/entity/review.dart';

class DetailsDoctorPage extends StatelessWidget {
  final DoctorEntity doctor;

  const DetailsDoctorPage({super.key, required this.doctor});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text('Thông tin chi tiết'),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          var cubit = GetReviewCubit();
          cubit.getReview(doctor.id);
          return cubit;
        },
        child: Column(
          children: [
            _overViewCard(),
            _inforDoctor(),
            _commentList(context),
            _chooseTimeBtn(context),
            const SizedBox(height: 20),
          ],
        ),
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
                color: Colors.grey.withOpacity(0.2))
          ]),
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
          const SizedBox(
            height: 20,
          ),
          Text(
            doctor.name,
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            "Chuyên ngành: " + doctor.specialized,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 18),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text('Lượt hen khám'),
                  Text(doctor.numberBooking.toString()),
                ],
              ),
              const VerticalDivider(
                color: Colors.black,
                thickness: 1,
              ),
              const Column(
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

  Widget _inforDoctor() {
    return Padding(
      padding: const EdgeInsets.all(26.0),
      child: Container(
        padding: const EdgeInsets.all(10.0),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                  spreadRadius: 0,
                  blurRadius: 10,
                  color: Colors.grey.withOpacity(0.1))
            ]),
        child: Column(
          children: [
            const SizedBox(
              height: 10,
            ),
            const Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Thông tin bác sĩ',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              doctor.description,
              maxLines: 9,
              overflow: TextOverflow.clip,
            )
          ],
        ),
      ),
    );
  }

  Widget _commentList(BuildContext context) {
    return Expanded(
      child: Padding(
          padding: const EdgeInsets.all(26.0),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                color: Colors.white,
                boxShadow: [
                  BoxShadow(
                      spreadRadius: 0,
                      blurRadius: 10,
                      color: Colors.grey.withOpacity(0.1))
                ]),
            child: BlocBuilder<GetReviewCubit, GetReviewState>(
              builder: (BuildContext context, state) {
                if (state is GetReviewStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (state is GetReviewStateFailure) {
                  return const Center(
                    child: Text('Some Thing went wrong'),
                  );
                }
                if (state is GetReviewStateSuccess) {
                  if (state.reviews.length == 0) {
                    return Container(
                        child: const Center(
                      child: Text("Khong co binh luan nao"),
                    ));
                  } else {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const Text(
                          "Bình luận",
                          style: TextStyle(fontSize: 18),
                        ),
                        _listReview(state.reviews),
                      ],
                    );
                  }
                }
                return const Placeholder();
              },
            ),
          )),
    );
  }

  Widget _listReview(List<ReviewEntity> reviews) {
    return Flexible(
      child: ListView.builder(
          itemCount: reviews.length,
          itemBuilder: (context, index) {
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      // Đặt chiều rộng cố định cho phần tên người dùng
                      Expanded(
                        child: Text(
                          reviews[index].userName,
                          style: const TextStyle(fontSize: 14),
                          // Có thể điều chỉnh fontSize
                          overflow:
                              TextOverflow.ellipsis, // Đảm bảo text không tràn
                        ),
                      ),
                      // Spacer hoặc khoảng cách linh hoạt
                      const SizedBox(width: 16),
                      // Phần icon và star luôn nằm cố định
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        // Giữ kích thước tối thiểu vừa đủ
                        children: [
                          const Icon(
                            Icons.star,
                            color: Colors.yellowAccent,
                            size: 12,
                          ),
                          Text(
                            reviews[index].star.toString(),
                            style: const TextStyle(fontSize: 12),
                          )
                        ],
                      ),
                      // Spacer hoặc khoảng cách linh hoạt
                      const SizedBox(width: 16),
                      // Đặt chiều rộng cố định cho phần ngày tháng
                      Text(
                        reviews[index].dateTime,
                        style:
                            const TextStyle(color: Colors.grey, fontSize: 12),
                      ),
                    ],
                  ),
                  const SizedBox(height: 5),
                  Text(reviews[index].comment,
                      style:
                          const TextStyle(color: Colors.black, fontSize: 13)),
                  const SizedBox(height: 5),
                  const Divider(
                    height: 2,
                  )
                ],
              ),
            );
          }),
    );
  }

  Widget _chooseTimeBtn(BuildContext context) {
    return ElevatedButton(
        style: ElevatedButton.styleFrom(
            minimumSize: const Size(double.infinity, 60),
            backgroundColor: AppColors.primary),
        onPressed: () {
          AppNavigator.push(context, ChooseTimePage(doctorEntity: doctor));
        },
        child: const Text(
          'Chọn thời gian',
          style: TextStyle(color: Colors.white),
        ));
  }
}
