<h3 align="center">
  <br>
  <img src="https://github.com/alecomparini-dev/MentoriaCodandoComMoa/assets/76792477/2de45eaf-a717-4f94-9793-a17c704357dd" >
  <br>
</h3>

## FEATURES
> Este foi uma mentoria gratuita que o Moa criou para as pessoas que participaram do grupo no whatsapp. <br>
> Créditos do MOA: [![](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@CodandoComMoa) [![](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/codandocommoa) <br>

- Seguem os requisitos:
  
#### # Módulo Design System:
- [x] Criar um módulo específico para o Design System
- [x] O tema deve ser recebido pelo backend(criado pelo MOA)

#### # Telas SignIn e SignUp:
- [x] Criar perfil do usuário(Email e Senha).
- [x] Opção de gravar localmente o email(usuário)
- [x] Autenticar usuário (foi usado o Firebase Auth)
- [x] Caso o device aceitar biometria, permitir autenticar com biometria
- [x] Recuperar senha
- [x] Validar dados (email, senha e confirmação de senha)

#### # Telas Profile:
- [x] Step 1:
  - [x] Cadastro dos dados básicos
  - [x] Cadastrar foto do perfil
- [x] Step 2:
  - [x] Cadastro do endereço
  - [x] Pesquisa de CEP
- [x] Validação dos dados: email, CPF, telefone, data de nascimento
- [x] Máscaras: telefone, email, data, CPF e CEP
- [x] Salvar no Backend

#### # Tela Services:
- [x] Listar os Serviços
  - [x] Filtrar Serviços
- [x] BottomSheet para visualização dos detalhes do serviço
- [x] Tela de Criar / Editar / Deletar serviço
- [x] Salvar no Backend

#### # Tela Schedule:
- [x] Listar os Agendamentos
  - [ ] Filtrar Agendamentos
- [x] Tela Criar Agendamento
  - [x] Listar Serviços
  - [x] Listar Clientes
- [ ] Tela Editar e Deletar agendamento
- [x] Salvar localmente (não deu tempo da API do Backend ficar pronta)

---
## PREVIEW APP

<br>

https://github.com/alecomparini-dev/MentoriaCodandoComMoa/assets/76792477/8debd234-709f-47d6-bce4-77738a3e92f4

<br>

---
## DESENVOLVIMENTO
- Neste projeto foi utilizado:
  - UserDefaults para gravar as moedas favoritas
  - URLSession para as chamadas remotas
  - Foi utilizado o arquivo Env para armazenar a url base e a chave da API ***(Estou ciente que esta informação deverá ficar na esteira de deploy)***
  - Também foi utilizado os arquivos Localizable.strings para inglês -> português
- Não foi criado módulos para este projeto, foi utilizado um único target, porém foi separado os diretórios para seguir o padrão do clean architecture.

#### DEPENDÊNCIAS: 
- SDKs PRÓPRIOS:
  - **CustomComponentsSDK** ( [veja aqui](https://github.com/alecomparini-dev/CustomComponentsSDK/tree/develop/Sources/CustomComponents/Components) )
    > Responsável por todos os componentes visuais utilizados na camada de UI dos meus Projetos.
  - **DataStorageSDK** ( [veja aqui](https://github.com/alecomparini-dev/DataStorageSDK) )

  
- #### SDKs TERCEIROS:
  - Firebase
 
- #### Gerenciador de Dependência:
  - SPM(Swift Package Manager)

#### ARQUITETURA
- MVVM-C
- Clean Architecture

#### PATTERNS (em estudo)
- Strategy
- Builder
- Factory
- Adapter
- Repository

#### TESTE UNITÁRIOS
- Ainda não foram criados os testes unitários

#### OUTROS
- Depedency Injection
- Princípios do SOLID
- Clean Code (em estudo)

