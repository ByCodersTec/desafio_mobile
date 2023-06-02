# Desafio programação - para vaga desenvolvedor Mobile
Por favor leiam este documento do começo ao fim, com muita atenção.
O intuito deste teste é avaliar seus conhecimentos técnicos em desenvolvimento mobile.
Este desafio deve ser feito por você em sua casa. Gaste o tempo que você quiser, porém normalmente você não deve precisar de mais do que algumas horas para finalizar.

# Instruções de entrega do desafio

1. Primeiro, faça um fork deste projeto para sua conta no Github (crie uma se você não possuir).
2. Em seguida, implemente o projeto,tal qual descrito abaixo, utilizando sua linguagem de programação mobile preferida em seu clone local.
3. Por fim, envie via email o projeto ou o fork/link do projeto para seu contato bycoders_.

# Descrição do projeto

1. Tela de login usando (email e senha);
2. Tela home com mapa renderizando um ponto na localização atual do device;
3. Realizar o login utilizando Firebase Auth;
4. Armazenar os dados do usuário na store global;
5. Rastrear login com sucesso e renderização com sucesso com Analytics (enviar um evento com dados considerados primordiais nesses dois casos);
6. Rastrear os erros e envia-los ao Crashlytics;
7. Armazenar na base de dados local (preferência por WatermelonDB, mas pode usar outro banco de dados) o usuário logado e sua última posição no mapa;
8. Testar fluxo de login (unit e e2e);
9. Testar fluxo da home (unit e e2e).

# Avaliação

Seu projeto será avaliado de acordo com os seguintes critérios.

1. Sua aplicação preenche os requerimentos básicos?
2. Você documentou a maneira de configurar o ambiente e rodar sua aplicação?
3. Você seguiu as instruções de envio do desafio?
4. Qualidade e cobertura dos testes unitários.

Adicionalmente, tentaremos verificar a sua familiarização com as bibliotecas padrões (standard libs), bem como sua experiência com programação orientada a objetos a partir da estrutura de seu projeto.

================================================|||||======================================================================

# Projeto ByCoders

Este projeto apresenta uma solução completa para a visualização de um mapa, implementando funcionalidades como login, autenticação, localização e rastreamento de usuários. Utilizando uma série de técnicas e bibliotecas modernas, o projeto segue uma estrutura modular e utiliza uma variedade de padrões de projeto.

## Screens:
   <img src="https://github.com/ByCodersTec/desafio_mobile/blob/db38bfacd9066b3fd706b374771b51eaaa59e4dc/app/src/main/res/drawable/bycoders_1.png"  width="200"/>
   <img src="https://github.com/ByCodersTec/desafio_mobile/blob/db38bfacd9066b3fd706b374771b51eaaa59e4dc/app/src/main/res/drawable/bycoders_2.png"  width="200"/>
   <img src="https://github.com/ByCodersTec/desafio_mobile/blob/db38bfacd9066b3fd706b374771b51eaaa59e4dc/app/src/main/res/drawable/bycoders_3.png"  width="200"/>
   <img src="https://github.com/ByCodersTec/desafio_mobile/blob/db38bfacd9066b3fd706b374771b51eaaa59e4dc/app/src/main/res/drawable/bycoders_4.png"  width="200"/>
   <img src="https://github.com/ByCodersTec/desafio_mobile/blob/db38bfacd9066b3fd706b374771b51eaaa59e4dc/app/src/main/res/drawable/bycoders_5.png"  width="200"/>
   <img src="https://github.com/ByCodersTec/desafio_mobile/blob/db38bfacd9066b3fd706b374771b51eaaa59e4dc/app/src/main/res/drawable/bycoders_6.png"  width="200"/>
   <img src="https://github.com/ByCodersTec/desafio_mobile/blob/db38bfacd9066b3fd706b374771b51eaaa59e4dc/app/src/main/res/drawable/bycoders_7.png"  width="200"/>
   <img src="https://github.com/ByCodersTec/desafio_mobile/blob/db38bfacd9066b3fd706b374771b51eaaa59e4dc/app/src/main/res/drawable/bycoders_8.png"  width="200"/>
   <img src="https://github.com/ByCodersTec/desafio_mobile/blob/db38bfacd9066b3fd706b374771b51eaaa59e4dc/app/src/main/res/drawable/bycoders_9.png"  width="200"/>

