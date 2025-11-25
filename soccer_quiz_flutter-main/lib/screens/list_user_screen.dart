import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_quiz_flutter/screens/edit_user_screen.dart';
import 'package:soccer_quiz_flutter/screens/termos_screen.dart';
import '../providers/coin_provider.dart';

class UserListScreen extends StatefulWidget {
  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  // Dados Mockados (Simulando API)
  final List<Map<String, String>> _users = [
    {"id": "1", "name": "Tiago Silva", "email": "tiago@email.com", "role": "Admin"},
    {"id": "2", "name": "João Souza", "email": "joao@email.com", "role": "User"},
    {"id": "3", "name": "Marcos Oliveira", "email": "marcos@email.com", "role": "User"},
    {"id": "4", "name": "Ana Clara", "email": "ana@email.com", "role": "Editor"},
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUserCoins();
    });
  }

  // Função para simular a remoção na lista visualmente ao voltar da edição
  void _removeUserById(String id) {
    setState(() {
      _users.removeWhere((user) => user['id'] == id);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text("Gerenciar Usuários", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Logo Pequeno
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Image.asset(
              'assets/Logo.png', 
              width: 100,
              errorBuilder: (c,e,s) => Icon(Icons.people_alt, size: 60, color: Colors.blue),
            ),
          ),
          
          SizedBox(height: 10),

          // LISTA
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: _users.length,
              itemBuilder: (context, index) {
                final user = _users[index];
                return _buildUserItem(user);
              },
            ),
          ),

          // RODAPÉ
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildUserItem(Map<String, String> user) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () async {
          // Navega para editar e espera um resultado (caso tenha sido deletado)
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => UserEditScreen(userData: user),
            ),
          );

          // Se retornou "deleted", remove da lista
          if (result == 'deleted') {
            _removeUserById(user['id']!);
          }
        },
        child: Row(
          children: [
            // Ícone de Perfil
            Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(color: Colors.cyan, width: 1),
              ),
              child: CircleAvatar(
                backgroundColor: Colors.grey[900],
                radius: 25,
                child: Text(
                  user['name']![0], // Primeira letra do nome
                  style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            
            SizedBox(width: 15),
            
            // Card com Informações
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan, width: 2), // Borda Neon
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10),
                  ),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      user['name']!,
                      style: TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      user['email']!,
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  ],
                ),
              ),
            ),
            
            // Ícone de Seta indicando ação
            SizedBox(width: 10),
            Icon(Icons.edit, color: Color(0xFFCCDC39), size: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        Container(
          width: 200,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFCCDC39),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            ),
            onPressed: () => Navigator.pop(context),
            child: Text(
              "Voltar",
              style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ),
        SizedBox(height: 20),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Row(
                children: [
                   GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen())),
                    child: Text("Privacidade", style: TextStyle(color: Color(0xFFCCDC39), fontSize: 12))
                  ),
                  SizedBox(width: 10),
                  GestureDetector(
                    onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen())),
                    child: Text("Termos", style: TextStyle(color: Color(0xFFCCDC39), fontSize: 12))
                  ),
                ],
              ),
              Consumer<UserProvider>(
                builder: (context, userProvider, child) {
                  return Text(
                    "Soccer Coins: ${userProvider.coins}",
                    style: TextStyle(color: Colors.white, fontSize: 16),
                  );
                },
              ),
            ],
          ),
        )
      ],
    );
  }
}