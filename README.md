# Smart Factory Industrial Insights — Backend (NestJS)

API backend do projeto **Smart Factory Industrial Insights**, responsável por gerenciar dados de máquinas, ordens de produção, eventos, alarmes e cálculos de eficiência (OEE/TRS), além de integrar-se a um microserviço Python para predição de falhas.

## Tecnologias Principais

| Categoria           | Ferramenta                                                   | Função                           |
| ------------------- | ------------------------------------------------------------ | -------------------------------- |
| **Framework**       | [NestJS](https://nestjs.com)                                 | Backend modular e escalável      |
| **ORM**             | [Prisma](https://www.prisma.io)                              | ORM moderno                      |
| **Banco de Dados**  | [MSSQL](https://www.microsoft.com/pt-br/sql-server)          | Armazenamento relacional         |
| **Cache / Filas**   | [Redis](https://redis.io) + [BullMQ](https://docs.bullmq.io) | Cache de KPIs e filas de alarmes |
| **Logs**            | [Winston](https://github.com/winstonjs/winston)              | Logging estruturado              |
| **Documentação**    | [Swagger](https://swagger.io)                                | API Docs automática              |
| **Arquitetura**     | Clean Architecture + DDD                                     | Separação clara de camadas       |
| **Containerização** | [Docker](https://www.docker.com)                             | Ambiente isolado e replicável    |
