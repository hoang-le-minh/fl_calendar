class DiaryModel {
  int id;
  String title;
  String content;
  DateTime time;
  String status;
  List<String> imageResources;
  DateTime createdDate;

  DiaryModel({required this.id,required this.title,required this.content,required this.time,required this.status,required this.imageResources,required this.createdDate});

}