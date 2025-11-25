# SOLID aplicado — como e onde

Nesta versão adotamos padrões claros que permitem rastrear cada princípio SOLID no código:

- SRP (Single Responsibility)
  - `ApiClient` = responsabilidade de chamadas HTTP e armazenamento de token.
  - `AuthRepository` = responsabilidade de traduzir chamadas de API para operações de autenticação.
  - `AuthProvider` = responsabilidade de manter estado de autenticação e lógica de UI.

- OCP (Open/Closed)
  - `IAuthRepository` é uma abstração; a implementação `AuthRepository` pode ser substituída (por exemplo, por `MockAuthRepository`) sem alterar consumidores.

- LSP (Liskov)
  - Implementações de `IAuthRepository` respeitam contratos; substituições não devem alterar semântica.

- ISP (Interface Segregation)
  - Interfaces pequenas: `IAuthRepository` contém apenas métodos necessários ao fluxo de autenticação.

- DIP (Dependency Inversion)
  - Camadas dependem de abstrações: `AuthProvider` depende de `IAuthRepository`, não de `AuthRepository` diretamente.
  - Injecao feita no `ServiceContainer` em `services/di.dart`.

Essas escolhas facilitam testes, manutenção e evolução.