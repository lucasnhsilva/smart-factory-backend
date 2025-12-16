import { Injectable } from '@nestjs/common';
import { CreateFactoryNodeDto } from './dto/create-factory-node.dto';
import { UpdateFactoryNodeDto } from './dto/update-factory-node.dto';
import { FactoryNodeBaseRepository } from './repositories/factory-node-base.repository';

@Injectable()
export class FactoryNodeService {
  constructor(private readonly repository: FactoryNodeBaseRepository) {}
  create(createFactoryNodeDto: CreateFactoryNodeDto) {
    return 'This action adds a new factoryNode';
  }

  findAll() {
    return this.repository.findAll();
  }

  findOne(id: number) {
    return `This action returns a #${id} factoryNode`;
  }

  update(id: number, updateFactoryNodeDto: UpdateFactoryNodeDto) {
    return `This action updates a #${id} factoryNode`;
  }

  remove(id: number) {
    return `This action removes a #${id} factoryNode`;
  }
}
