# N64 Classics Catalog 🎮

Um aplicativo moderno com estética retrô desenvolvido em Flutter para listagem e gerenciamento de favoritos de jogos do lendário Nintendo 64.

## 🚀 Tecnologias e Recursos
* **Flutter & Dart**: Desenvolvimento cross-platform.
* **RAWG Video Games API**: Consumo de dados reais de jogos.
* **Firebase Authentication**: Login e cadastro de usuários.
* **Cloud Firestore**: Persistência de dados (favoritos) em tempo real.
* **Provider**: Gerenciamento de estado robusto.
* **Cached Network Image**: Performance no carregamento de capas.

## 🏗️ Arquitetura do Projeto
O projeto segue o padrão **MVVM (Model-View-ViewModel)** com separação clara de responsabilidades:
* **Models**: Representação dos dados (Game).
* **Services**: Comunicação com APIs externas e Firebase.
* **Providers**: Lógica de negócio e ponte entre dados e interface.
* **Screens**: Interfaces de usuário modernas e responsivas.

---
### 🛠️ Desenho da Arquitetura (Inserir no trabalho)
[View] <--> [Providers] <--> [Services] <--> [API RAWG / Firebase]
---

## ⚙️ Como executar o projeto

1. **Pré-requisitos**: Ter o Flutter SDK instalado e configurado.
2. **Clone o repositório**:
   ```bash
   git clone [https://github.com/seu-usuario/n64_catalogo.git](https://github.com/seu-usuario/n64_catalogo.git)