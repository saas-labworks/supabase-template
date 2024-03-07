// deno-lint-ignore-file ban-types
import { corsHeaders } from "./headers.ts";
import { Logger } from "./logger.ts";

interface IBodyResponse {
    data?: Object;
    message: string;
    success: boolean;
}


export function buildResponse( 
    data: Object, status: number, message: string, 
    headers: HeadersInit = { ...corsHeaders, 'Content-Type': 'application/json' },
    logger: Logger
): Response {
    const success = status >= 200 && status < 400;

    const ansBody: IBodyResponse = { success, data, message };

    if (status >= 400) {
        logger.error(`Final Response: \n` + JSON.stringify(ansBody));
    } else {
        logger.info(`Final Response: \n` + JSON.stringify(ansBody));
    }

    return new Response(JSON.stringify(ansBody), {
        headers,
        status
    });
}