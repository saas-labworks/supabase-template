# supabase-template-project
Initial template for backend projects using Supabase like BaaS  



## How to use it?


## Deploy configuration

In the project, there are two github actions workflow for the deploys:

#### Deployment to development

The file `deploy-dev.yml` is the workflow to deploy changes to devlopment. This workflow will active when push change in the __develop__ branch. For do this, we need to set some secrets varaibles in the repository in github for the access supabase development project in remote:

- `DEV_ACCESS_TOKEN`: This is the __secret_role__ key
- `DEV_PROJECT_ID`: The project_id in supabase
- `DEV_DB_PASSWORD`: The database password
- `DEV_CONNECTION_STRING`: The database conection string


#### Deployment to production

The file `deploy-prod.yml` is the workflow to deploy changes to production. This workflow will active when push change in the __main__ branch. For do this, we need to set some secrets varaibles in the repository in github for the access supabase development project in remote:

- `SUPABASE_ACCESS_TOKEN`: This is the __secret_role__ key
- `SUPABASE_PROJECT_ID`: The project_id in supabase
- `SUPABASE_DB_PASSWORD`: The database password




### Code styling


-- Las funciones se le añade un prefijo en el nombre para asociarlo a algun subconjunto importate de funciones, como por ejemplo auth__, shop__
-- Si una funcion se crea solamente para ser ejecutada en un trigger entonces su nombre debe estar compuesto por el prefijo + tr + el evento