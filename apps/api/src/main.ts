import { NestFactory } from '@nestjs/core';
import { Logger } from 'nestjs-pino';
import { AppModule } from './app.module';
import { EnvService } from './config/env.service';
import { GlobalProblemFilter } from './common/problem/problem.filter';

async function bootstrap(): Promise<void> {
  const app = await NestFactory.create(AppModule, { bufferLogs: true });
  app.useLogger(app.get(Logger));
  app.useGlobalFilters(new GlobalProblemFilter());
  // CORS: misafir okuma uçları herkese açık; yazma uçları zaten Bearer token ister.
  // Web önizlemesi (GitHub Pages) ve gelecekteki web istemcileri bu sayede erişir.
  app.enableCors();
  // İş uçları /v1 altında (docs/23 §1); health uçları ALB için köke açık (docs/24 §13).
  app.setGlobalPrefix('v1', { exclude: ['healthz', 'readyz'] });
  app.enableShutdownHooks();

  const env = app.get(EnvService);
  await app.listen(env.get('PORT'));
}

void bootstrap();
