import 'package:flutter/material.dart';
import 'package:soccer_quiz_flutter/screens/termos_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();
  
  // Controllers
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void _register() {
    if (_formKey.currentState!.validate()) {
      // Simulação de cadastro
      final name = _nameController.text;
      final email = _emailController.text;
      
      print("Cadastrando usuário: $name, $email");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Conta criada com sucesso!"), 
          backgroundColor: Colors.green
        ),
      );

      // Após cadastro, navegar para Login ou Home
      // Navigator.pushReplacement(context, MaterialPageRoute(builder: (_) => LoginScreen()));
      Navigator.pop(context); // Voltando para a tela anterior por enquanto
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      // AppBar transparente simples
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: BackButton(color: Colors.white),
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // LOGO E TÍTULO
                    SizedBox(height: 10),
                    Image.asset(
                      'assets/Logo.png',
                      width: 120,
                      errorBuilder: (c,e,s) => Icon(Icons.person_add, size: 80, color: Colors.cyan),
                    ),
                    SizedBox(height: 20),
                    Text(
                      "CRIAR CONTA",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1.5,
                      ),
                    ),
                    Text(
                      "Preencha os dados abaixo",
                      style: TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                    
                    SizedBox(height: 30),

                    // CAMPOS DO FORMULÁRIO
                    _buildNeonTextField(
                      controller: _nameController, 
                      icon: Icons.person, 
                      hint: "Nome Completo"
                    ),
                    SizedBox(height: 15),
                    
                    _buildNeonTextField(
                      controller: _emailController, 
                      icon: Icons.email, 
                      hint: "E-mail",
                      isEmail: true
                    ),
                    SizedBox(height: 15),
                    
                    _buildNeonTextField(
                      controller: _passwordController, 
                      icon: Icons.lock, 
                      hint: "Senha",
                      isPassword: true
                    ),
                    SizedBox(height: 15),
                    
                    _buildNeonTextField(
                      controller: _confirmPasswordController, 
                      icon: Icons.lock_outline, 
                      hint: "Confirmar Senha",
                      isPassword: true,
                      validator: (val) {
                         if (val != _passwordController.text) return "As senhas não coincidem";
                         return null;
                      }
                    ),

                    SizedBox(height: 40),

                    // BOTÃO CADASTRAR
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor:  Colors.lightGreen, // Verde Neon
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                          elevation: 5,
                          shadowColor: Colors.lightGreen.withOpacity(0.4),
                        ),
                        onPressed: _register,
                        child: Text(
                          "CADASTRAR",
                          style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),
                        ),
                      ),
                    ),

                    SizedBox(height: 20),

                    // LINK PARA LOGIN
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Já tem uma conta? ", style: TextStyle(color: Colors.grey)),
                        GestureDetector(
                          onTap: () {
                             // Navegar para LoginScreen
                             Navigator.pop(context); // Exemplo: volta se veio do login
                          },
                          child: Text(
                            "Entre aqui",
                            style: TextStyle(
                              color: Colors.lightGreen,
                              fontWeight: FontWeight.bold,
                              decoration: TextDecoration.underline,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          // RODAPÉ SIMPLIFICADO (Geralmente não mostra Coins em cadastro, mas mantive o padrão visual)
          Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen())),
                  child: Text("Privacidade", style: TextStyle(color: Colors.lightGreen, fontSize: 12))
                ),
                SizedBox(width: 20),
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => TermsScreen())),
                  child: Text("Termos", style: TextStyle(color:  Colors.lightGreen, fontSize: 12))
                ),
              ],
            ),
          )
        ],
      ),
    );
  }

  // Widget Reutilizável de Input Neon
  Widget _buildNeonTextField({
    required TextEditingController controller, 
    required IconData icon,
    required String hint,
    bool isPassword = false,
    bool isEmail = false,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      obscureText: isPassword,
      style: TextStyle(color: Colors.white),
      validator: validator ?? (val) {
        if (val == null || val.isEmpty) return "Campo Obrigatório";
        if (isEmail && !val.contains("@")) return "E-mail inválido";
        if (isPassword && val.length < 6) return "Mínimo 6 caracteres";
        return null;
      },
      decoration: InputDecoration(
        prefixIcon: Icon(icon, color: Colors.cyan),
        hintText: hint,
        hintStyle: TextStyle(color: Colors.grey[700]),
        filled: true,
        fillColor: Colors.white.withOpacity(0.05),
        // Borda Padrão (Cyan Neon)
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.cyan, width: 1.5),
          borderRadius: BorderRadius.circular(10),
        ),
        // Borda ao Clicar (Verde Neon)
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Color(0xFFCCDC39), width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
        // Borda de Erro
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent),
          borderRadius: BorderRadius.circular(10),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.redAccent, width: 2),
          borderRadius: BorderRadius.circular(10),
        ),
      ),
    );
  }
}