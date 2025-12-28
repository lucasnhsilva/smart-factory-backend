import { Module } from '@nestjs/common';
import { DatabaseModule } from './database/database.module';
import { FactoryNodeModule } from './factory-node/factory-node.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    DatabaseModule,
    FactoryNodeModule,
  ],
})
export class AppModule {}
