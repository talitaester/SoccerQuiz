# Soccer Quiz - Flutter Client (Production-ready skeleton)

Esta entrega atualiza o protótipo para um cliente Flutter mais profissional, usando padrões de projeto, injeção de dependência simples e código pronto para integrar com APIs reais.

## Principais melhorias
- ApiClient com token storage (flutter_secure_storage).
- Repository pattern e interface (`IAuthRepository` / `AuthRepository`).
- Provider-based state management (`AuthProvider`).
- Fluxo de Quiz e Ranking implementado como chamadas HTTP reais (`/quiz/questions`, `/quiz/submit`, `/ranking/top`).
- Estrutura modular e limpa, preparada para testes e CI.

## Como rodar
1. Instale o Flutter SDK.
2. Ajuste a variável `BASE_URL` ao build: exemplo:
   ```bash
   flutter run --dart-define=BASE_URL=https://seu-api.example.com
   ```
   Se não informado, o valor padrão é `https://api.example.com`.
3. Execute:
   ```bash
   flutter pub get
   flutter run -d <SEU_DISPOSITIVO>
   ```

## Variáveis e autenticação
- O endpoint `/auth/login` deve retornar JSON com `{ "token": "<jwt>" }`.
- As rotas protegidas `/user/me`, `/quiz/*`, `/ranking/*` assumem autenticação via header `Authorization: Bearer <token>`.

## Testes
- Um teste de exemplo está em `test/auth_service_test.dart` usando `mockito`.

## Próximos passos sugeridos
- Implementar refresh token e tratamento de expiração.
- Adicionar integração com analytics e crash reporting.
- Configurar CI (GitHub Actions) para testes e builds.