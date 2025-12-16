import { PartialType } from '@nestjs/mapped-types';
import { CreateFactoryNodeDto } from './create-factory-node.dto';

export class UpdateFactoryNodeDto extends PartialType(CreateFactoryNodeDto) {}
