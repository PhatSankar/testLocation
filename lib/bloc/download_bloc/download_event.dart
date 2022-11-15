part of 'download_bloc.dart';

class DownloadEvent extends Equatable {
  final String url;
  final String fileName;
  const DownloadEvent(this.url, this.fileName);

  @override
  List<Object?> get props => [];
}
