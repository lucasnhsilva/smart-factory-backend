// prisma/seed.ts
import { PrismaClient, NodeType } from '../src/generated/prisma/client';
import { PrismaPg } from '@prisma/adapter-pg';
const adapter = new PrismaPg({ connectionString: process.env.DATABASE_URL });
const prisma = new PrismaClient({ adapter });

async function main() {
  console.log('🌱 Começando o Seed...');

  // 1. Limpar banco (opcional, cuidado em prod)
  await prisma.tag.deleteMany();
  await prisma.equipment.deleteMany();
  await prisma.factoryNode.deleteMany();

  // 2. Criar Enterprise
  const enterprise = await prisma.factoryNode.create({
    data: { name: 'Solium Tech Indústria', type: NodeType.ENTERPRISE },
  });

  // 3. Criar Site (Unidade SP)
  const siteSP = await prisma.factoryNode.create({
    data: {
      name: 'Unidade São Paulo',
      type: NodeType.SITE,
      parentId: enterprise.id,
    },
  });

  // 4. Criar Área (Produção)
  const areaProducao = await prisma.factoryNode.create({
    data: { name: 'Área de Envase', type: NodeType.AREA, parentId: siteSP.id },
  });

  // 5. Criar Linha
  const linha1 = await prisma.factoryNode.create({
    data: { name: 'Linha 01', type: NodeType.LINE, parentId: areaProducao.id },
  });

  // 6. Criar Equipamento (Workcell)
  const envasadora = await prisma.equipment.create({
    data: {
      name: 'Envasadora Rotativa Alpha',
      node: {
        create: {
          name: 'Célula Envasadora',
          type: NodeType.WORKCELL,
          parentId: linha1.id,
        },
      },
    },
  });

  // 7. Criar Tags
  await prisma.tag.createMany({
    data: [
      {
        name: 'Temperatura_Tanque',
        equipmentId: envasadora.id,
        unsPath: 'Solium/SP/Envase/L1/Envasadora/Temp',
        dataType: 'float',
      },
      {
        name: 'Velocidade_Motor',
        equipmentId: envasadora.id,
        unsPath: 'Solium/SP/Envase/L1/Envasadora/Velocidade',
        dataType: 'int',
      },
      {
        name: 'Status_Running',
        equipmentId: envasadora.id,
        unsPath: 'Solium/SP/Envase/L1/Envasadora/Status',
        dataType: 'boolean',
      },
    ],
  });

  console.log('✅ Fábrica fictícia criada com sucesso!');
}

main()
  .catch((e) => console.error(e))
  .finally(async () => await prisma.$disconnect());
