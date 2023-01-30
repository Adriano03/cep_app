import 'package:cep_app/pages/state_single_class/home_state_single_class.dart';
import 'package:cep_app/repositoriesBloc/cep_repository.dart';
import 'package:cep_app/repositoriesBloc/cep_repository_impl.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeSingleClassController extends Cubit<HomeStateSingleClass> {
  final CepRepository cepRepository = CepRepositoryImpl();

  HomeSingleClassController() : super(HomeStateSingleClass());

  //Metodo para buscar os dados;
  Future<void> findCep(String cep) async {
    try {
      // Emitir o loading;
      emit(state.copyWith(status: HomeStatus.loading));
      final enderecoModel = await cepRepository.getCep(cep);
      emit(
        state.copyWith(status: HomeStatus.loaded, enderecoModel: enderecoModel),
      );
    } catch (e) {
      emit(state.copyWith(status: HomeStatus.failure));
    }
  }
}
