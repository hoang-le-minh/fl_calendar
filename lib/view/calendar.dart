import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:my_app/view/list_diary.dart';
import 'package:table_calendar/table_calendar.dart';

import '../model/diary_model.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  DateTime _focusedDay = DateTime.now();
  bool _showMood = false;

  void _onDaySelected(DateTime day, DateTime focusedDay) {
    setState(() {
      _focusedDay = day;
    });
  }

  void _onShowMood(bool isShow){
    setState(() {
      _showMood = isShow;
    });
  }

  List<int> listDay = [1, 9, 28, 31];

  bool isHaveDiary(DateTime day){
    return listDay.contains(day.day);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF3F2EE),
      // appBar: AppBar(
      //   title: Text('Table Calendar'),
      //   backgroundColor: Color(0xFFF3F2EE),
      // ),
      body: Stack(
        children: [
          // Hình nền
          Positioned.fill(
            child: Image.asset(
              'assets/background.png',
              fit: BoxFit.none,
            ),
          ),
          // Nội dung
          calendar(),
          SingleChildScrollView(
            child: // body list diary in day
                !isHaveDiary(_focusedDay)
                    ? Container(
                        child: Column(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            SizedBox(height: 34),
                            Stack(
                              alignment: Alignment.center,
                              children: [
                                Image.asset('assets/no_entries_group.png'),
                                Positioned(
                                    bottom: 40,
                                    child: Text(
                                      'No entries on this day',
                                      style: TextStyle(fontSize: 14),
                                    ))
                              ],
                            )
                          ],
                        ),
                      )
                    : Column(children: [
                        SizedBox(
                          height: 16,
                        ),
                        SingleChildScrollView(
                          child: _listDiary(_focusedDay),
                        ),
                      ]),
          )
        ],
      ),
    );
  }

  Widget calendar() {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Column(
          children: [
            Container(
              child: TableCalendar(
                firstDay: DateTime.utc(2001, 11, 16),
                lastDay: DateTime.utc(2030, 11, 16),
                selectedDayPredicate: (day) => isSameDay(day, _focusedDay),
                focusedDay: _focusedDay,
                rowHeight: 50,
                calendarFormat: CalendarFormat.month,
                headerStyle: HeaderStyle(
                  formatButtonVisible: false,
                  titleCentered: true,
                  leftChevronVisible: false,
                  rightChevronVisible: false
                ),
                availableGestures: AvailableGestures.all,
                onDaySelected: (selectedDay, focusedDay) =>
                    _onDaySelected(selectedDay, focusedDay),
                onPageChanged: (focusedDay) => _focusedDay = focusedDay,
                daysOfWeekStyle: DaysOfWeekStyle(
                    weekdayStyle: TextStyle(
                        color: Color(0xFFBD98EA),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    weekendStyle: TextStyle(
                        color: Color(0xFFBD98EA),
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    dowTextFormatter: (date, locale) {
                      switch (date.weekday) {
                        case DateTime.monday:
                          return 'M'; // Thứ Hai
                        case DateTime.tuesday:
                          return 'T'; // Thứ Ba
                        case DateTime.wednesday:
                          return 'W'; // Thứ Tư
                        case DateTime.thursday:
                          return 'Th'; // Thứ Năm
                        case DateTime.friday:
                          return 'F'; // Thứ Sáu
                        case DateTime.saturday:
                          return 'Sa'; // Thứ Bảy
                        case DateTime.sunday:
                          return 'S'; // Chủ Nhật
                        default:
                          return '';
                      }
                    }),
                calendarBuilders: CalendarBuilders(
                  todayBuilder: (context, day, focusedDay) {
                    if(isHaveDiary(day)){
                      if(_showMood){
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text('😂', style: TextStyle(fontSize: 24, height: 1.0),),
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                        );
                      }
                      return notebook(false, day);
                    } else {
                      return Container(
                        alignment: Alignment.center,
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                              fontWeight: FontWeight.bold),
                        ),
                      );
                    }
                  },
                  defaultBuilder: (context, day, focusedDay) {
                    if (day.isAfter(DateTime.now())) {
                      if(isHaveDiary(day)){
                        if(_showMood){
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.white,
                              shape: BoxShape.circle,
                            ),
                            child: Text('😂', style: TextStyle(fontSize: 24, height: 1.0),),
                            width: 32,
                            height: 32,
                            alignment: Alignment.center,
                          );
                        }
                        return notebook(false, day);
                      }
                      return Container(
                        alignment: Alignment.center,
                        width: 32,
                        height: 32,
                        decoration: BoxDecoration(
                          color: Colors.grey[100],
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '${day.day}',
                          style: TextStyle(
                              color: Colors.grey,
                              fontWeight: FontWeight.bold,
                              fontSize: 14),
                        ),
                      );
                    }
                    if(isHaveDiary(day)){
                      if(_showMood){
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text('😊', style: TextStyle(fontSize: 24, height: 1.0),),
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                        );
                      }
                      return notebook(false, day);
                    }
                    return Container(
                      alignment: Alignment.center,
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                    );
                  },
                  selectedBuilder: (context, day, focusedDay) {
                    if(isHaveDiary(day)) {
                      if(_showMood){
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text('😂', style: TextStyle(fontSize: 24, height: 1.0),),
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                        );
                      }
                      return notebook(true, day);
                    }
                    if(day.isAfter(DateTime.now())) {
                      if(_showMood) {
                        return Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFBD98EA), Color(0xFFFF97AB)],
                                // Màu gradient cho viền
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1),
                            child: defaultAfterDaySelected(focusedDay),
                          ),
                        );
                      }
                      return defaultAfterDaySelected(focusedDay);
                    } else {
                      if(_showMood){
                        return Container(
                          decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [Color(0xFFBD98EA), Color(0xFFFF97AB)],
                                // Màu gradient cho viền
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                              ),
                              shape: BoxShape.circle
                          ),
                          child: Padding(
                            padding: EdgeInsets.all(1),
                            child: defaultDaySelected(focusedDay),
                          ),
                        );
                      }
                    }
                    return defaultDaySelected(focusedDay);
                  },
                  outsideBuilder: (context, day, focusedDay) {
                    if(isHaveDiary(day)){
                      if(_showMood){
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: Text('😂', style: TextStyle(fontSize: 24, height: 1.0),),
                          width: 32,
                          height: 32,
                          alignment: Alignment.center,
                        );
                      }
                      return notebook(false, day);
                    }
                    return Container(
                      alignment: Alignment.center,
                      width: 32,
                      height: 32,
                      decoration: BoxDecoration(
                        color: Colors.grey[100],
                        shape: BoxShape.circle,
                      ),
                      child: Text(
                        '${day.day}',
                        style: TextStyle(
                            color: Colors.grey,
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                      ),
                    );
                  },
                  headerTitleBuilder: (context, day) {
                    return Stack(children: [
                      IconButton(onPressed: (){
                        Navigator.pop(context);
                      }, icon: Icon(Icons.arrow_back_ios), iconSize: 24, color: Colors.black,),
                      Center(
                        child: TextButton(
                          onPressed: () async {
                            _onShowMood(true);
                            await showModalBottomSheet(context: context, builder: (context) {
                              return buildMonthYearPicker();
                            }).whenComplete((){
                              print('======================bottom sheet close======================');
                              _onShowMood(false);
                            });// _showMonthYearPicker;
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              Text(
                                  '${DateFormat('MMM').format(_focusedDay)}',
                                  style: TextStyle(fontSize: 16, color: Colors.black),),
                              // SizedBox(width: 4,),
                              Icon(Icons.arrow_drop_down)
                            ],
                          ),
                        ),
                      ),
                      Align(
                        alignment: Alignment.centerRight,
                        child: TextButton(
                            onPressed: (){
                              setState(() {
                                _focusedDay = DateTime.now();
                              });
                            }, child: Text('Today', style: TextStyle(fontSize: 14, color: Color(0xFFAAAABB)),))
                      )
                    ]);
                  },
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }


  Container defaultDaySelected(DateTime focusedDay) {
    return Container(
                    alignment: Alignment.center,
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                        color: Colors.white,
                        shape: BoxShape.circle,
                        border:
                            Border.all(color: Color(0xFFBD98EA), width: 1)),
                    child: Text(
                      '${focusedDay.day}',
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 14),
                    ),
                  );
  }

  Container defaultAfterDaySelected(DateTime focusedDay) {
    return Container(
                          alignment: Alignment.center,
                          width: 32,
                          height: 32,
                          decoration: BoxDecoration(
                              color: Colors.grey[100],
                              shape: BoxShape.circle,
                              border:
                              Border.all(color: Color(0xFFBD98EA), width: 1),
                          ),
                          child: Text(
                            '${focusedDay.day}',
                            style: TextStyle(
                                color: Colors.grey,
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                          ),
                        );
  }

  Widget notebook(bool isFocused, DateTime day){
    if(isFocused){
      return Stack(
        alignment: Alignment.center,
        children: [
          Image.asset(
            'assets/union.png',
            width: 32,
            height: 32,
          ),
          Image.asset(
            'assets/notebook.png',
            width: 29,
            height: 29,
          ),
          Text(
            '${day.day}',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 14),
          )
        ],
      );
    }
    return Stack(
      alignment: Alignment.center,
      children: [
        Image.asset(
          'assets/notebook.png',
          width: 32,
          height: 32,
        ),
        Text(
          '${day.day}',
          style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontSize: 14),
        )
      ],
    );
  }

  Widget buildMonthYearPicker(){
    int selectedMonth = _focusedDay.month;
    int selectedYear = _focusedDay.year;

    return StatefulBuilder(
      builder: (context, setModalState) {

         return Container(
          padding: EdgeInsets.all(16),
          height: 320,
          child: Column(
            children: [
              Text(
                'Select Date',
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Color(0xFFBD98EA)),
              ),
              SizedBox(height: 20),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(width: 30),
                    // Cuộn dọc chọn tháng
                    Expanded(
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 56,
                        perspective: 0.005,
                        onSelectedItemChanged: (index) {
                          setModalState(() {
                            selectedMonth = index + 1;
                          });
                        },
                        physics: FixedExtentScrollPhysics(),
                        controller: FixedExtentScrollController(initialItem: _focusedDay.month - 1),
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            final monthName = DateFormat('MMM')
                                .format(DateTime(0, index + 1));
                            bool isSelectedMonth = selectedMonth == index+1;
                            return Center(
                              child: Text(
                                monthName,
                                style: TextStyle(fontSize: isSelectedMonth? 32 : 24, color: isSelectedMonth? Color(0xFFBD98EA): Color(0xFFD9D9D9), fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          childCount: 12,
                        ),
                      ),
                    ),
                    // Cuộn dọc chọn năm
                    Expanded(
                      child: ListWheelScrollView.useDelegate(
                        itemExtent: 56,
                        perspective: 0.005,
                        onSelectedItemChanged: (index) {
                          setModalState(() {
                            selectedYear = DateTime.now().year - 10 + index;
                          });
                        },
                        physics: FixedExtentScrollPhysics(),
                        controller: FixedExtentScrollController(initialItem: selectedYear - (DateTime.now().year - 10)),
                        childDelegate: ListWheelChildBuilderDelegate(
                          builder: (context, index) {
                            int year = DateTime.now().year - 10 + index;
                            bool isSelectedYear = selectedYear == DateTime.now().year - 10 + index;
                            return Center(
                              child: Text(
                                year.toString(),
                                style: TextStyle(fontSize: isSelectedYear? 32 : 24, color: isSelectedYear? Color(0xFFBD98EA): Color(0xFFD9D9D9), fontWeight: FontWeight.bold),
                              ),
                            );
                          },
                          childCount: 20,
                        ),
                      ),
                    ),
                    SizedBox(width: 30,)
                  ],
                ),
              ),
              SizedBox(height: 32),
              Container(
                width: double.infinity,
                height: 49,
                margin: EdgeInsets.only(left: 20, right: 20),
                decoration: BoxDecoration(
                  color: Color(0xFFBD98EA),
                  borderRadius: BorderRadius.all(Radius.circular(50))
                ),
                child: TextButton(
                  onPressed: () {
                    setState(() {
                      _focusedDay = DateTime(selectedYear, selectedMonth);
                    });
                    Navigator.pop(context);
                  },
                  child: Text('DONE', style: TextStyle(color: Colors.white, fontSize: 14, fontWeight: FontWeight.bold),),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // get list diary in _focusedDay
  final List<DiaryModel> diaryEntries = [
    DiaryModel(
      id: 1,
      title: 'Something like a title but i do...',
      content:
      'Today I went to Bangalore railway station, Yeshwantpura, to receive my uncle and aunt who were coming from Mumbai. It was a bright...',
      createdDate: DateTime.now(),
      status: '',
      imageResources: [''],
      time: DateTime.now(),
    ),
    DiaryModel(
        id: 2,
        title: 'Title Blah',
        content: 'Today I went to Bangalore railway station',
        createdDate: DateTime.now(),
        status: '😎',
        imageResources: [''],
        time: DateTime.now()
    ),
    DiaryModel(
        id: 3,
        title: 'Title',
        content:
        'My wish is to become a tennis player in the future. I am very much inspired by Sania Mirza and I believe that she is the best tennis player in the whole...',
        createdDate: DateTime.now(),
        status: '😎',
        imageResources: ['assets/img_diary_test.png'],
        time: DateTime.now().subtract(Duration(days: 2))
    ),
  ];

  Widget _listDiary(DateTime focusedDay) {
    return Padding(
        padding: EdgeInsets.only(top: 5, right: 20, left: 20, bottom: 5),
        child: Container(
          padding: const EdgeInsets.only(
              left: 5, right: 10, bottom: 0, top: 5),
          decoration: BoxDecoration(
            boxShadow: const [
              BoxShadow(
                color: Colors.black26, // Màu bóng
                blurRadius: 0.1, // Độ mờ của bóng
                spreadRadius: 0.1, // Độ lan rộng của bóng
                offset: Offset(0, 0), // Vị trí bóng (dx, dy)
              ),
            ],
            borderRadius: BorderRadius.circular(15),
            color: Colors.white,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (var i = 0; i < diaryEntries.length; i++) ...[
                Stack(children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 10),
                    child: Row(children: [
                      Baseline(
                        baseline: 1.0,
                        baselineType: TextBaseline.alphabetic,
                        child: Text(
                          diaryEntries[i].time.day.toString(),
                          style: const TextStyle(
                            fontSize: 12,
                            color: Color(0xFF343434),
                            fontWeight: FontWeight.w700
                          ),
                        ),
                      ),
                      RichText(
                        text: TextSpan(
                          children: [
                            WidgetSpan(
                              child: Transform.rotate(
                                angle: 30 * 3.141592653589793 / 180,
                                // Convert degrees to radians
                                child: const Text(
                                  '/',
                                  style: TextStyle(
                                      fontSize: 12,
                                      color: Color(0xFF343434),
                                      fontWeight: FontWeight.w700),
                                ),
                              ),
                            ),
                            TextSpan(
                              text: DateFormat('MMM yyyy')
                                  .format(diaryEntries[i].time),
                              style: const TextStyle(
                                  fontSize: 12,
                                  color: Color(0xFF343434),
                                  fontWeight: FontWeight.w700
                              ),
                            ),
                          ],
                        ),
                      ),
                    ]),
                  ),
                  Align(
                    alignment: Alignment.topRight,
                    child: Text(
                      diaryEntries[i].status,
                      style: TextStyle(fontSize: 28, height: 1.0),
                    ),
                  )
                ]),
                Padding(
                  padding: const EdgeInsets.only(left: 10, top: 00),
                  child: Text(
                    diaryEntries[i].title,
                    style: const TextStyle(
                      fontFamily: "Nunito Bold",
                      fontSize: 14,
                      color: Color(0xFF343434),
                      fontWeight: FontWeight.w800
                    ),
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                        left: 20, right: 20, top: 10),
                    child: RichText(
                        text: TextSpan(children: [
                          TextSpan(
                            text: diaryEntries[i].content + '\n',
                            // maxLines: null,
                            style: const TextStyle(
                              color: Color(0xFF9B9B9B),
                              fontSize: 12,
                              fontFamily: 'Nunito',
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          if (diaryEntries[i].imageResources.isNotEmpty &&
                              diaryEntries[i].imageResources[0].isNotEmpty)
                            WidgetSpan(
                              child: Padding(
                                padding: EdgeInsets.only(bottom: 15, top: 10),
                                child: Image.asset(
                                  diaryEntries[i].imageResources[0],
                                  // Đường dẫn đến hình ảnh
                                  width: 100,
                                  // Thay đổi kích thước nếu cần
                                  height: 100,
                                ),
                              ),
                            ),
                        ]))),
                if (i < diaryEntries.length - 1)
                  const Padding(
                      padding: EdgeInsets.only(top: 10, bottom: 10),
                      child: Center(
                        child: Dash(
                            direction: Axis.horizontal,
                            length: 240,
                            dashLength: 15,
                            dashGap: 5,
                            dashColor: Color(0xFFAAAABB),
                            dashBorderRadius: 4,
                            dashThickness: 1),
                      )),
              ],
            ],
          ),
        ));
  }

}
