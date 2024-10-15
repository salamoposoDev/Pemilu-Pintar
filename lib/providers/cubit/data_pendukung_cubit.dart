import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:pemilu_pintar/models/user.dart';
import 'package:pemilu_pintar/services/database_services.dart';

part 'data_pendukung_state.dart';

class DataPendukungCubit extends Cubit<DataPendukungState> {
  DataPendukungCubit() : super(DataPendukungLoading());
  DatabaseServices databaseServices = DatabaseServices();

  void getDataPendukung() {
    try {
      databaseServices.getDataPendukung().listen((snapshot) {
        final List<User> users = snapshot.docs
            .map((e) => User.fromJson(e.data() as Map<String, dynamic>))
            .toList();
        emit(DataPendukungData(user: users));
      });
    } catch (e) {}
  }
}
