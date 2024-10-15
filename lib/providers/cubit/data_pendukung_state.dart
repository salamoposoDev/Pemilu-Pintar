part of 'data_pendukung_cubit.dart';

@immutable
sealed class DataPendukungState {}

final class DataPendukungLoading extends DataPendukungState {}

final class DataPendukungError extends DataPendukungState {
  final String error;
  DataPendukungError({required this.error});
}

final class DataPendukungEmpty extends DataPendukungState {}

final class DataPendukungData extends DataPendukungState {
  final List<User> user;

  DataPendukungData({required this.user});
}
