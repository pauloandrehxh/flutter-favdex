# 🗺️ Plano de Desenvolvimento: FavDex

**Descrição:** Um aplicativo em Flutter para buscar, visualizar detalhes e favoritar Pokémon consumindo a PokeAPI.
**Stack Técnica:** Flutter, GetX (Estado, Rotas e Injeção de Dependências), `http` (Requisições), `get_storage` (Armazenamento Local), `cached_network_image` (Cache de Imagens).
**Objetivo:** Construir o projeto de forma incremental, garantindo commits atômicos e uma documentação evolutiva no GitHub.

---

## 🎯 Fase 1: Fundação e Estrutura Inicial
*O objetivo desta fase é configurar o ambiente, organizar a arquitetura de pastas e preparar o repositório.*

- [ ] Inicializar o projeto Flutter (`flutter create favdex`).
- [ ] Limpar o `main.dart` removendo o código do contador padrão.
- [ ] Adicionar as dependências no `pubspec.yaml`: `get`, `http`, `get_storage`, `cached_network_image`.
- [ ] Criar a estrutura base de pastas dentro de `lib/`:
  - `data/` (models e providers)
  - `modules/` (home, details, favorites)
  - `core/` (theme, utils)
- [ ] Configurar o `GetMaterialApp` no `main.dart` e inicializar o `GetStorage`.
- [ ] **Documentação:** Criar o `README.md` inicial com o título do projeto, descrição curta e as tecnologias escolhidas.
- [ ] **Commit sugerido:** `chore: setup inicial do projeto e estrutura de pastas com GetX`

## 🧠 Fase 2: Camada de Dados e Modelagem
*Foco na comunicação com a PokeAPI e na tradução do JSON para objetos Dart.*

- [ ] Criar o modelo `PokemonModel` contendo campos básicos (id, nome, url da imagem, tipos).
- [ ] Criar uma classe `PokeApiProvider` em `data/providers/` contendo o método base usando o pacote `http` para fazer o `GET` em `https://pokeapi.co/api/v2/pokemon`.
- [ ] Testar a requisição imprimindo o resultado no terminal.
- [ ] **Documentação:** Atualizar o README com a seção "Como rodar o projeto".
- [ ] **Commit sugerido:** `feat: adiciona PokemonModel e provider de integracao com PokeAPI`

## 🔍 Fase 3: Tela de Busca (Home)
*Construção da interface principal e implementação da lógica de estado reativo.*

- [ ] Criar a interface visual `HomeView` com um `TextField` de busca no topo e um `GridView` ou `ListView` abaixo.
- [ ] Criar o `HomeController` (GetX) para gerenciar o estado da tela (Carregando, Sucesso, Erro).
- [ ] Implementar a lógica de paginação (carregar 20 Pokémon ao chegar no fim da lista).
- [ ] Implementar o método de busca consumindo o endpoint específico de pesquisa da API.
- [ ] Adicionar o **Debounce** no `HomeController` para evitar requisições excessivas enquanto o usuário digita.
- [ ] Usar o `cached_network_image` para renderizar as miniaturas dos Pokémon nos cards.
- [ ] **Documentação:** Adicionar um print da tela inicial funcionando no README.
- [ ] **Commit sugerido:** `feat: implementa HomeView com listagem, busca reativa e debounce`

## 📖 Fase 4: Tela de Detalhes e Navegação
*Explorar o sistema de rotas do GetX e passagem de parâmetros.*

- [ ] Criar a `DetailsView` e o `DetailsController`.
- [ ] Configurar a rota usando `Get.to()` no evento de clique do card na `HomeView`, passando o `PokemonModel` ou o `ID` como argumento.
- [ ] Fazer uma nova requisição na API dentro do `DetailsController` para buscar dados profundos (altura, peso, habilidades, base stats).
- [ ] Montar a UI da tela de detalhes exibindo as novas informações (usar barras de progresso ou grids para os stats).
- [ ] **Documentação:** Adicionar um print da tela de detalhes no README.
- [ ] **Commit sugerido:** `feat: adiciona DetailsView e roteamento dinamico com GetX`

## ⭐ Fase 5: Sistema de Favoritos (Local Storage)
*Implementação da persistência de dados offline.*

- [ ] Criar o `FavoritesController` para gerenciar a lista de favoritos.
- [ ] Implementar as funções de `salvarPokemon` e `removerPokemon` utilizando o `get_storage`.
- [ ] Adicionar um botão de "Coração" (favoritar/desfavoritar) na `DetailsView` (e opcionalmente na `HomeView`), alterando a cor de forma reativa (`Obx()`).
- [ ] Criar a interface `FavoritesView` que lê os dados salvos no `get_storage` e exibe a lista offline.
- [ ] Adicionar uma BottomNavigationBar ou um Drawer na `HomeView` para poder navegar até a `FavoritesView`.
- [ ] **Documentação:** Atualizar o README explicando como a persistência de dados foi implementada.
- [ ] **Commit sugerido:** `feat: integra get_storage e implementa gerenciamento de favoritos offline`

## 💅 Fase 6: Polimento e Conclusão
*Revisão de código, tratamento de erros e refinamento final do portfólio.*

- [ ] Adicionar tratamento de erros visuais (ex: SnackBars do GetX caso a internet caia durante a busca).
- [ ] Refatorar trechos de código repetidos para Widgets customizados (componentização).
- [ ] Testar o app no modo Release e verificar a performance da listagem.
- [ ] **Documentação:** Finalizar o `README.md` adicionando um GIF do app em funcionamento, uma seção com os "Desafios Encontrados e Soluções", e links para seu perfil/contato.
- [ ] **Commit sugerido:** `refactor: polimento de UI, tratamento de excecoes e atualizacao final da documentacao`