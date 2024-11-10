import 'package:flutter/material.dart';
import 'package:health_online/core/app_colors.dart';
import 'package:health_online/presentation/booking/widgets/day_card.dart';

class ChooseTimePage extends StatefulWidget {
  const ChooseTimePage({super.key});

  @override
  State<ChooseTimePage> createState() => _ChooseTimePageState();
}

class _ChooseTimePageState extends State<ChooseTimePage> {
  var itemChoose = 0;
  var hourChoose = 0;
  DateTime today = DateTime.now();
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
        leading: const Icon(Icons.arrow_back),
        title: const Text(
          'Thông tin đặt khám',
          style: TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.symmetric(horizontal: 22),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _monthAndYear(),
            _listDay(context),
            _availableTimeText(),
            _listHour(context),
            _fullName(),
            _age(),
            _description(),
            _buttonBooking()
          ],
        ),
      ),
    );
  }

  Widget _monthAndYear() {
    DateTime day = today.add(Duration(days: itemChoose));
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
              onTap: () =>
                  setState(() {
                    itemChoose = index;
                  }),
              child: DayCard(
                isChoose: itemChoose == index,
                date: today.add(Duration(days: index)),
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
    return Container(
      height: 200, // Set chiều cao cố định
      child: GridView.builder(
        padding: const EdgeInsets.symmetric(vertical: 10),
        itemBuilder: (BuildContext context, int index) {
          return _timeCard(index);
        },
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 4,
          mainAxisSpacing: 10,
          crossAxisSpacing: 10,
          childAspectRatio: 1.5, // Điều chỉnh tỷ lệ width/height của mỗi item
        ),
        itemCount: 12,
      ),
    );
  }

  Widget _timeCard(int index) {
    return GestureDetector(
      onTap: () =>
          setState(() {
            hourChoose = index;
          }),
      child: Container(
        alignment: Alignment.center, // Căn giữa text
        decoration: BoxDecoration(
            color: hourChoose == index ? AppColors.colorChoose : Colors.white,
            border: Border.all(color: Colors.grey),
            borderRadius: BorderRadius.circular(10)),
        child: const Text(
          '09:00 AM',
          style: TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _fullName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          child: Text('Full Name'),
        ),
        Text('Phan Quốc Tuấn')
      ],
    );
  }

  Widget _age() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          child: Text('Age'),
        ),
        Text('18')
      ],
    );
  }

  Widget _description() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Container(
          width: 150,
          child: Text('Description'),
        ),
        Expanded(
          child: TextField(
            decoration: InputDecoration(
            border: InputBorder.none
            ),
          ),
        )
      ],
    );
  }

  Widget _buttonBooking() {
    return ElevatedButton(
      onPressed: () {}, child: Text("Đặt lịch khám",style: TextStyle(color: Colors.white),), style:ElevatedButton.styleFrom(
      backgroundColor: AppColors.primary
    ),);
  }
}
