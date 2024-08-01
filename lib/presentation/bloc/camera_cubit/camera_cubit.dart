import 'dart:io';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:firebase_storage/firebase_storage.dart';

import '../../../routes/routes.dart';

part 'camera_state.dart';

class CameraCubit extends Cubit<CameraState> {
  CameraCubit() : super(const CameraState());

  Future<void> uploadImage({required String path}) async {
    final imageRef = storage.ref().child('images');

    try {
      emit(const CameraState(isLoading: true));

      final randomId = "${Random().nextInt(99) * 256}";

      final uploadTask = imageRef.child(randomId).putFile(File(path));

      uploadTask.snapshotEvents.listen((event) {
        switch (event.state) {
          case TaskState.running:
            final progress = 100 * (event.bytesTransferred / event.totalBytes);

            emit(
              CameraState(
                isLoading: true,
                uploadProgress: progress / 100,
              ),
            );
            break;
          case TaskState.success:
            event.ref.getDownloadURL().then((value) {
              emit(
                CameraState(
                  isLoading: false,
                  linkGambar: value,
                ),
              );
            });
            break;
          case TaskState.error:
            emit(CameraState(errorMessage: e.toString()));
            break;
          case TaskState.paused || TaskState.canceled:
            break;
        }
      });
    } catch (e) {
      emit(CameraState(errorMessage: e.toString()));
    }
  }
}
