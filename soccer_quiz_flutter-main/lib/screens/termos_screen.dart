import 'package:flutter/material.dart';

class TermsScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Estilo base para o texto do corpo
    final TextStyle bodyStyle = TextStyle(
      color: Colors.white70,
      fontSize: 14,
      height: 1.5, // Espaçamento entre linhas para leitura
    );

    // Estilo para os subtítulos
    final TextStyle headingStyle = TextStyle(
      color: Colors.cyan, // Azul neon para destacar
      fontSize: 16,
      fontWeight: FontWeight.bold,
    );

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        iconTheme: IconThemeData(color: Colors.white),
        centerTitle: true,
        title: Text(
          "Termos e Privacidade",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // Área de Conteúdo (Texto com Borda)
          Expanded(
            child: Container(
              margin: EdgeInsets.all(20),
              padding: EdgeInsets.all(20),
              width: double.infinity,
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.05), // Fundo levemente cinza
                border: Border.all(color: Colors.cyan, width: 2), // Borda Neon
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("Última atualização: Novembro 2025",
                        style: TextStyle(color: Colors.grey, fontSize: 12)),
                    SizedBox(height: 20),

                    Text("1. Aceitação dos Termos", style: headingStyle),
                    SizedBox(height: 5),
                    Text(
                      "Ao acessar o Soccer Quiz, você concorda em utilizar o aplicativo apenas para fins de entretenimento e de forma lícita.",
                      style: bodyStyle,
                    ),
                    SizedBox(height: 20),

                    Text("2. Moedas Virtuais (Soccer Coins)", style: headingStyle),
                    SizedBox(height: 5),
                    Text(
                      "As 'Soccer Coins' são itens virtuais de uso exclusivo dentro do aplicativo. Elas não possuem valor monetário real e não podem ser trocadas por dinheiro ou bens fora do jogo.",
                      style: bodyStyle,
                    ),
                    SizedBox(height: 20),

                    Text("3. Privacidade e Dados", style: headingStyle),
                    SizedBox(height: 5),
                    Text(
                      "Respeitamos sua privacidade. Coletamos apenas dados essenciais (como ID de usuário e pontuação) para manter o ranking e o funcionamento das partidas multiplayer. Não compartilhamos seus dados com terceiros.",
                      style: bodyStyle,
                    ),
                    SizedBox(height: 20),

                    Text("4. Fair Play", style: headingStyle),
                    SizedBox(height: 5),
                    Text(
                      "O uso de bots, hacks ou qualquer método para manipular resultados resultará no banimento permanente da conta.",
                      style: bodyStyle,
                    ),
                    SizedBox(height: 30),
                    
                    Center(
                      child: Icon(Icons.shield_outlined, color: Colors.cyan, size: 40),
                    )
                  ],
                ),
              ),
            ),
          ),

          // Botão Voltar (Estilo Padrão Verde)
          Padding(
            padding: const EdgeInsets.only(bottom: 30.0, left: 20, right: 20),
            child: SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: Color(0xFFCCDC39), // Verde Limão
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Entendi e Concordo",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}