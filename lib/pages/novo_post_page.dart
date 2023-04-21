import 'package:consumo_api_class/api/api.dart';
import 'package:consumo_api_class/models/post_model.dart';
import 'package:flutter/material.dart';

class NovoPostPage extends StatefulWidget {
  const NovoPostPage({super.key});

  @override
  State<NovoPostPage> createState() => _NovoPostPageState();
}

class _NovoPostPageState extends State<NovoPostPage> {
  Api api = Api();
  String title = "";
  String body = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post"),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        child: Column(
          children: [
            TextField(
              decoration: const InputDecoration(label: Text("Titulo")),
              onChanged: (valor) => title = valor,
            ),
            TextField(
              decoration: const InputDecoration(label: Text("Descrição")),
              maxLines: 5,
              onChanged: (valor) => body = valor,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    salvarPost();
                  },
                  child: const Text("Salvar Post")),
            )
          ],
        ),
      ),
    );
  }

  void salvarPost() async {
    bool valor = await api
        .salvarPost(PostModel(userId: 1, id: 1, title: title, body: body));

    if (valor) {
      showSnackBar("Post Salvo!");
    } else {
      showSnackBar("Falha ao Salvar Post!");
    }
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
