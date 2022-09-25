import 'package:archive/archive.dart';

class ArchiveData{
  String path;
  bool isFile;

  ArchiveData({required this.path,required this.isFile});
}

class ArchiveDirectory extends ArchiveData{
  List<ArchiveData> data;

  ArchiveDirectory(path, this.data) : super(path: path, isFile: false);
}

class ArchiveFile extends ArchiveData{
  ArchiveFile(path) : super(path: path, isFile: true);

}