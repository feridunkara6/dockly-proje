import { NestFactory } from '@nestjs/core';
import { Logger } from 'nestjs-pino';
import { AppModule } from './app.module';
import { EnvService } from './config/env.service';
import { GlobalProblemFilter } from './common/problem/problem.filter';

async function bootstrap(): Promise<void> {
  const app = await NestFactory.create(AppModule, { bufferLogs: true });
  app.useLogger(app.get(Logger));
  app.useGlobalFilters(new GlobalProblemFilter());
  app.enableShutdownHooks();

  const env = app.get(EnvService);
  await app.listen(env.get('PORT'));
}

void bootstrap();