##Bibliotecas Utilizadas

##Gerais
- Compose UI
- Room
- Koin Android
- Koin Core JVM
- Koin Test JVM
- Firebase Auth, Analytics, Crashlytics
- Google Maps
- Detekt

##Testes de Unidade
- Junit: 4.13.2
- MockK: 1.13.5
- Kotlinx Coroutines Test: 1.7.1
- Turbine: 0.13.0
- Robolectric: 4.6.1
- Google Truth: 1.1.3
- AssertJ Core: 3.20.2
- Testes Instrumentados
- AndroidX Test ext junit: 1.1.5
- Espresso Core: 3.5.1
- AndroidX Test ext truth: 1.5.0
- AndroidX Test runner: 1.5.2
- AndroidX Test rules: 1.5.0
- Compose UI test junit4: 1.4.3
- Koin Test: 3.4.0
- MockK Android: 1.13.5
- MockK Agent: 1.13.5
- Compose UI Test Manifest: 1.4.3

## Recursos

- Arquitetura limpa com abstrações para Firebase, Networking e Navigator
- Injeção de Dependência com Koin
- Integração com Firebase Auth, Analytics e Crashlytics
- Persistência de dados com Room
- Integração com Google Maps
- Padrões de Projeto Usecase e Repository
- Estratégia de Single Activity para Composables
- Análise Estática de Código com Detekt

## Arquitetura e Módulos

O projeto segue os princípios de Clean Architecture, com abstrações para Firebase, Networking e Navigator, e é dividido em vários módulos claros, otimizando a manutenção e escalabilidade. As features implementadas incluem:

- Login: provê funcionalidades de autenticação de usuários.
- Home: exibe o mapa com informações de localização e permite a interação com marcadores.

Os módulos do projeto incluem:

- `firebase`: abstrai a integração com Firebase Auth, Firebase Analytics e Firebase Crashlytics.
- `networking`: proporciona o gerenciamento de chamadas de rede.
- `navigator`: responsável pelo gerenciamento de navegação no aplicativo.
- `database`: contém a abstração do banco de dados com Room.
- `features`: inclui as funcionalidades específicas de cada feature do projeto.

## Testes

Dedicamos uma atenção especial à qualidade do software, implementando testes de unidade e testes instrumentados para todas as funcionalidades do aplicativo, garantindo sua correta funcionalidade e confiabilidade.

## Próximos Passos e Melhorias

Estamos sempre buscando melhorar e expandir o projeto. Alguns dos nossos planos futuros incluem:

- Melhorar a cobertura de testes
- Implementar novas features
- Aprimorar a usabilidade e a experiência do usuário
- Continuar otimizando a manutenibilidade e escalabilidade do projeto

## Instalação

Para instalar e executar o aplicativo no Android Studio, siga estas etapas:

1. Clone o repositório ou baixe os arquivos zip do projeto.
2. Abra o Android Studio e clique em "Open an existing Android Studio project".
3. Navegue até a pasta do projeto e selecione a pasta raiz.
4. Aguarde o Android Studio sincronizar e construir o projeto.
5. Execute o aplicativo em um emulador ou dispositivo Android conectado.

## Contato

Se você tiver dúvidas ou sugestões, sinta-se à vontade para entrar em contato:

- Nome: Leonardo Oliveira da Cruz
- E-mail: [leonardo_cruz09@hotmail.com]
- LinkedIn: [https://www.linkedin.com/in/leonardo-oliveira-da-cruz-8566a530/]
