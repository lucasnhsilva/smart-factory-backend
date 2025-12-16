import { Module } from '@nestjs/common';
import { FactoryNodeService } from './factory-node.service';
import { FactoryNodeController } from './factory-node.controller';
import { FactoryNodeRepository } from './repositories/factory-node.repository';
import { FactoryNodeBaseRepository } from './repositories/factory-node-base.repository';

@Module({
  controllers: [FactoryNodeController],
  providers: [
    FactoryNodeService,
    { provide: FactoryNodeBaseRepository, useClass: FactoryNodeRepository },
  ],
})
export class FactoryNodeModule {}
