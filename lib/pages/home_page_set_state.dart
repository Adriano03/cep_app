// ignore_for_file: library_private_types_in_public_api

import 'package:cep_app/models/endereco_model.dart';
import 'package:cep_app/repositories/cep_repository.dart';
import 'package:cep_app/repositories/cep_repository_impl.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final CepRepository cepRepository = CepRepositoryImpl();
  EnderecoModel? enderecoModel;
  bool loading = false;

  final formKey = GlobalKey<FormState>();
  final cepEC = TextEditingController();

  @override
  void dispose() {
    cepEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Buscar CEP Set State'),
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
                final valid = formKey.currentState?.validate() ?? false;
                if (valid) {
                  try {
                    setState(() {
                      loading = true;
                    });
                    final endereco = await cepRepository.getCep(cepEC.text);
                    setState(() {
                      loading = false;
                      enderecoModel = endereco;
                    });
                  } on Exception catch (_) {
                    setState(() {
                      loading = false;
                      enderecoModel = null;
                    });
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Erro ao buscar Endereço'),
                      ),
                    );
                  }
                }
              },
              child: const Text('Buscar'),
            ),
            Visibility(
              visible: loading,
              child: const CircularProgressIndicator(),
            ),
            Visibility(
              visible: enderecoModel != null,
              child: SizedBox(
                width: double.infinity,
                height: 210,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Cidade: ${enderecoModel?.localidade}',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text('Bairro: ${enderecoModel?.bairro}'),
                    const SizedBox(height: 8),
                    Text('Rua: ${enderecoModel?.logradouro}'),
                    const SizedBox(height: 8),
                    Text('CEP: ${enderecoModel?.cep}'),
                    const SizedBox(height: 8),
                    Text('UF: ${enderecoModel?.uf}'),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
