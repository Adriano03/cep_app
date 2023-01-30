import 'package:cep_app/pages/state_subclass/home_controller.dart';
import 'package:cep_app/pages/state_subclass/home_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomePageSubClass extends StatefulWidget {
  const HomePageSubClass({super.key});

  @override
  State<HomePageSubClass> createState() => _HomePageBlocSSubClass();
}

class _HomePageBlocSSubClass extends State<HomePageSubClass> {
  final homeController = HomeController();
  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // BlocListener fica escutando as mudanças de estado;
    return BlocListener<HomeController, HomeState>(
      bloc: homeController,
      listener: (context, state) {
        if (state is HomeFailure) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              backgroundColor: Colors.red,
              content: Text('Erro ao buscar Endereço'),
            ),
          );
        }
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Buscar CEP - Sub Class'),
          centerTitle: true,
        ),
        body: Form(
          key: formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: TextFormField(
                  keyboardType: TextInputType.number,
                  controller: cepEC,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Cep Obrigatório';
                    }
                    return null;
                  },
                ),
              ),
              const SizedBox(height: 25),
              ElevatedButton(
                onPressed: () async {
                  FocusScope.of(context).unfocus();
                  final valid = formKey.currentState?.validate() ?? false;
                  if (valid) {
                    homeController.findCep(cepEC.text);
                  }
                },
                child: const Text('Buscar'),
              ),
              BlocBuilder<HomeController, HomeState>(
                bloc: homeController,
                builder: (context, state) {
                  return Visibility(
                    visible: state is HomeLoading,
                    child: const CircularProgressIndicator(),
                  );
                },
              ),
              BlocBuilder<HomeController, HomeState>(
                bloc: homeController,
                builder: (context, state) {
                  if (state is HomeLoaded) {
                    return SizedBox(
                      width: double.infinity,
                      height: 210,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Cidade: ${state.enderecoModel.localidade}',
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text('Bairro: ${state.enderecoModel.bairro}'),
                          const SizedBox(height: 8),
                          Text('Rua: ${state.enderecoModel.logradouro}'),
                          const SizedBox(height: 8),
                          Text('CEP: ${state.enderecoModel.cep}'),
                          const SizedBox(height: 8),
                          Text('UF: ${state.enderecoModel.uf}'),
                        ],
                      ),
                    );
                  }

                  return const SizedBox.shrink();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
