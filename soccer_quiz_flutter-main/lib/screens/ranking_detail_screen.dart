import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:soccer_quiz_flutter/screens/termos_screen.dart';
import '../providers/coin_provider.dart';

class RankingDetailScreen extends StatelessWidget {
  final String quizName;

  RankingDetailScreen({required this.quizName});

  // Mock Data da Tabela
  final List<Map<String, dynamic>> rankingData = [
    {"rank": 1, "name": "João", "time": "2:03", "hits": 10}, // Score 100 -> 10 Acertos
    {"rank": 2, "name": "Márcio", "time": "2:35", "hits": 9},
    {"rank": 3, "name": "Lucas", "time": "2:30", "hits": 8},
    {"rank": 4, "name": "Jonathan", "time": "2:35", "hits": 7},
    {"rank": 5, "name": "Eduardo", "time": "3:00", "hits": 6},
    {"rank": 6, "name": "Davi", "time": "3:03", "hits": 5},
    {"rank": 7, "name": "Marcos", "time": "3:14", "hits": 4},
    {"rank": 8, "name": "José", "time": "3:17", "hits": 3},
    {"rank": 9, "name": "Maria", "time": "3:30", "hits": 2},
    {"rank": 10, "name": "Pedro", "time": "5:01", "hits": 1},
  ];

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
          // Logo e Título
          Image.asset('assets/Logo.png', width: 120, errorBuilder: (c,e,s) => Icon(Icons.sports_soccer, size: 60, color: Colors.blue)),
          SizedBox(height: 10),
          Text(
            "Ranking - $quizName",
            style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.w300),
          ),
          
          SizedBox(height: 20),

          // TABELA (Card Cinza/Verde)
          Expanded(
            child: Container(
              margin: EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: Colors.grey[300], // Fundo cinza do cabeçalho
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                children: [
                  // Cabeçalho da Tabela
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 15.0, horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(flex: 3, child: Text("NOME", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                        Expanded(flex: 2, child: Center(child: Text("TEMPO", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))),
                        Expanded(flex: 2, child: Center(child: Text("ACERTOS", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)))),
                      ],
                    ),
                  ),

                  // Corpo da Tabela (Fundo Verde Limão)
                  Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        color: Color(0xFFD4E157), // Tom aproximado do verde da imagem
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(20),
                          bottomRight: Radius.circular(20),
                        ),
                      ),
                      child: ListView.builder(
                        padding: EdgeInsets.only(top: 10, bottom: 10),
                        itemCount: rankingData.length,
                        itemBuilder: (context, index) {
                          final item = rankingData[index];
                          return Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 20),
                            child: Row(
                              children: [
                                // Nome e Rank (Ex: "1 - João")
                                Expanded(
                                  flex: 3, 
                                  child: Text(
                                    "${item['rank']} - ${item['name']}",
                                    style: TextStyle(fontSize: 16, color: Colors.black87),
                                  )
                                ),
                                // Tempo
                                Expanded(
                                  flex: 2, 
                                  child: Center(
                                    child: Text(
                                      item['time'],
                                      style: TextStyle(fontSize: 16, color: Colors.black87),
                                    ),
                                  )
                                ),
                                // Acertos (Score)
                                Expanded(
                                  flex: 2, 
                                  child: Center(
                                    child: Text(
                                      item['hits'].toString(),
                                      style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.black),
                                    ),
                                  )
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),

          // Botão Voltar e Rodapé
          _buildFooter(context),
        ],
      ),
    );
  }

  Widget _buildFooter(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 20),
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