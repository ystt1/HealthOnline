import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/helper/app_navigator.dart';
import 'package:health_online/core/constant.dart';
import 'package:health_online/domain/history/entity/history_entity.dart';
import 'package:health_online/presentation/history/bloc/get_history_state.dart';
import 'package:health_online/presentation/history/bloc/get_histoy_cubit.dart';
import 'package:health_online/presentation/history/page/prescription_page.dart';

import '../../../core/app_colors.dart';

class HistoryPage extends StatelessWidget {
  const HistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text(
          'Lịch sử khám bệnh',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          var cubit = GetHistoryCubit();
          cubit.getHistory();
          return cubit;
        },
        child: Container(
          width: double.infinity,
          margin: const EdgeInsets.only(top: 32),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16),
            color: CupertinoColors.systemGrey4,
          ),
          child: _histories(context),
        ),
      ),
    );
  }

  Widget _histories(BuildContext context) {
    return Builder(builder: (context) {
      return BlocBuilder<GetHistoryCubit, GetHistoryState>(
        builder: (BuildContext context, GetHistoryState state) {
          if (state is GetHistoryStateLoading) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state is GetHistoryStateFailure) {
            return Center(child: Text(state.errorMsg));
          }
          if (state is GetHistoryStateSuccess) {
            return ListView.builder(
                itemCount: state.histories.length,
                itemBuilder: (context, index) {
                  return _historyCard(context, state.histories[index]);
                });
          }
          return const Center(child: Text('Something went wrong'));
        },
      );
    });
  }

  Widget _historyCard(BuildContext context, HistoryEntity history) {
    return GestureDetector(
      onTap: () {
        if (history.status == 1) AppNavigator.push(context,  PrescriptionPage(historyEntity: history,));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 18),
        margin: const EdgeInsets.symmetric(vertical: 10),
        height: 148,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            color: Colors.white,
            boxShadow: [
              const BoxShadow(color: Colors.grey, blurRadius: 8, offset: Offset(0, 4))
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('${AppConstant.time[history.slot]} ${history.date}'),
            Text(
                'Trạng thái: ${history.status == 0 ? 'Đang đợi' : 'Đã hoàn thành'}'),
            Text('Bác sĩ: ${history.doctorName}'),
            Text('Chuyên ngành: ${history.specialization}')
          ],
        ),
      ),
    );
  }
}
