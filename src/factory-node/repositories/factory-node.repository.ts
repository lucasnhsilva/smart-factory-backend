import { DatabaseService } from '@/database/database.service';
import { Injectable } from '@nestjs/common';
import { FactoryNodeBaseRepository } from './factory-node-base.repository';

@Injectable()
export class FactoryNodeRepository implements FactoryNodeBaseRepository {
  constructor(private readonly database: DatabaseService) {}
  findAll() {
    return this.database.factoryNode.findMany({
      where: { parentId: null }, // Começa da raiz (Enterprise)
      include: {
        children: {
          // Nível Site
          include: {
            children: {
              // Nível Area
              include: {
                children: {
                  // Nível Line
                  include: {
                    children: true, // Nível Workcell
                  },
                },
              },
            },
          },
        },
      },
    });
  }
}
