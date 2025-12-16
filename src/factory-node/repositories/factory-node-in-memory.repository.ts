import { FactoryNodeBaseRepository } from './factory-node-base.repository';

export class FactoryNodeInMemoryRepository
  implements FactoryNodeBaseRepository
{
  private readonly database: Map<string | number, any>;
  constructor() {
    this.database = new Map();
  }
  findAll(): Promise<any> | any[] {
    return Array.from(this.database.values());
  }
}
