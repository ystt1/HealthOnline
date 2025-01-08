import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:health_online/common/bloc/button/button_state.dart';
import 'package:health_online/common/bloc/button/button_state_cubit.dart';
import 'package:health_online/core/user_storage.dart';
import 'package:health_online/data/history/models/add_review_post.dart';
import 'package:health_online/domain/history/entity/history_entity.dart';
import 'package:health_online/domain/history/usecase/add_review_usecase.dart';
import 'package:health_online/presentation/history/bloc/get_review_of_user_cubit.dart';
import 'package:health_online/presentation/history/bloc/get_review_of_user_state.dart';


Widget RatingDialog(BuildContext context, HistoryEntity historyEntity) {
  double _ratingStar = 1;
  TextEditingController _textEditingController = TextEditingController();
  bool _isNew = true;

  Widget _content(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        RatingBar.builder(
          itemPadding: const EdgeInsets.symmetric(horizontal: 4),
          initialRating: _ratingStar,
          minRating: 1,
          itemBuilder: (context, _) => const Icon(
            Icons.star,
            color: Colors.amber,
          ),
          onRatingUpdate: (rating) {
            _ratingStar = rating;
          },
        ),
        const SizedBox(height: 10),
        TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(
            hintText: "Nhập đánh giá của bạn",
            border: UnderlineInputBorder(),
          ),
          maxLength: 200,
        ),
      ],
    );
  }

  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (_) {
        var cubit = GetReviewOfUserCubit();
        cubit.onLoading(historyEntity.doctorId);
        return cubit;
      }),
      BlocProvider(create: (_) => ButtonStateCubit()),
    ],
    child: Builder(
      builder: (context) {
        return BlocListener<ButtonStateCubit, ButtonState>(
          listener: (context, state) {
            if (state is ButtonFailureState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text(state.errorMessage)),
              );
            }
            if (state is ButtonSuccessState) {
              ScaffoldMessenger.of(context).hideCurrentSnackBar();
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text("Đánh giá thành công!")),
              );
              Navigator.pop(context);
            }
            if (state is ButtonLoadingState) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Row(
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(width: 10),
                      Text("Đang xử lý..."),
                    ],
                  ),
                ),
              );
            }
          },
          child: AlertDialog(
            title: const Text("Đánh giá bác sĩ"),
            content: BlocBuilder<GetReviewOfUserCubit, GetReviewOfUserState>(
              builder: (context, state) {
                if (state is GetReviewOfUserStateLoading) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                if (state is GetReviewOfUserStateFailure) {
                  return Center(
                    child: Text(
                      "Lỗi tải đánh giá: ${state.errorMsg}",
                      style: const TextStyle(color: Colors.red),
                    ),
                  );
                }
                if (state is GetReviewOfUserStateSuccess) {
                  if (state.starCommentEntity.star != -1) {
                    _isNew = false;
                    _ratingStar = state.starCommentEntity.star.toDouble();
                    _textEditingController.text = state.starCommentEntity.comment;
                  }
                  return _content(context);
                }
                return const Center(
                  child: CircularProgressIndicator(),
                );
              },
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Hủy"),
              ),
              TextButton(
                onPressed: () {
                  if (_textEditingController.text.trim().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(content: Text("Vui lòng nhập bình luận")),
                    );
                    return;
                  }

                  context.read<ButtonStateCubit>().execute(
                    usecase: AddReviewUseCase(),
                    params: AddReviewPost(
                      idDoctor: historyEntity.doctorId,
                      idPatient: UserStorage.getId()!,
                      comment: _textEditingController.text.trim(),
                      star: _ratingStar.toInt(),
                    ),
                  );
                },
                child: Text(_isNew ? "Thêm đánh giá" : "Sửa đánh giá"),
              ),
            ],
          ),
        );
      },
    ),
  );
}
