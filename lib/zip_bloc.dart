import 'dart:async';
import 'dart:io';
import 'package:archive/archive.dart';
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:meta/meta.dart';

import 'core/archive_data.dart' as Data;
part 'zip_event.dart';
part 'zip_state.dart';

class ZipBloc extends Bloc<ZipEvent, ZipState> {

  var decoder = ZipDecoder();
  late Archive archive;

  List<ArchiveFile> Find(String lib){
    var splLib = lib.split("/");
    return archive.files.where((element){
      if(!element.name.startsWith(lib)){
        return false;
      }
      var spl = element.name.split("/");
      if(element.isFile){
        if ((spl.length != splLib.length)) {
          return false;
        }
      }
      else {
        if ((spl.length != splLib.length + 1)) {
          return false;
        }
      }
      return true;
    }).toList();
  }


  ZipBloc() : super(ZipInitial()) {
    on<ZipEvent>((event, emit) {
      if(event is GetZip){
        archive = decoder.decodeBytes(event.file.readAsBytesSync());
        emit(ZipRead(archive: Find("")));
      }
      else if(event is NextDir){
        emit(ZipRead(archive: Find(event.dir)));
      }
    });
  }
}


