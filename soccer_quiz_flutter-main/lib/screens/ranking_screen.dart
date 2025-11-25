import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_quiz_flutter/screens/termos_screen.dart';
import '../providers/coin_provider.dart';
import 'ranking_detail_screen.dart';

class RankingListScreen extends StatefulWidget {
  @override
  State<RankingListScreen> createState() => _RankingListScreenState();
}

class _RankingListScreenState extends State<RankingListScreen> {
  // Dados fictícios (Mock)
  final List<Map<String, String>> historyQuizzes = [
    {"name": "Quiz de Tiago", "date": "26/10/2025"},
    {"name": "Quiz de João", "date": "22/08/2025"},
    {"name": "Quiz de Marcos", "date": "05/06/2025"},
    {"name": "Quiz de Ana", "date": "01/06/2025"},
  ];

  @override
  void initState() {
    super.initState();
    // CORREÇÃO: Atualiza as moedas ao entrar na tela
    // O addPostFrameCallback garante que a construção da UI terminou antes de chamar o Provider
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<UserProvider>(context, listen: false).fetchUserCoins();
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
      ),
      body: Column(
        children: [
          // Logo
          Image.asset(
            'assets/Logo.png', 
            width: 150,
            errorBuilder: (c,e,s) => Icon(Icons.sports_soccer, size: 80, color: Colors.blue),
          ),
          
          SizedBox(height: 10),
          Text(
            "Ranking",
            style: TextStyle(color: Colors.white, fontSize: 22, fontWeight: FontWeight.w300),
          ),
          SizedBox(height: 30),

          // Lista de Rankings Passados
          Expanded(
            child: ListView.builder(
              padding: EdgeInsets.symmetric(horizontal: 20),
              itemCount: historyQuizzes.length,
              itemBuilder: (context, index) {
                final item = historyQuizzes[index];
                return _buildHistoryItem(context, item);
              },
            ),
          ),

          // Botão Voltar e Rodapé
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildHistoryItem(BuildContext context, Map<String, String> item) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: InkWell(
        onTap: () {
          // Ao clicar, vai para o detalhe daquele ranking
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => RankingDetailScreen(quizName: item['name']!),
            ),
          );
        },
        child: Row(
          children: [
            Icon(Icons.sports_soccer, color: Colors.blueGrey[200], size: 30),
            SizedBox(width: 10),
            Expanded(
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 15),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.cyan, width: 2),
                ),
                child: Text(
                  "${item['name']} - ${item['date']}",
                  style: TextStyle(color: Colors.white, fontSize: 16),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 10),
        // Botão Voltar Grande
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
        
        // Rodapé Links + Coins
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