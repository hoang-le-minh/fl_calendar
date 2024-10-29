import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';

import '../model/mood_model.dart';

class Chart extends StatelessWidget {
  const Chart({super.key});

  @override
  Widget build(BuildContext context) {
    List<MoodModel> listMoodModel = _listMoodModel();
    int maxQuantity = listMoodModel.map((mood) => mood.quantity).reduce((a, b) => a > b ? a : b);
    int maxYInt = maxQuantity % 2 == 0 ? maxQuantity : maxQuantity + 1;
    return Card(
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16)
      ),
      margin: EdgeInsets.all(16),
      child: Container(
        padding: EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: const [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 10,
              offset: Offset(0, 5),
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            const Row(
              mainAxisSize: MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Mood Statistics',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Last 30 days',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            // Bọc BarChart trong SingleChildScrollView để cuộn ngang
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 4),
              scrollDirection: Axis.horizontal,
              child: SizedBox(
                width: listMoodModel.length * 50.0,
                // Điều chỉnh chiều rộng dựa trên số lượng cột
                height: 220,
                // Tăng chiều cao nếu cần
                child: BarChart(
                  BarChartData(
                    maxY: maxYInt*1.0,
                    barGroups: _buildBarGroups(listMoodModel),
                    titlesData: FlTitlesData(
                      bottomTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 40,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            final emoji = listMoodModel[value.toInt()].emoji;
                            return Padding(
                              padding: const EdgeInsets.only(top: 4.0),
                              child: Text(
                                emoji,
                                style: TextStyle(fontSize: 24),
                              ),
                            );
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 20, // Tăng kích thước dự trữ
                          interval: 2, // Chia khoảng cách đơn vị
                          getTitlesWidget: (value, meta) {
                            return Padding(
                              // Thêm padding
                              padding: const EdgeInsets.only(top: 10.0),
                              // Thay đổi giá trị này nếu cần
                              child: Text(
                                value.toInt().toString(), // Hiển thị giá trị
                                style: const TextStyle(
                                  fontSize: 14,
                                  fontFamily: 'Nunito',
                                  fontWeight: FontWeight.w700,
                                  color: Color(0xFFAAAAAA),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(showTitles: false),
                      ),
                    ),
                    borderData: FlBorderData(
                      show: true, // Bật hiển thị đường biên
                      border: Border(
                        bottom: BorderSide(
                            color: Color(0xFFAAAAAA),
                            width: 0.5), // Đường trục X
                        left: BorderSide(
                            color: Color(0xFFAAAAAA),
                            width: 0.5), // Đường trục Y
                      ),
                    ),
                    gridData: FlGridData(show: false),
                    barTouchData: BarTouchData(
                      enabled: false, // Tắt click để hiện giá trị
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

List<MoodModel> _listMoodModel() {
  return [
    MoodModel(0, '😂', 7),
    MoodModel(1, '😄', 5),
    MoodModel(2, '🤣', 3),
    MoodModel(3, '😃', 8),
    MoodModel(4, '😌', 2),
    MoodModel(5, '😊', 9),
    MoodModel(6, '😍', 1),
    MoodModel(7, '😈', 4),
    MoodModel(8, '😘', 3)
  ];
}

// Hàm tạo các nhóm cột từ List<MoodModel>
List<BarChartGroupData> _buildBarGroups(List<MoodModel> data) {
  return List.generate(data.length, (i) {
    return BarChartGroupData(
      x: i, // Vị trí của cột
      barRods: [
        BarChartRodData(
          toY: data[i].quantity * 1.0, // Giá trị cột từ List<MoodModel>
          color: Color(0xFFFF97AB),
          width: 25, // Độ rộng của mỗi cột
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(6), topRight: Radius.circular(6)),
        ),
      ],
    );
  });
}