# Controle de Estoque - Passo a passo (bem simples)

## 1. Descompacte esta pasta
Descompacte o `.zip` em algum lugar do seu computador. Você deve ver:

```
controle_estoque/
├── lib/
├── web/
├── pubspec.yaml
```

## 2. Coloque os arquivos do professor
Copie `sqlite3.wasm` e `sqflite_sw.js` (que o professor te deu) para
dentro da pasta `web/`. Deve ficar assim:

```
web/
├── index.html
├── sqlite3.wasm
└── sqflite_sw.js
```

## 3. Abra o terminal dentro da pasta do projeto
No VS Code, por exemplo: botão direito na pasta > "Abrir no terminal".

## 4. Baixe as dependências
```
flutter pub get
```

## 5. Rode o projeto no Chrome, na porta 8080
```
flutter run -d chrome --web-port 8080
```

## 6. Teste tudo
1. Clique em "CRIAR CONTA", cadastre um usuário (ex: Maria / maria@email.com / 1234).
2. Faça login com esse e-mail e senha.
3. Cadastre alguns produtos (deixe um com quantidade <= 3 para ver o "ESTOQUE BAIXO").
4. Use os botões [-] e [+] para mudar a quantidade.
5. Exclua um produto e veja ele sumir da lista.
6. Aperte F5 (recarregar a página) e faça login de novo — os dados
   continuam salvos, porque estão no SQLite, não na memória.
7. Fique de olho no terminal: cada ação (INSERT, SELECT, UPDATE,
   DELETE) aparece impressa lá, para você conferir se está
   realmente mexendo no banco.

## Como o projeto está organizado

- `lib/models/` → só as "fichas" de Usuario e Produto (não mexem no banco).
- `lib/services/` → é quem realmente fala com o SQLite (INSERT, SELECT, UPDATE, DELETE).
- `lib/providers/` → fica no meio do caminho: a tela pede pro provider,
  o provider pede pro service, o service mexe no banco.
- `lib/pages/` → as telas (login, cadastro, home, cadastro de produto, estoque).

Fluxo de uma ação, por exemplo o login:

```
Tela (login_page.dart)
      ↓
Provider (usuario_provider.dart)
      ↓
Service (usuario_service.dart)
      ↓
SQLite (banco_dados.dart)
```

## Dúvida comum
Se der erro tipo "sqlite3.wasm not found" ou a tela ficar branca,
quase sempre é porque os arquivos `sqlite3.wasm` / `sqflite_sw.js`
não foram colocados dentro da pasta `web/`, ou o projeto não foi
aberto na porta 8080.
