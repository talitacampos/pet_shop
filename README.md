# Pet Shop

Este é uma pequena aplicação em Rails que gera dados aleatórios de 1000 cachorros e os apresenta em uma listagem com filtros.

Para construção do mesmo foi utilizado Rails (5.0.3), Bootstrap e AngularJS.

## Configuração

Para esta aplicação, é necessário que o bower esteja instalado na sua máquina. Caso não o tenha, instale-o usando:
```bash
$ npm install -g bower
```

Em seguida, clone o projeto e, de dentro do diretório em que foi feito o clone, execute os seguintes comandos:
```bash
$ bundle install
$ rake -T bower
$ rake bower:install
```

Também é necessário rodar as migrations com:
```bash
$ rails db:migrate/
```

Feito assim, você já pode rodar a aplicação com:
```bash
$ rails s
```

Com a aplicação rodando, já é possível acessar a tela com a listagem de cachorros em http://localhost:3000. Entretanto, a listagem estará vazia.

Para gerar os dados dos cachorros é necessário acessar a url http://localhost:3000/populate/dogs. Ao fim do carregamento, você poderá retornar à url da listagem e atualizá-la obtendo os dados gerados.

## Testes

Para rodar os testes, execute de dentro do diretório raiz:
```bash
$ rails test
```
