// Exemplo usando o Subclass do Bloc;

// Aqui fica as váriaveis de estado;
import 'package:cep_app/models/endereco_model.dart';

abstract class HomeState {}

// Essa clase vai representar o estado inicial;
class HomeInitial extends HomeState {}

// Estado de loaging;
class HomeLoading extends HomeState {}

// Estado de erro;
class HomeFailure extends HomeState {}

// Resultado;
class HomeLoaded extends HomeState {
  final EnderecoModel enderecoModel;
  HomeLoaded({
    required this.enderecoModel,
  });
}
