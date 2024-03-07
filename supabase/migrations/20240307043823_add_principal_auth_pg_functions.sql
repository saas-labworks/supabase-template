

create or replace function public.auth__user_has_claim(claim varchar)
returns boolean
language plpgsql
security definer
as $function$
declare
    _has_claim boolean;
begin
    select exists (
        select 1 from public.users
        where id = auth.uid() and full_claims @> array[claim]
    ) into _has_claim;

    return _has_claim;
end;
$function$;


create or replace function public.auth__user_has_role(custom_role varchar)
returns boolean
language plpgsql
security definer
as $function$
declare
    _has_role boolean;
begin
    select exists (
        select 1 from users_roles ur
        inner join roles r on r.id = ur.role_id
        where r.name ilike custom_role
    ) into _has_role;

    return _has_role;
end;
$function$;



create or replace function public.auth__tr_on_claims_changes_update_admin_role()
returns trigger
language plpgsql
security definer
as $function$
-- trigger after insert, update or delete on public.claims
-- when change claims table, update claims related with ADMIN role
begin
    update public.roles
    set claims = array(select name from public.claims)
    where name = 'ADMIN';
end;
$function$;

create trigger auth__tr_on_claims_changes_update_admin_role after insert or update or delete on public.claims for each row execute function public.auth__tr_on_claims_changes_update_admin_role();



create or replace function public.auth__get_user_claims(user_id uuid)
returns varchar[]
language plpgsql
security definer
as $function$
declare
    _full_claims varchar[];
begin
    select array_agg(distinct unnest(r.claims)) into _full_claims 
    from public.users_roles ur inner join public.roles r on r.id = ur.role_id
    where ur.user_id = user_id;

    return _full_claims;
end;
$function$;



create or replace function public.auth__tr_on_role_claims_changes_update_users_claims()
returns trigger
language plpgsql
security definer
as $function$
-- trigger after update or remove on public.roles
-- when roles table changes, update claims of users with that role
begin
    update public.users
    set full_claims = (select public.auth__get_user_claims(id))
    where id in (
        select distinct ur.user_id from public.users_roles ur
        where ur.role_id = new.id
    );

    return new;
end;
$function$;

create trigger auth__tr_on_role_claims_changes_update_users_claims after update or delete on public.roles for each row execute function public.auth__tr_on_role_claims_changes_update_users_claims();



create or replace function public.auth__tr_on_users_roles_changes_update_users_claims()
returns trigger
language plpgsql
security definer
as $function$
-- trigger after insert or update or remove on public.users_roles
-- when users_roles table changes, update claims of users with that role
begin
    update public.users
    set full_claims = (select public.auth__get_user_claims(id))
    where id = new.user_id;

    return new;
end;
$function$;

create trigger auth__tr_on_users_roles_changes_update_users_claims after insert or update or delete on public.users_roles for each row execute function public.auth__tr_on_users_roles_changes_update_users_claims();



