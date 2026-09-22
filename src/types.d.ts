interface D1Result<T=unknown>{results?:T[];success?:boolean;meta?:unknown}
interface D1PreparedStatement{bind(...values:any[]):D1PreparedStatement;first<T=unknown>(column?:string):Promise<T|null>;all<T=unknown>():Promise<D1Result<T>>;run<T=unknown>():Promise<D1Result<T>>}
interface D1Database{prepare(query:string):D1PreparedStatement}
interface Ai{run(model:string,inputs:any,options?:any):Promise<any>}
interface Fetcher{fetch(input:Request|string|URL,init?:RequestInit):Promise<Response>}
interface ScheduledController{cron:string;scheduledTime:number;noRetry():void}
interface ExecutionContext{waitUntil(promise:Promise<any>):void;passThroughOnException():void}
