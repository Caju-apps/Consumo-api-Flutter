import 'package:consumo_api_class/api/api.dart';
import 'package:consumo_api_class/models/post_model.dart';
import 'package:consumo_api_class/pages/alterar_post_page.dart';
import 'package:consumo_api_class/pages/novo_post_page.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Api api = Api();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("home"),
        actions: [
          IconButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (_) => const NovoPostPage()));
              },
              icon: const Icon(Icons.post_add))
        ],
      ),
      body: Container(
          padding: const EdgeInsets.all(8.0),
          child: FutureBuilder<List<PostModel>>(
              future: api.getAllPost(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }

                if (snapshot.connectionState == ConnectionState.done) {
                  List<PostModel> list = snapshot.data ?? [];
                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (context, index) => ListTile(
                      leading: const Icon(Icons.book),
                      trailing: IconButton(
                          onPressed: () {
                            deletePost(list[index].id);
                          },
                          icon: const Icon(Icons.delete)),
                      title: Text(list[index].title),
                      subtitle: Text(
                        list[index].body,
                        maxLines: 1,
                      ),
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (_) =>
                                    AlterarPostPage(post: list[index])));
                      },
                    ),
                  );
                }

                return const Center(child: Text("Erro nos dados"));
              })),
    );
  }

  void deletePost(int id) async {
    bool valor = await api.deletarPost(id);

    if (valor) {
      showSnackBar("Post deletado!");
    } else {
      showSnackBar("Falha ao deletar Post!");
    }
  }

  void showSnackBar(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }
}
