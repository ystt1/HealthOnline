import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/domain/history/entity/history_entity.dart';
import 'package:health_online/domain/history/entity/medicine_entity.dart';
import 'package:health_online/presentation/history/bloc/get_prescription_cubit.dart';
import 'package:health_online/presentation/history/bloc/get_prescription_state.dart';
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
        centerTitle: true,
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(
            create: (BuildContext context) {
              var cubit = GetPrescriptionCubit();
              cubit.onLoading(historyEntity.id);
              return cubit;
            },
          ),
        ],
        child: BlocBuilder<GetPrescriptionCubit, GetPrescriptionState>(
          builder: (context, state) {
            if (state is GetPrescriptionStateLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (state is GetPrescriptionStateFailure) {
              return Center(
                child: Text(
                  state.errorMsg,
                  style: const TextStyle(color: Colors.red, fontSize: 16),
                ),
              );
            }
            if (state is GetPrescriptionStateSuccess) {
              return Stack(
                children: [
                  SingleChildScrollView(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _date(context),
                        const SizedBox(height: 10),
                        _doctor(context),
                        const SizedBox(height: 10),
                        _diagnosis(context, state.prescriptionEntity.diagnosis),
                        const SizedBox(height: 10),
                        _note(context, state.prescriptionEntity.note),
                        const SizedBox(height: 10),
                        _patientInfor(context),
                        const Divider(thickness: 1, height: 20),
                        _medicalAndNumber(context),
                        const SizedBox(height: 10),
                        _listMedical(context, state.prescriptionEntity.medicines),
                      ],
                    ),
                  ),
                  Positioned(
                    bottom: 20,
                    left: 16,
                    right: 16,
                    child: _buttonReviewDoctor(context),
                  ),
                ],
              );
            }
            return const Center(
              child: Text("Page not found"),
            );
          },
        ),
      ),
    );
  }

  Widget _date(BuildContext context) {
    return Text(
      'Ngày khám: ${historyEntity.date}',
      style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    );
  }

  Widget _doctor(BuildContext context) {
    return Text(
      'Bác sĩ: ${historyEntity.doctorName}',
      style: const TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
    );
  }

  Widget _diagnosis(BuildContext context, String diagnosis) {
    return Text(
      'Chẩn đoán: $diagnosis',
      style: const TextStyle(fontSize: 16),
    );
  }

  Widget _note(BuildContext context, String note) {
    return Text(
      'Ghi chú: $note',
      style: const TextStyle(fontSize: 14, color: CupertinoColors.systemGrey2),
    );
  }

  Widget _patientInfor(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          'Bệnh nhân: ${historyEntity.name}',
          style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
        ),
        Text(
          'Tuổi: ${historyEntity.age}',
          style: const TextStyle(fontSize: 16),
        ),
      ],
    );
  }

  Widget _medicalAndNumber(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: const [
        Text('Thuốc', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
        Text('Số lượng', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
      ],
    );
  }

  Widget _listMedical(BuildContext context, List<MedicineEntity> medicines) {
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: medicines.length,
      itemBuilder: (context, index) {
        return _medicalCard(index + 1, medicines[index]);
      },
    );
  }

  Widget _medicalCard(int index, MedicineEntity medicine) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 8),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8),
        boxShadow: [
          BoxShadow(
            color: Colors.black12,
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Text(
              '$index. ${medicine.name}',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            '${medicine.quantity} ${medicine.unit}',
            style: const TextStyle(fontSize: 14, color: CupertinoColors.systemGrey),
          ),
        ],
      ),
    );
  }

  Widget _buttonReviewDoctor(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        showDialog(
          context: context,
          builder: (context) => RatingDialog(context, historyEntity),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        padding: const EdgeInsets.symmetric(vertical: 14),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: const Text(
        "Đánh giá bác sĩ",
        style: TextStyle(fontSize: 16, color: Colors.white),
      ),
    );
  }
}
