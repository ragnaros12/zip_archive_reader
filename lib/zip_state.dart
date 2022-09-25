part of 'zip_bloc.dart';

@immutable
abstract class ZipState {}

class ZipInitial extends ZipState {}

class ZipRead extends ZipState{
  List<ArchiveFile> archive;

  ZipRead({ required this.archive});
}
