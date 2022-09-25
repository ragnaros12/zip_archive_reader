part of 'zip_bloc.dart';

@immutable
abstract class ZipEvent {}


class GetZip extends ZipEvent{
  File file;

  GetZip({required this.file});
}

class NextDir extends ZipEvent{
  String dir;

  NextDir({ required this.dir});
}