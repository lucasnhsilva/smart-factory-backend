import { PrismaClient } from '@/generated/prisma/client';
import { Injectable, Logger, OnModuleInit } from '@nestjs/common';
import { PrismaPg } from '@prisma/adapter-pg';

@Injectable()
export class DatabaseService extends PrismaClient implements OnModuleInit {
  private readonly logger = new Logger(DatabaseService.name);
  constructor() {
    const adapter = new PrismaPg({
      connectionString: process.env.DATABASE_URL,
    });
    super({
      adapter,
      log:
        process.env.NODE_ENV === 'development'
          ? ['query', 'info', 'error']
          : ['warn', 'error'],
    });
  }

  async onModuleInit() {
    await this.$connect().catch((e) =>
      this.logger.error('Could not connect to database due to error: ', e),
    );
    this.logger.log('🌱 Database connected');
  }
}
