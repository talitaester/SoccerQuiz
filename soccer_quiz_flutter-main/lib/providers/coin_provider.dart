import 'package:flutter/material.dart';

class UserProvider extends ChangeNotifier {
  int _coins = 0; // Valor inicial
  bool _isLoading = false;

  int get coins => _coins;
  bool get isLoading => _isLoading;

  // Simulação da chamada ao Microserviço
  Future<void> fetchUserCoins() async {
    _isLoading = true;
    notifyListeners(); // Avisa a tela para mostrar loading se necessário

    try {
      // AQUI ENTRARIA A CHAMADA HTTP AO SEU MICROSERVIÇO
      // final response = await http.get(Uri.parse('seu-api/users/me/coins'));
      // _coins = jsonDecode(response.body)['amount'];
      
      // Simulando delay da rede
      await Future.delayed(Duration(seconds: 1)); 
      _coins = 150; // Valor vindo do banco de dados

    } catch (e) {
      print("Erro ao buscar coins: $e");
    } finally {
      _isLoading = false;
      notifyListeners(); // Atualiza a UI com o novo valor
    }
  }

  // Método para descontar moedas quando entrar na sala
  void spendCoins(int amount) {
    if (_coins >= amount) {
      _coins -= amount;
      // Aqui você também chamaria a API para registrar o gasto no backend
      notifyListeners();
    }
  }
}