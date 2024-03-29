<h3 align="center">
  <br>
  <img src="https://github.com/alecomparini-dev/MentoriaCodandoComMoa/assets/76792477/2de45eaf-a717-4f94-9793-a17c704357dd" >
  <br>
</h3>

---
## FEATURES
> Este foi uma mentoria gratuita que o Moa criou para as pessoas que participaram do grupo no whatsapp. <br>
> Créditos do MOA: [![](https://img.shields.io/badge/YouTube-FF0000?style=for-the-badge&logo=youtube&logoColor=white)](https://www.youtube.com/@CodandoComMoa) [![](https://img.shields.io/badge/Instagram-E4405F?style=for-the-badge&logo=instagram&logoColor=white)](https://www.instagram.com/codandocommoa) [![](https://img.shields.io/badge/LinkedIn-0077B5?style=for-the-badge&logo=linkedin&logoColor=white)](https://www.linkedin.com/in/moacirlamego/)


### Seguem os requisitos:
  
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
  - KeyChain para armazenar o email quando usuário opta por lembrar email.
  - CoreData para gravar os agendamentos localmente
  - NetworkSDK (usando URLSession) para as chamadas remotas
  - Foi utilizado o arquivo Env para armazenar as url base do backEnd e ID do Tema utilizado
  - Além do módulo de DesignSystemSDK, também foi usado 2 SDK para simular equipes distintas desenvolvendo o APP
    - ***ProfileSDK***: Seria uma squad responsável por toda parte de cadastros dos dados básicos e endereço do perfil do usuário, cadastro de email/senha para autenticação, cadastro da biometria, ou seja toda parte responsável pelo perfil do usuário
    - ***HomeSDK***: Seria outra squad responsável pelo core da aplicação: todo os cadastros dos serviços e dos agendamentos dos serviços.
    - Ambos os SDK`s estão no mesmo repo e foram adicionados diretamente no projeto Mentoria
    - OS Demais SDK`s utilizados foram baixados como dependências, conforme descrito abaixo:

#### DEPENDÊNCIAS: 
- SDKs PRÓPRIOS:
  - **DesignSystemSDK** ( [veja aqui](https://github.com/alecomparini-dev/DesignerSystemSDK) )
  - **CustomComponentsSDK** ( [veja aqui](https://github.com/alecomparini-dev/CustomComponentsSDK/tree/develop/Sources/CustomComponents/Components) )
  - **DataStorageSDK** ( [veja aqui](https://github.com/alecomparini-dev/DataStorageSDK) )
  - **NetworkSDK** ( [veja aqui](https://github.com/alecomparini-dev/NetworkSDK) )
      > Foi utilizado para este projeto o URLSession, apesar do SDK estar preparado para trabalhar com outros, como por exemplo Alamofire, sem ter nenhum impacto no app principal.
  - **ValidatorSDK** ( [veja aqui](https://github.com/alecomparini-dev/ValidatorSDK) )
      > Atualmente possui CPF/CNPJ validator, EmailValidator e PasswordComplexityValidator
    
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
- Facade
- Repository

#### TESTE UNITÁRIOS
- Não foram feitos testes unitários para este projeto. Exemplo de testes unitários [aqui](https://github.com/alecomparini-dev/Hangman)

#### OUTROS
- Depedency Injection
- Princípios do SOLID
- Clean Code (em estudo)

