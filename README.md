# SRE Technical Challenge Helm Chart

This chart deploys the Stord technical challenge app.

## Postgres Setup

The application requires a Postgres database to be available before it starts. Commands below will get a db ready. 

This will also create the namespace if it doesn't already exist, an important step for later.

   ```bash
   helm repo add bitnami https://charts.bitnami.com/bitnami
   helm install sre-db bitnami/postgresql \
     --namespace stord \
     --create-namespace \
     --set auth.database=sre-technical-challenge \
     --set auth.postgresPassword=password
   ```

## Helm Chart Deployment

### Steps to Deploy

Once PostgreSQL is set up, you can deploy the Elixir application using this:

1. Update the defaults in the values.yaml file if you want, but they *should* suffice.

   ```yaml
   env:
     DATABASE_URL: postgresql://postgres:password@sre-db-postgresql/sre-technical-challenge
     PHX_HOST: localhost
     SECRET_KEY_BASE: super-secret-key
     POOL_SIZE: "10"
     PORT: "4000"
   ```

2. **Install the Helm chart:**

   ```bash
   helm install sre-app . \
      --namespace stord \
      --values values.yaml \
      --debug \
      --wait
   ```

### Verify Deployment

1. **Postgres Deployment:**

```bash
kubectl port-forward -n stord svc/sre-db-postgresql 55432:5432
psql postgresql://postgres:password@127.0.0.1:55432/sre-technical-challenge
```

2. **Port-forward the Phoenix application:**

   ```bash
   kubectl port-forward svc/sre-app-sre-technical-challenge 8080:80 -n stord
   ```

   - Phoenix default page: [http://localhost:8080/](http://localhost:8080/)
   - Todos page: [http://localhost:8080/todos](http://localhost:8080/todos)

### Cleanup

```bash
helm uninstall sre-app --namespace stord
helm uninstall sre-db --namespace stord
```
