# README

Desafio proposto pela empresa Switch Dreams em seu desafio backend.
- https://github.com/switchDreams/back-end-challenge/

## Projeto
- Versão do Ruby: 3.0.0
- Versão do Rails: 6.0.4
- Banco de Dados: PostgreSQL
- Testes Automatizados: Rspec
- Linter: Rubocop
- Modelagem do Banco de Dados: https://dbdiagram.io/d/629684c854ce26352736a5b9
- Link do Deploy no Heroku: https://ancient-harbor-34285.herokuapp.com/

## Execução do Projeto Localmente
- Iniciando o banco de dados
  - rails:db create
  - rails:db migrate
  - rails:db seed
- Ligando o servidor na porta padrão (3000)
  - bundle install
  - rails s

## Rotas

### Category
- get '/category'
- get '/category/show/:id'
- post '/category/create'
  - Necessário logar como professor ou admin  
- patch '/category/update/:id'
  - Necessário logar como professor ou admin  
- delete '/category/delete/:id'
  - Necessário logar como professor ou admin 

### Lesson
- get '/lesson'
- get '/lesson/show/:id'
- post '/lesson/create'
  - Necessário logar como professor ou admin  
- patch '/lesson/update/:id'
  - Necessário logar como professor ou admin  
- delete '/lesson/delete/:id'
  - Necessário logar como professor ou admin  

### User
- post '/signup'
- post '/login'
- get '/logout'
  - Necessário estar logar
- post '/change_role'
  - Necessário logar como admin  
- post '/enroll'
  - Necessário estar logado
- post '/unenroll'
  - Necessário estar logado

## Observações
- Para acessar métodos que necessitam de um usuário logado (aluno, professor ou admin), é necessário enviar ho header da requisição o token do usuário (X-User-Token) e o email do usuário (X-User-Email). O token pode ser obtido no método de login. Para mais informações, consulte os testes de requisição do usuário.
- O método de logout exclui o token do usuário o que força a criação de um novo token quando o usuário loga novamente. Caso a API seja utilizada com algum front, seria equivalente a deslogar de todos os despositivos.
- Adicionei algumas mudanças no rubocop que achei conveniente como ignorar alguns arquivos de configuração e aumentar 2 linhas o tamanho máximo que um método pode ter. Pessoalmente eu acho 10 pouco demais.
- O seed já vem com um admin pré-criado. Para utilizá-lo, basta usar o seguinte email e senha:
  - admin@mail.com
  - 123456

## Problema

A academia Fit Dreams possui uma grande versatilidade de aulas em seu cronograma, sendo que as atividades variam a cada mês. A Fit Dreams acaba de te contratar para desenvolver um sistema que organizará a disponibilidade de cada aula.

A aula poderá conter os campos: nome, horário de início, duração, nome do professor e descrição.

Como as aulas são variadas, decidiu-se inserir um sistema de categorias para melhor organização. Cada categoria terá um nome e descrição.

O administrador e o professor têm autorização total de criação, edição e deleção de qualquer categoria e aula, porém ambos os resursos não podem ser alteradas por um aluno da academia.

O sistema deve permitir também que exista um sistema de usuários, sendo que os usuários são divididos entre alunos, professores e administradores. O usuário deve ter nome, data de nascimento, email, senha e a sua respectiva role (aluno, professor ou admin).

Um usuário também pode estar matriculado em diversas aulas e uma aula pode ter diversos alunos matriculados.
