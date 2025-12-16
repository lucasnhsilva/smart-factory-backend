import { Test, TestingModule } from '@nestjs/testing';
import { FactoryNodeController } from './factory-node.controller';
import { FactoryNodeService } from './factory-node.service';

describe('FactoryNodeController', () => {
  let controller: FactoryNodeController;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      controllers: [FactoryNodeController],
      providers: [FactoryNodeService],
    }).compile();

    controller = module.get<FactoryNodeController>(FactoryNodeController);
  });

  it('should be defined', () => {
    expect(controller).toBeDefined();
  });
});
