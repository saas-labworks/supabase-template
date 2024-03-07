  
  export interface ILogger {
    info: (message: string) => void;
    warn: (message: string) => void;
    error: (message: string) => void;
  }
  
  export enum LoggerLevel {
    error = 'error',
    warn = 'warn',
    info = 'info',
    http = 'http',
    verbose = 'verbose',
    debug = 'debug',
    silly = 'silly'
  }
  