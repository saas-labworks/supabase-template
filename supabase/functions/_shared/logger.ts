import winston from 'https://esm.sh/winston@3.11.0'
import { ILogger, LoggerLevel } from './types/logger.types.ts';


export class Logger implements ILogger {
  private logger: winston.Logger;
  private correlationId: string;

  constructor(level: LoggerLevel = LoggerLevel.info, correlationId?: string) {
    this.correlationId = correlationId || crypto.randomUUID();
    this.logger = winston.createLogger({
      level,
      format: winston.format.combine(
        winston.format.colorize(),
        winston.format.timestamp(),
        winston.format.printf(({ level, message, timestamp }: winston.Logform.TransformableInfo) => {
          return `[${level}] (${new Date(timestamp).toLocaleString()} - ${this.correlationId}): ${message}`;
        })
      ),
      transports: [
        new winston.transports.Console()
      ]
    })
  }

  info(message: string): void {
    this.logger.info(message);
  }
  warn(message: string): void {
    this.logger.warn(message);
  }
  error(message: string): void {
    this.logger.error(message);
  }
}