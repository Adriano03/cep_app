// Exemplo usando o Subclass do Bloc;

import 'package:bloc/bloc.dart';
import 'package:cep_app/pages/state_subclass/home_state.dart';
import 'package:cep_app/repositoriesBloc/cep_repository.dart';
import 'package:cep_app/repositoriesBloc/cep_repository_impl.dart';

class HomeController extends Cubit<HomeState> {
  final CepRepository cepRepository = CepRepositoryImpl();
  // Inicia a tela com o HomeInitial;
  HomeController() : super(HomeInitial());

  //Metodo para buscar os dados;
  Future<void> findCep(String cep) async {
    try {
      // Emitir o loading;
      emit(HomeLoading());
      final enderecoModel = await cepRepository.getCep(cep);
      // Se os dados vierem corretos, é emitido o novo estado passando o end carregado;
      emit(HomeLoaded(enderecoModel: enderecoModel));
    } catch (e) {
      // Esse estaod é emitido se houver qualquer problema;
      emit(HomeFailure());
    }
  }
}
