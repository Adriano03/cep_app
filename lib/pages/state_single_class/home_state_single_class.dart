import 'package:cep_app/models/endereco_model.dart';

enum HomeStatus {
  initial,
  loading,
  loaded,
  failure,
}

class HomeStateSingleClass {
  final EnderecoModel? enderecoModel;
  final HomeStatus status;
  HomeStateSingleClass({
    this.status = HomeStatus.initial,
    this.enderecoModel,
  });

  HomeStateSingleClass copyWith({
    EnderecoModel? enderecoModel,
    HomeStatus? status,
  }) {
    return HomeStateSingleClass(
      enderecoModel: enderecoModel ?? this.enderecoModel,
      status: status ?? this.status,
    );
  }
}
