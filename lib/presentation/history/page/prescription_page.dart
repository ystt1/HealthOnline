import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/domain/history/entity/history_entity.dart';
import 'package:health_online/domain/history/entity/medicine_entity.dart';
import 'package:health_online/domain/history/usecase/get_review_of_user_usecase.dart';
import 'package:health_online/presentation/history/bloc/get_prescription_cubit.dart';
import 'package:health_online/presentation/history/bloc/get_prescription_state.dart';
import 'package:health_online/presentation/history/bloc/get_review_of_user_cubit.dart';
import 'package:health_online/presentation/history/widgets/rating_dialog.dart';

import '../../../core/app_colors.dart';

class PrescriptionPage extends StatelessWidget {
  final HistoryEntity historyEntity;

  const PrescriptionPage({super.key, required this.historyEntity});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text(
          'Đơn thuốc',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            var cubit = GetPrescriptionCubit();
            cubit.onLoading(historyEntity.id);
            return cubit;
          }),

        ],
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 32),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CupertinoColors.systemGrey4,
          ),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
            margin: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
                color: Colors.white,
                boxShadow: const [
                  BoxShadow(
                      color: Colors.grey, blurRadius: 8, offset: Offset(0, 4))
                ]),
            child: BlocBuilder<GetPrescriptionCubit, GetPrescriptionState>(
              builder: (BuildContext context, GetPrescriptionState state) {
                if (state is GetPrescriptionStateSuccess) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _date(context),
                      const SizedBox(
                        height: 10,
                      ),
                      _doctor(context),
                      const SizedBox(
                        height: 10,
                      ),
                      _diagnosis(context, state.prescriptionEntity.diagnosis),
                      const SizedBox(
                        height: 10,
                      ),
                      _note(context, state.prescriptionEntity.note),
                      const SizedBox(
                        height: 10,
                      ),
                      _patientInfor(context),
                      const SizedBox(
                        height: 10,
                      ),
                      const Divider(
                        color: Colors.black,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      _medicalAndNumber(context),
                      const SizedBox(
                        height: 10,
                      ),
                      _listMedical(context, state.prescriptionEntity.medicines),
                      const SizedBox(
                        height: 10,
                      ),
                      _buttonReviewDoctor(context),
                    ],
                  );
                }
                if (state is GetPrescriptionStateFailure) {
                  return Center(
                    child: Text(state.errorMsg),
                  );
                }
                if (state is GetPrescriptionStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return const Center(
                  child: Text("Page not found"),
                );
              },
            ),
          ),
        ),
      ),
    );
  }

  Widget _date(BuildContext context) {
    return Text('Ngày khám: ${historyEntity.date}');
  }

  Widget _doctor(BuildContext context) {
    return Text('Bác sĩ: ${historyEntity.doctorName}');
  }

  Widget _diagnosis(BuildContext context, String diagnosis) {
    return Text('Chẩn đoán: +$diagnosis');
  }

  Widget _note(BuildContext context, String note) {
    return Text('Ghi chú: $note');
  }

  Widget _patientInfor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Bệnh nhân: ${historyEntity.name}'),
        Text('Tuổi: ${historyEntity.age.toString()}'),
      ],
    );
  }

  Widget _medicalAndNumber(BuildContext context) {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text('Thuốc'),
        Text('Số lượng'),
      ],
    );
  }

  Widget _listMedical(BuildContext context, List<MedicineEntity> medicines) {
    return Expanded(
      child: ListView.builder(
          itemCount: medicines.length,
          itemBuilder: (context, index) {
            return _medicalCard(index + 1, medicines[index]);
          }),
    );
  }

  Widget _medicalCard(int index, MedicineEntity medicine) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                index.toString() + '. ${medicine.name}',
                style: const TextStyle(fontSize: 18),
              ),
              Text('${medicine.quantity}  ${medicine.unit}',
                  style: const TextStyle(fontSize: 18)),
            ],
          ),
          Text(medicine.dosage, style: const TextStyle(fontSize: 14))
        ],
      ),
    );
  }

  Widget _buttonReviewDoctor(BuildContext context) {
    return Builder(builder: (context) {
      return ElevatedButton(
        onPressed: () {
          showDialog(
              context: context,
              builder: (context) {
                return RatingDialog(context,historyEntity);
              });
        },
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
        child: const Text(
          "Đánh giá bác sĩ",
          style: TextStyle(color: Colors.white),
        ),
      );
    });
  }
}
