part of 'camera_cubit.dart';

class CameraState extends Equatable {
  final String? linkGambar;
  final bool isLoading;
  final double uploadProgress;
  final String errorMessage;

  const CameraState(
      {this.linkGambar = '',
      this.isLoading = false,
      this.uploadProgress = 0,
      this.errorMessage = ''});

  @override
  List<Object> get props => [
        linkGambar!,
        isLoading,
        uploadProgress,
        errorMessage,
      ];
}
