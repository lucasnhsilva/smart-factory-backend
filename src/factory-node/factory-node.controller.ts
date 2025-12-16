import { Controller, Get, Post, Body, Patch, Param, Delete } from '@nestjs/common';
import { FactoryNodeService } from './factory-node.service';
import { CreateFactoryNodeDto } from './dto/create-factory-node.dto';
import { UpdateFactoryNodeDto } from './dto/update-factory-node.dto';

@Controller('factory-node')
export class FactoryNodeController {
  constructor(private readonly factoryNodeService: FactoryNodeService) {}

  @Post()
  create(@Body() createFactoryNodeDto: CreateFactoryNodeDto) {
    return this.factoryNodeService.create(createFactoryNodeDto);
  }

  @Get()
  findAll() {
    return this.factoryNodeService.findAll();
  }

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.factoryNodeService.findOne(+id);
  }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateFactoryNodeDto: UpdateFactoryNodeDto) {
    return this.factoryNodeService.update(+id, updateFactoryNodeDto);
  }

  @Delete(':id')
  remove(@Param('id') id: string) {
    return this.factoryNodeService.remove(+id);
  }
}
