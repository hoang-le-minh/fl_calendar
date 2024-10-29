import 'package:flutter/material.dart';
import 'package:flutter_dash/flutter_dash.dart';
import 'package:intl/intl.dart';
import 'package:my_app/model/diary_model.dart';

class DiaryList extends StatelessWidget {
  final List<DiaryModel> diaries = [
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
      time: DateTime.now().subtract(Duration(days: 1))
    ),
    DiaryModel(
      id: 3,
      title: 'Title',
      content:
      'My wish is to become a tennis player in the future. I am very much inspired by Sania Mirza and I believe that she is the best tennis player in the whole...',
      createdDate: DateTime.now(),
      status: '😎',
      imageResources: ['assets/images/img_diary_test.png'],
      time: DateTime.now().subtract(Duration(days: 2))
    ),
    DiaryModel(
      id: 4,
      title: 'Title 2',
      content:
      'Today I went to Bangalore railway station, Yeshwantpura, to receive my uncle and aunt.',
      createdDate: DateTime.now().subtract(Duration(days: 1)),
      status: '😎',
      imageResources: [''],
      time: DateTime.now().subtract(Duration(days: 1))
    )
  ];

  Map<String, List<DiaryModel>> groupDiariesByDate(List<DiaryModel> diaries) {
    Map<String, List<DiaryModel>> groupedDiaries = {};

    for (var diary in diaries) {
      // Chuyển đổi ngày thành chuỗi định dạng "dd/MMM yyyy"
      String dateKey = DateFormat('dd/MMM yyyy').format(diary.time);
      if (!groupedDiaries.containsKey(dateKey)) {
        groupedDiaries[dateKey] = [];
      }
      groupedDiaries[dateKey]!.add(diary);
    }
    return groupedDiaries;
  }

  @override
  Widget build(BuildContext context) {
    final groupedDiaries = groupDiariesByDate(diaries);
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: ListView.builder(
        itemCount: groupedDiaries.length,
        itemBuilder: (context, index) {
          String dateKey = groupedDiaries.keys.elementAt(index);
          List<DiaryModel> diariesForDate = groupedDiaries[dateKey]!;
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
                    for (var i = 0; i < diariesForDate.length; i++) ...[
                      Stack(children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 10, top: 10),
                          child: Row(children: [
                            Baseline(
                              baseline: 1.0,
                              baselineType: TextBaseline.alphabetic,
                              child: Text(
                                diaries[index].time.day.toString(),
                                style: const TextStyle(
                                  fontSize: 12,
                                  fontFamily: 'Nunito Bold',
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
                                            fontSize: 12, color: Colors.black),
                                      ),
                                    ),
                                  ),
                                  TextSpan(
                                    text: DateFormat('MMM yyyy')
                                        .format(diaries[index].time),
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.black,
                                      fontFamily: 'Nunito Bold',
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
                            diaries[index].status,
                            style: TextStyle(fontSize: 30),
                          ),
                        )
                      ]),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 00),
                        child: Text(
                          diaries[index].title,
                          style: const TextStyle(
                            fontFamily: "Nunito Bold",
                            fontSize: 14,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      Padding(
                          padding: const EdgeInsets.only(
                              left: 20, right: 20, top: 10),
                          child: RichText(
                              text: TextSpan(children: [
                                TextSpan(
                                  text: diaries[index].content + '\n',
                                  // maxLines: null,
                                  style: const TextStyle(
                                    color: Color(0xFFAAAABB),
                                    fontSize: 12,
                                    fontFamily: 'Nunito',
                                    fontWeight: FontWeight.w800,
                                  ),
                                ),
                                if (diaries[index].imageResources.isNotEmpty &&
                                    diaries[index].imageResources[0].isNotEmpty)
                                  WidgetSpan(
                                    child: Padding(
                                      padding: EdgeInsets.only(bottom: 15, top: 10),
                                      child: Image.asset(
                                        diaries[index].imageResources[0],
                                        // Đường dẫn đến hình ảnh
                                        width: 100,
                                        // Thay đổi kích thước nếu cần
                                        height: 100,
                                      ),
                                    ),
                                  ),
                              ]))),
                      if (i < diariesForDate.length - 1)
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
        },
      ),
    );
  }
}