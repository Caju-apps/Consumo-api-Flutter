import 'package:consumo_api_class/api/api.dart';
import 'package:consumo_api_class/models/post_model.dart';
import 'package:flutter/material.dart';

class AlterarPostPage extends StatefulWidget {
  final PostModel post;
  const AlterarPostPage({super.key, required this.post});

  @override
  State<AlterarPostPage> createState() => _AlterarPostPageState();
}

class _AlterarPostPageState extends State<AlterarPostPage> {
  Api api = Api();
  late PostModel post;

  @override
  void initState() {
    post = widget.post;
    super.initState();
  }

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
              controller: TextEditingController(text: post.title),
              decoration: const InputDecoration(label: Text("Titulo")),
              onChanged: (valor) => post.title = valor,
            ),
            TextField(
              controller: TextEditingController(text: post.body),
              decoration: const InputDecoration(label: Text("Descrição")),
              maxLines: 5,
              onChanged: (valor) => post.body = valor,
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                  onPressed: () {
                    salvarPost();
                  },
                  child: const Text("Alterar Post")),
            )
          ],
        ),
      ),
    );
  }

  void salvarPost() async {
    bool valor = await api.alterarPost(post);

    if (valor) {
      showSnackBar("Post Alterado!");
    } else {
      showSnackBar("Falha ao alterar Post!");
    }
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
