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
        centerTitle: true,
      ),
      body: BlocProvider(
        create: (BuildContext context) {
          var cubit = GetHistoryCubit();
          cubit.getHistory();
          return cubit;
        },
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: _histories(context),
        ),
      ),
    );
  }

  Widget _histories(BuildContext context) {
    return BlocBuilder<GetHistoryCubit, GetHistoryState>(
      builder: (BuildContext context, GetHistoryState state) {
        if (state is GetHistoryStateLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is GetHistoryStateFailure) {
          return Center(
            child: Text(
              state.errorMsg,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.redAccent,
              ),
            ),
          );
        }
        if (state is GetHistoryStateSuccess) {
          if (state.histories.isEmpty) {
            return const Center(
              child: Text(
                'Không có lịch sử khám bệnh nào.',
                style: TextStyle(fontSize: 16, color: CupertinoColors.systemGrey),
              ),
            );
          }
          return ListView.builder(
            itemCount: state.histories.length,
            itemBuilder: (context, index) {
              return _historyCard(context, state.histories[index]);
            },
          );
        }
        return const Center(child: Text('Đã xảy ra lỗi!'));
      },
    );
  }

  Widget _historyCard(BuildContext context, HistoryEntity history) {
    return GestureDetector(
      onTap: () {
        if (history.status == 1) {
          AppNavigator.push(
            context,
            PrescriptionPage(historyEntity: history),
          );
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 6,
              offset: const Offset(0, 3),
            ),
          ],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(
                  history.status == 0
                      ? Icons.hourglass_empty_outlined
                      : Icons.check_circle_outline,
                  color: history.status == 0
                      ? CupertinoColors.systemYellow
                      : CupertinoColors.activeGreen,
                ),
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    '${AppConstant.time[history.slot]} ${history.date}',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              'Trạng thái: ${history.status == 0 ? 'Đang đợi' : 'Đã hoàn thành'}',
              style: TextStyle(
                fontSize: 14,
                color: history.status == 0
                    ? CupertinoColors.systemYellow
                    : CupertinoColors.activeGreen,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Bác sĩ: ${history.doctorName}',
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w500,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              'Chuyên ngành: ${history.specialization}',
              style: const TextStyle(
                fontSize: 14,
                color: CupertinoColors.systemGrey,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
