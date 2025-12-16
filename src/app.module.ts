import { Module } from '@nestjs/common';
import { AppController } from './app.controller';
import { AppService } from './app.service';
import { DatabaseModule } from './database/database.module';
import { FactoryNodeModule } from './factory-node/factory-node.module';
import { ConfigModule } from '@nestjs/config';

@Module({
  imports: [
    ConfigModule.forRoot({ isGlobal: true }),
    DatabaseModule,
    FactoryNodeModule,
  ],
  controllers: [AppController],
  providers: [AppService],
})
export class AppModule {}
