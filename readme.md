# 📦 Estoque API Core

Uma API de gerenciamento de estoque desenvolvida em **Node.js** utilizando a arquitetura **MVC**. O grande diferencial deste projeto é a simulação de um ambiente corporativo real, integrando equipes externas e configurações de infraestrutura descentralizadas por meio de **Git Submodules** e entregas contínuas via **Trunk-Based Development**.

---

## 🛠️ Metodologia e Arquitetura

O projeto foi construído seguindo três pilares fundamentais de engenharia de software moderno:

*   **Trunk-Based Development**: Desenvolvimento focado em ciclos muito curtos. O código foi integrado diretamente na branch `main` após cada etapa, simulando um ambiente de Integração Contínua (CI) e evitando conflitos complexos de mesclagem (*merge hell*).
*   **Git Submodules**: Divisão de responsabilidades entre repositórios de forma modular. A API Core consome regras e ambientes gerenciados de forma independente.
*   **Arquitetura MVC (Model-View-Controller)**: Separação clara de responsabilidades entre as regras de negócio (Models), a lógica de controle (Controllers) e os pontos de saída de dados.

### 📐 Estrutura de Repositórios

O ecossistema final é composto por três repositórios integrados:
1.  **`estoque-api`** *(Este repositório)*: O núcleo do sistema desenvolvido em Node.js.
2.  **`estoque-contracts`**   *(Sub módulo / pasta contracts)*: Contratos globais e regras de validação do produto
3.  **`estoque-infra-config`** *(Sub módulo / pasta `config`)*: Arquivos de configuração de ambiente.

---

## 🚀 Fases do Desenvolvimento

*   **FASE 1: Construção dos Sub módulos**: Setup inicial dos repositórios isolados que simulam as entregas de equipes externas e segurança de infraestrutura.
*   **FASE 2: Setup da API Core e Injeção**: Configuração inicial do projeto Node.js e vinculação segura dos sub módulos nos caminhos corretos do diretório local.
*   **FASE 3: Ciclo MVC 1 - Entidade Usuário**: Validação do fluxo de codificação vertical em pedaços pequenos (criação de rotas, controle e modelo) integrado via Trunk-Based.
*   **FASE 4: Ciclo MVC 2 - Entidade Estoque**: Implementação da leitura física de arquivos JSON originados dos submódulos e aplicação prática de **Feature Flags** para ativar ou desativar comportamentos em tempo de execução.

---

## 🐳 Containerização (Docker + WSL)

O projeto está totalmente preparado para rodar isolado em containers utilizando o  **Docker**.

### Como Rodar o Projeto Localmente

1. **Baixe o repositório principal e inicialize os sub módulos:**
   ```bash
   git clone <link-deste-repositorio>
   cd estoque-api
   git submodule update --init --recursive
   ```

2. **Construa a imagem Docker:**
   ```bash
   docker build -t estoque-api .
   ```

3. **Inicie o container mapeando as portas:**
   ```bash
   docker run -d -p 3000:3000 --name container-estoque estoque-api
   ```

A API estará disponível em `http://localhost:3000`. Você pode acompanhar a execução em tempo real usando `docker logs -f container-estoque`.

---
## 🧪 Testes da API e Ambiente de Desenvolvimento

O desenvolvimento e os testes da aplicação foram realizados em um ambiente híbrido altamente produtivo, integrando o ecossistema Windows com o poder do terminal Linux:

*   **Ambiente de Execução**: WSL 2 (Windows Subsystem for Linux) rodando a distribuição **Ubuntu**.
*   **IDE**: **Visual Studio Code** no Windows, conectado nativamente ao WSL através da extensão *WSL Remote*, permitindo debugar o código diretamente dentro do ambiente Linux.

### Validação da Rota de Status

Para validar o funcionamento integrado do MVC, a leitura dos contratos e a Feature Flag de mensageria, foi realizada uma requisição para a rota de monitoramento.

*   **Rota**: `GET http://localhost:3000/api/estoque/status`
*   **Resultado esperado**: Retorno bem-sucedido dos dados estruturados no formato JSON.

Como demonstrado no retorno da rota de teste abaixo, o container processa a requisição perfeitamente:

#### Retorno da API (Visualização em Árvore JSON) 

```text 
▼ estoque:
 ▼ 0: sku: "PROD-1" 
 qtd: 15 
 alertas_sqs_disparados: 0 
 status_localstack: "INATIVO" 