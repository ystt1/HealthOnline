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
            }),
        TextField(
          controller: _textEditingController,
          decoration: const InputDecoration(
              hintText: "Input a comment", border: UnderlineInputBorder()),
        )
      ],
    );
  }

  return MultiBlocProvider(
    providers: [
      BlocProvider(create: (BuildContext context) {
        var cubit = GetReviewOfUserCubit();
        cubit.onLoading(historyEntity.doctorId);
        return cubit;
      }),
      BlocProvider(create: (BuildContext context) => ButtonStateCubit())
    ],
    child: Builder(builder: (context) {
      return BlocListener<ButtonStateCubit, ButtonState>(
        listener: (BuildContext context, ButtonState state) {
          if (state is ButtonFailureState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text(state.errorMessage)));
          }
          if (state is ButtonSuccessState) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            ScaffoldMessenger.of(context)
                .showSnackBar(SnackBar(content: Text("success")));
            Navigator.pop(context);
          }
          if (state is ButtonLoadingState) {
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                content: Center(
              child: CircularProgressIndicator(),
            )));
          }
        },
        child: AlertDialog(
          title: const Text("Rating doctor"),
          content: BlocBuilder<GetReviewOfUserCubit, GetReviewOfUserState>(
            builder: (BuildContext context, GetReviewOfUserState state) {
              if (state is GetReviewOfUserStateLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
              if (state is GetReviewOfUserStateFailure) {
                return Center(child: Text(state.errorMsg));
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
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  context.read<ButtonStateCubit>().execute(
                      usecase: AddReviewUseCase(),
                      params: AddReviewPost(
                          idDoctor: historyEntity.doctorId,
                          idPatient: UserStorage.getId()!,
                          comment: _textEditingController.text,
                          star: _ratingStar.toInt()));
                },
                child: Text(_isNew ? "Add Review" : "Change Review")),
          ],
        ),
      );
    }),
  );
}
