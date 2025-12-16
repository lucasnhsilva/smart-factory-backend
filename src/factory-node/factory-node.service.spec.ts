import { Test, TestingModule } from '@nestjs/testing';
import { FactoryNodeService } from './factory-node.service';

describe('FactoryNodeService', () => {
  let service: FactoryNodeService;

  beforeEach(async () => {
    const module: TestingModule = await Test.createTestingModule({
      providers: [FactoryNodeService],
    }).compile();

    service = module.get<FactoryNodeService>(FactoryNodeService);
  });

  it('should be defined', () => {
    expect(service).toBeDefined();
  });
});
