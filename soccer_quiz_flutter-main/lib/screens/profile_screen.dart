import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_quiz_flutter/screens/termos_screen.dart';
import '../providers/coin_provider.dart';

class ProfileScreen extends StatefulWidget {
  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final _formKey = GlobalKey<FormState>();

  // Controllers com dados fictícios do "Usuário Logado"
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Simulando dados do usuário logado
    _nameController = TextEditingController(text: "Admin do Sistema");
    _emailController = TextEditingController(text: "admin@soccerquiz.com");
    _passwordController = TextEditingController(text: ""); 

    // Atualiza moedas
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUserCoins();
    });
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void _saveProfile() {
    if (_formKey.currentState!.validate()) {
      // Lógica de salvar no backend aqui
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Perfil atualizado com sucesso!"), backgroundColor: Colors.green),
      );
    }
  }

  void _logout() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("Sair do Sistema?", style: TextStyle(color: Colors.white)),
        content: Text("Você terá que fazer login novamente.", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            child: Text("Cancelar", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("SAIR", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context); // Fecha Dialog
              // Lógica de Logout real (limpar token, provider, etc)
              // Exemplo: Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
              // Por enquanto, apenas fecha a tela ou volta pro início
              Navigator.popUntil(context, (route) => route.isFirst);
            },
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
        title: Text("Meu Perfil", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20, vertical: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    // FOTO DE PERFIL
                    Stack(
                      children: [
                        Container(
                          padding: EdgeInsets.all(4),
                          decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.cyan, width: 2),
                            boxShadow: [
                              BoxShadow(color: Colors.cyan.withOpacity(0.3), blurRadius: 10, spreadRadius: 2)
                            ]
                          ),
                          child: CircleAvatar(
                            radius: 50,
                            backgroundColor: Colors.grey[900],
                            child: Icon(Icons.person, size: 60, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    
                    SizedBox(height: 30),

                    // FORMULÁRIO
                    _buildLabel("Nome de Exibição"),
                    _buildNeonTextField(controller: _nameController, icon: Icons.person),
                    SizedBox(height: 20),

                    _buildLabel("E-mail"),
                    _buildNeonTextField(controller: _emailController, icon: Icons.email, isEmail: true),
                    SizedBox(height: 20),

                    _buildLabel("Alterar Senha"),
                    _buildNeonTextField(controller: _passwordController, icon: Icons.lock, isPassword: true, hint: "Digite para alterar"),
                    
                    SizedBox(height: 40),

                    // BOTÃO SALVAR
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Color(0xFFCCDC39), // Verde Neon
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _saveProfile,
                        child: Text(
                          "SALVAR PERFIL",
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // BOTÃO SAIR
                    TextButton.icon(
                      onPressed: _logout,
                      icon: Icon(Icons.exit_to_app, color: Colors.red),
                      label: Text("Sair do Sistema", style: TextStyle(color: Colors.red, fontSize: 16)),
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 20),
                        shape: RoundedRectangleBorder(
                          side: BorderSide(color: Colors.red.withOpacity(0.5)),
                          borderRadius: BorderRadius.circular(10)
                        )
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // RODAPÉ
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 5.0, left: 5),
        child: Text(text, style: TextStyle(color: Colors.white70, fontSize: 14)),
      ),
    );
  }

  Widget _buildNeonTextField({
    required TextEditingController controller, 
    required IconData icon,
    bool isPassword = false,
    bool isEmail = false,
    String? hint,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      validator: (val) {
        if (!isPassword && (val == null || val.isEmpty)) return "Campo Obrigatório";
        if (isEmail && !val!.contains("@")) return "E-mail inválido";
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.cyan), // Ícone Cyan
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey[800]!, width: 1),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan, width: 2), // Borda Neon ao focar
          borderRadius: BorderRadius.circular(10),
        ),
        errorBorder: OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 20),
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
    );
  }
}