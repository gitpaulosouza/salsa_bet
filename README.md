
## Como rodar o projeto

### 1. Clone o projeto:
  - https://github.com/gitpaulosouza/salsa_bet
  - cd salsa_challenge

### 2. Instale as dependências:
  - flutter pub get

### 3. Rode o build_runner para MobX:
  - flutter pub run build_runner build --delete-conflicting-outputs
# Salsa Challenge - Flutter  

<img src="https://salsatechnology.com/wp-content/uploads/2023/06/Salsa_technology.png" alt="Salsa Technology" width="300"/>

Desafio técnico desenvolvido para a **Salsa Technology**.  
O projeto implementa autenticação mockada, gerenciamento de estado com **MobX**, navegação com **GoRouter**, persistência local com **Hive** e **SharedPreferences**, além de **WebView** com comunicação Flutter ↔️ JavaScript.   

---

## 🚀 Funcionalidades  

- 🔑 **Login mockado** (usuário: `salsa`, senha: `salsa`)  
- 🏠 **Home** com listagem de itens mockados e favoritos persistidos  
- ❤️ **Favoritar/Desfavoritar** itens com persistência no Hive  
- 🎨 **Tema Light/Dark** persistido com SharedPreferences  
- ⚙️ **Tela de Configurações** com troca de tema e logout  
- 🌐 **WebView Local** carregando HTML mockado e comunicação com Flutter  

---

## 🛠️ Stack Utilizada  

- **Flutter** `3.32.4`  
- **MobX** para gerenciamento de estado  
- **GetIt** para injeção de dependências  
- **Hive** + **SharedPreferences** para persistência de dados
- **GoRouter** para navegação  
- **WebView Flutter** para integração com HTML/JS  

---

## 📂 Estrutura de Pastas  

```bash
lib/
├── core/         
├── models/        
├── services/      
├── stores/        
├── ui/            
│   ├── home/
│   ├── login/
│   ├── settings/
│   └── webview/
└── main.dart
assets/
├── icons/
├── images/
└── html/
