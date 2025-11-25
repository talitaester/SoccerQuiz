import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_quiz_flutter/screens/termos_screen.dart';
import '../providers/coin_provider.dart';

class UserEditScreen extends StatefulWidget {
  final Map<String, String> userData;

  const UserEditScreen({Key? key, required this.userData}) : super(key: key);

  @override
  State<UserEditScreen> createState() => _UserEditScreenState();
}

class _UserEditScreenState extends State<UserEditScreen> {
  final _formKey = GlobalKey<FormState>();
  
  late TextEditingController _nameController;
  late TextEditingController _emailController;
  late TextEditingController _passwordController;

  @override
  void initState() {
    super.initState();
    // Inicializa os campos com os dados vindos da lista
    _nameController = TextEditingController(text: widget.userData['name']);
    _emailController = TextEditingController(text: widget.userData['email']);
    _passwordController = TextEditingController(text: ""); // Senha vazia por segurança
    
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

  void _saveChanges() {
    if (_formKey.currentState!.validate()) {
      // LOGICA DE UPDATE NO BANCO VIRIA AQUI
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Dados atualizados com sucesso!"), backgroundColor: Colors.green),
      );
      Navigator.pop(context, 'updated'); // Retorna indicando sucesso
    }
  }

  void _confirmDelete() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        backgroundColor: Colors.grey[900],
        title: Text("Remover Usuário?", style: TextStyle(color: Colors.white)),
        content: Text("Essa ação não pode ser desfeita.", style: TextStyle(color: Colors.white70)),
        actions: [
          TextButton(
            child: Text("Cancelar", style: TextStyle(color: Colors.grey)),
            onPressed: () => Navigator.pop(context),
          ),
          TextButton(
            child: Text("REMOVER", style: TextStyle(color: Colors.red, fontWeight: FontWeight.bold)),
            onPressed: () {
              Navigator.pop(context); // Fecha Dialog
              
              // LOGICA DE DELETE NO BANCO VIRIA AQUI
              
              Navigator.pop(context, 'deleted'); // Volta para a lista com sinal de delete
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text("Usuário removido."), backgroundColor: Colors.red),
              );
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
        title: Text("Editar Usuário", style: TextStyle(color: Colors.white, fontWeight: FontWeight.w300)),
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(shape: BoxShape.circle, color: Colors.cyan),
                        child: CircleAvatar(
                          radius: 40,
                          backgroundColor: Colors.black,
                          child: Icon(Icons.person, size: 50, color: Colors.white),
                        ),
                      ),
                    ),
                    SizedBox(height: 30),

                    // CAMPO: NOME
                    Text("Nome Completo", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 5),
                    _buildNeonTextField(controller: _nameController, icon: Icons.person),
                    SizedBox(height: 20),

                    // CAMPO: EMAIL
                    Text("E-mail", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 5),
                    _buildNeonTextField(controller: _emailController, icon: Icons.email, isEmail: true),
                    SizedBox(height: 20),

                    // CAMPO: NOVA SENHA
                    Text("Nova Senha (Opcional)", style: TextStyle(color: Colors.white70)),
                    SizedBox(height: 5),
                    _buildNeonTextField(controller: _passwordController, icon: Icons.lock, isPassword: true, hint: "Deixe vazio para manter"),
                    
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
                        onPressed: _saveChanges,
                        child: Text(
                          "SALVAR ALTERAÇÕES",
                          style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // BOTÃO REMOVER
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: OutlinedButton(
                        style: OutlinedButton.styleFrom(
                          side: BorderSide(color: Colors.red, width: 2),
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                        ),
                        onPressed: _confirmDelete,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.delete_outline, color: Colors.red),
                            SizedBox(width: 10),
                            Text(
                              "REMOVER USUÁRIO",
                              style: TextStyle(color: Colors.red, fontSize: 16, fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
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
        prefixIcon: Icon(icon, color: Colors.grey),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFCCDC39), width: 2),
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
          GestureDetector(
             onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen())),
             child: Text("Privacidade e Termos", style: TextStyle(color: Color(0xFFCCDC39), fontSize: 12))
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