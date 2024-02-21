
class Photo {
  String fileName;
  String filePath;
  DateTime dateTime;
  String info;

  Photo({
    required this.fileName,
    required this.filePath,
    required this.dateTime,
    required this.info,
  });

  static List<Photo> getPhotos() {
    List<Photo> photos = [];

    photos.add(Photo(
        fileName: "fileName1",
        filePath: "assets/images/1.png",
        dateTime: DateTime.now(),
        info: "info1"));
    photos.add(Photo(
        fileName: "fileName2",
        filePath: "assets/images/2.png",
        dateTime: DateTime.now(),
        info: "info2"));
    photos.add(Photo(
        fileName: "fileName3",
        filePath: "assets/images/3.png",
        dateTime: DateTime.now(),
        info: "info3"));
    photos.add(Photo(
        fileName: "fileName4",
        filePath: "assets/images/4.png",
        dateTime: DateTime.now(),
        info: "info4"));
    photos.add(Photo(
        fileName: "fileName5",
        filePath: "assets/images/5.png",
        dateTime: DateTime.now(),
        info: "info5"));
    photos.add(Photo(
        fileName: "fileName6",
        filePath: "assets/images/6.png",
        dateTime: DateTime.now(),
        info: "info6"));
    photos.add(Photo(
        fileName: "fileName7",
        filePath: "assets/images/7.png",
        dateTime: DateTime.now(),
        info: "info7"));
    photos.add(Photo(
        fileName: "fileName8",
        filePath: "assets/images/8.png",
        dateTime: DateTime.now(),
        info: "info8"));
    photos.add(Photo(
        fileName: "fileName9",
        filePath: "assets/images/9.png",
        dateTime: DateTime.now(),
        info: "info9"));
    photos.add(Photo(
        fileName: "fileName10",
        filePath: "assets/images/10.png",
        dateTime: DateTime.now(),
        info: "info10"));
    photos.add(Photo(
        fileName: "fileName11",
        filePath: "assets/images/11.png",
        dateTime: DateTime.now(),
        info: "info11"));
    photos.add(Photo(
        fileName: "fileName12",
        filePath: "assets/images/12.png",
        dateTime: DateTime.now(),
        info: "info12"));
    photos.add(Photo(
        fileName: "fileName13",
        filePath: "assets/images/13.png",
        dateTime: DateTime.now(),
        info: "info13"));
    photos.add(Photo(
        fileName: "fileName14",
        filePath: "assets/images/14.png",
        dateTime: DateTime.now(),
        info: "info14"));
    photos.add(Photo(
        fileName: "fileName15",
        filePath: "assets/images/15.png",
        dateTime: DateTime.now(),
        info: "info15"));

    return photos;
  }
}
