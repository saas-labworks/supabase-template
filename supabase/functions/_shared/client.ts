import {createClient} from 'https://esm.sh/@supabase/supabase-js@2.5.0'
import {Database} from "../../schema.ts";
import {EnvVars} from "./types/env.enum.ts";

const url = Deno.env.get(EnvVars.ENV) === 'dev'
    ? Deno.env.get('URL')
    : Deno.env.get(EnvVars.SUPABASE_URL);

const key = Deno.env.get(EnvVars.ENV) === "dev"
    ? Deno.env.get('SERVICE_ROLE_KEY')
    : Deno.env.get(EnvVars.SUPABASE_SERVICE_ROLE_KEY);

export const SupabaseClient = createClient<Database>(
    url!,
    key!,
    {
        auth: {
            autoRefreshToken: true,
            persistSession: true,
            detectSessionInUrl: true
        }
    }
);
