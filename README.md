# Smart Factory Industrial Insights — Backend (NestJS)

API backend do projeto **Smart Factory Industrial Insights**, responsável por gerenciar dados de máquinas, ordens de produção, eventos, alarmes e cálculos de eficiência (OEE/TRS), além de integrar-se a um microserviço Python para predição de falhas.

## Tecnologias Principais

| Categoria           | Ferramenta                                                   | Função                                         |
| ------------------- | ------------------------------------------------------------ | ---------------------------------------------- |
| **Framework**       | [NestJS](https://nestjs.com)                                 | Backend modular e escalável                    |
| **ORM**             | [Prisma](https://www.prisma.io)                              | ORM moderno                                    |
| **Banco de Dados**  | [Postgres + TimescaleDB Plugin](https://www.postgresql.org/) | Armazenamento relacional e séries temporais    |
| **Logs**            | [Winston](https://github.com/winstonjs/winston)              | Logging estruturado                            |
| **Documentação**    | [Swagger](https://swagger.io)                                | API Docs automática                            |
| **Arquitetura**     | Clean Architecture                                           | Separação clara de camadas e responsabilidades |
| **Containerização** | [Docker](https://www.docker.com)                             | Ambiente isolado e replicável                  |
