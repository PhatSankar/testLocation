part of 'download_bloc.dart';

abstract class DownloadState extends Equatable {
  const DownloadState();
}

class DownloadInitial extends DownloadState {
  @override
  List<Object> get props => [];
}

class Downloading extends DownloadState {
  @override
  List<Object> get props => [];
}

class DownloadComplete extends DownloadState {
  @override
  List<Object> get props => [];
}

class DownloadFailed extends DownloadState {
  @override
  List<Object> get props => [];
}
