

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:health_online/common/bloc/button/button_state.dart';
import 'package:health_online/common/bloc/button/button_state_cubit.dart';
import 'package:health_online/common/helper/app_navigator.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/data/booking/models/appointment_create_req.dart';
import 'package:health_online/data/booking/models/get_time_slot.dart';
import 'package:health_online/domain/booking/entity/doctor.dart';
import 'package:health_online/domain/booking/usecase/add_appointment_usecase.dart';
import 'package:health_online/presentation/booking/bloc/choose_date_cubit.dart';
import 'package:health_online/presentation/booking/bloc/choose_date_state.dart';
import 'package:health_online/presentation/booking/widgets/day_card.dart';
import 'package:health_online/presentation/home/page/home_page.dart';

class ChooseTimePage extends StatefulWidget {
  final DoctorEntity doctorEntity;

  const ChooseTimePage({super.key, required this.doctorEntity});

  @override
  State<ChooseTimePage> createState() => _ChooseTimePageState();
}

class _ChooseTimePageState extends State<ChooseTimePage> {
  var itemChoose = 0;
  int hourChoose = -1;
  DateTime today = DateTime.now();
  TextEditingController _fullNameController = TextEditingController();
  TextEditingController _ageController = TextEditingController();
  TextEditingController _descriptionController = TextEditingController();
  final List months = [
    'Jan',
    'Feb',
    'Mar',
    'April',
    'May',
    'Jun',
    'July',
    'Aug',
    'Sep',
    'Oct',
    'Nov',
    'Dec'
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        title: const Text(
          'Thông tin đặt khám',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: MultiBlocProvider(
        providers: [
          BlocProvider(create: (BuildContext context) {
            var cubit = ChooseDateCubit();
            cubit.onGetSlot(
                GetTimeSlot(idDoctor: widget.doctorEntity.id, xDayLater: 1));
            return cubit;
          }),
          BlocProvider(create: (BuildContext context) => ButtonStateCubit())
        ],
        child: BlocListener<ButtonStateCubit,ButtonState>(
          listener: (BuildContext context, state) {
            ScaffoldMessenger.of(context).hideCurrentSnackBar();
            if(state is ButtonSuccessState)
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Booking Success')));
                AppNavigator.pushReplacement(context, const HomePage());
              }
            if(state is ButtonFailureState)
              {
                ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.errorMessage)));
              }
            if(state is ButtonLoadingState)
              {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content:Center(child:CircularProgressIndicator())));
              }
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 30,
                ),
                _monthAndYear(),
                const SizedBox(
                  height: 5,
                ),
                _listDay(context),
                const SizedBox(
                  height: 30,
                ),
                _availableTimeText(),
                const SizedBox(
                  height: 5,
                ),
                _listHour(context),
                const SizedBox(
                  height: 20,
                ),
                _fullName(),
                const SizedBox(
                  height: 10,
                ),
                _age(),
                const SizedBox(
                  height: 10,
                ),
                _description(),
                const SizedBox(
                  height: 30,
                ),
                _buttonBooking(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _monthAndYear() {
    DateTime day = today.add(Duration(days: itemChoose+1));
    return Text(
      months[day.month - 1] + ', ' + day.year.toString(),
      style: const TextStyle(
          color: AppColors.primary, fontSize: 18, fontWeight: FontWeight.w700),
    );
  }

  Widget _listDay(BuildContext context) {
    return Container(
      height: 80,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () => setState(() {
                itemChoose = index;
                hourChoose = -1;
                context.read<ChooseDateCubit>().onGetSlot(GetTimeSlot(
                    idDoctor: widget.doctorEntity.id, xDayLater: index + 1));
              }),
              child: DayCard(
                isChoose: itemChoose == index,
                date: today.add(Duration(days: index + 1)),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return const SizedBox(width: 7.5);
          },
          itemCount: 30),
    );
  }

  Widget _availableTimeText() {
    return const Text(
      'Available Time',
      style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18),
    );
  }

  Widget _listHour(BuildContext context) {
    return BlocBuilder<ChooseDateCubit, ChooseDateState>(
      builder: (BuildContext context, state) {
        if (state is ChooseDateLoadSuccess) {
          return Container(
            height: 200,
            child: GridView.count(
              padding: const EdgeInsets.symmetric(vertical: 10),
              crossAxisCount: 4,
              crossAxisSpacing: 10,
              mainAxisSpacing: 10,
              childAspectRatio: 1.5,
              children: [
                _timeCard(0, '09:00 AM', !state.choseSlot.contains(0)),
                _timeCard(1, '09:30 AM', !state.choseSlot.contains(1)),
                _timeCard(2, '10:00 AM', !state.choseSlot.contains(2)),
                _timeCard(3, '10:30 AM', !state.choseSlot.contains(3)),
                _timeCard(4, '12:00 PM', !state.choseSlot.contains(4)),
                _timeCard(5, '12:30 PM', !state.choseSlot.contains(5)),
                _timeCard(6, '01:30 PM', !state.choseSlot.contains(6)),
                _timeCard(7, '02:00 PM', !state.choseSlot.contains(7)),
                _timeCard(8, '03:00 PM', !state.choseSlot.contains(8)),
                _timeCard(9, '04:30 PM', !state.choseSlot.contains(9)),
                _timeCard(10, '05:00 PM', !state.choseSlot.contains(10)),
                _timeCard(11, '05:30 PM', !state.choseSlot.contains(11)),
              ],
            ),
          );
        }
        if (state is ChooseDateLoadFailure) {
          return Center(child: Text(state.errorMessage));
        }
        if (state is ChooseDateLoading) {
          return const Center(
            child: CircularProgressIndicator(),
          );
        }
        return const Placeholder();
      },
    );
  }

  Widget _timeCard(int index, String time, bool isAvailable) {
    return Builder(builder: (context) {
      return GestureDetector(
        onTap: () => setState(() {
          if (isAvailable) {
            hourChoose = index;
          }
        }),
        child: Container(
          alignment: Alignment.center,
          decoration: BoxDecoration(
              color: isAvailable
                  ? (hourChoose == index ? AppColors.colorChoose : Colors.white)
                  : Colors.grey,
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(10)),
          child: Text(
            time,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      );
    });
  }

  Widget _fullName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          child: const Text('Full Name'),
        ),
        Expanded(
            child: TextField(
          controller: _fullNameController,
          decoration: const InputDecoration(
              border: UnderlineInputBorder(), hintText: 'Enter Patient Name'),
        ))
      ],
    );
  }

  Widget _age() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          child: const Text('Age'),
        ),
        Expanded(
          child: TextField(
            keyboardType: TextInputType.number,
            controller: _ageController,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(), hintText: 'Enter Patient Age'),
          ),
        )
      ],
    );
  }

  Widget _description() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          child: const Text('Description'),
        ),
        Expanded(
          child: TextField(
            controller: _descriptionController,
            decoration: const InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Symptom\'s Description'),
          ),
        )
      ],
    );
  }

  Widget _buttonBooking(BuildContext context) {
    return Builder(builder: (context) {
      return ElevatedButton(
        onPressed: () {
          if (_fullNameController.text.isEmpty ||
              _ageController.text.isEmpty ||
              _descriptionController.text.isEmpty ||
              hourChoose == -1) {
            ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Pls enter all field')));
          } else {
            context.read<ButtonStateCubit>().execute(
                usecase: AddAppointmentUseCase(),
                params: AppointmentCreateReq(
                    doctorId: widget.doctorEntity.id,
                    dayBooking: today.add(Duration(days: itemChoose + 1)),
                    hourBooking: hourChoose,
                    victimName: _fullNameController.text,
                    description: _descriptionController.text,
                    age: int.parse(_ageController.text)));
          }
        },
        style: ElevatedButton.styleFrom(backgroundColor: AppColors.primary),
        child: const Text(
          "Đặt lịch khám",
          style: TextStyle(color: Colors.white),
        ),
      );
    });
  }
}
