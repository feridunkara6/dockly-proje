import { Module } from '@nestjs/common';
import { WeatherController } from './presentation/weather.controller';
import { WeatherService } from './application/weather.service';
import { WEATHER_PROVIDER } from './domain/weather.provider';
import { MetNorwayProvider } from './persistence/met-norway.provider';

@Module({
  controllers: [WeatherController],
  providers: [
    WeatherService,
    { provide: WEATHER_PROVIDER, useClass: MetNorwayProvider },
  ],
})
export class WeatherModule {}
