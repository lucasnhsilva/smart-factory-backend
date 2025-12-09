import { PrismaClient } from '@/generated/prisma/client';
import { Injectable, OnModuleInit } from '@nestjs/common';
import { PrismaPg } from '@prisma/adapter-pg';

@Injectable()
export class DatabaseService extends PrismaClient implements OnModuleInit {
  constructor(uri?: string) {
    const pgAdapter = new PrismaPg(uri ?? process.env.DATABASE_URL);
    super({
      adapter: pgAdapter,
      log:
        process.env.NODE_ENV === 'development'
          ? ['query', 'info', 'error']
          : ['warn', 'error'],
    });
  }

  async onModuleInit() {
    await this.$connect().catch((e) =>
      console.error('Could not connect to database due to error: ', e),
    );
    console.log('🌱 Database connected');
  }
}
