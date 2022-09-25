import 'dart:io';
import 'package:archive/archive.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:zip_archive/zip_bloc.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: Scaffold(
            body: BlocProvider<ZipBloc>(
          create: (c) => ZipBloc(),
          child: M(),
        )));
  }
}

class M extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
            child: Card(
          margin:
              const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 20),
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: BlocBuilder<ZipBloc, ZipState>(builder: (s, state) {
            if (state is ZipRead) {
              return ListView.builder(
                scrollDirection: Axis.vertical,
                itemBuilder: (c, index) {
                  return InkWell(
                    child: Row(
                      children: [
                        Icon(state.archive[index].isFile
                            ? Icons.file_copy
                            : Icons.folder),
                        const SizedBox(width: 5),
                        Text(state.archive[index].name)
                      ],
                    ),
                    onTap: () {
                      if(state.archive[index].isFile){
                        return;
                      }
                      context.read<ZipBloc>().add(NextDir(dir: state.archive[index].name));
                    },
                  );
                },
                itemCount: state.archive.length,
              );
            }
            return Container();
          }),
        )),
        Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            color: Colors.grey,
            child: InkWell(
              child: Container(
                  padding: const EdgeInsets.only(
                      left: 40, right: 40, top: 5, bottom: 5),
                  width: 200,
                  child: const Center(
                    child: Text("открыть архив"),
                  )),
              onTap: () async {
                FilePickerResult? result =
                    await FilePicker.platform.pickFiles();

                if (result != null) {
                  if (result.paths[0]!.split(".").last == "zip") {
                    var f = File(result.paths[0]!);
                    context.read<ZipBloc>().add(GetZip(file: f));
                  }
                } else {
                  // User canceled the picker
                }
              },
            )),
        const SizedBox(height: 20)
      ],
    );
  }
}
