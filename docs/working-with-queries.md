# Working with queries

This app makes GraphQL queries directly to Contentful using Github's [graphql-client](https://github.com/github/graphql-client).

This guide focuses on working with queries within the codebase.

## Query definitions

GraphQL queries live under `app/controllers/queries` with each query being defined in a single file.

Queries are declared with the same syntax inside of a `<<-'GRAPHQL' heredoc`. There isn't any special query builder Ruby DSL. This has the quality that queries are directly copyable into [Contentful's GraphiQL explorer](https://www.contentful.com/developers/docs/references/graphql/#/reference/exploring-the-schema-with-graphiql).

## Updating the schema

The [graphql-client](https://github.com/github/graphql-client) library we use for querying the Contentful GraphQL API operates by checking queries against the GraphQL schema.

The client can load the schema dynamically but this incurs an extra HTTP call at start up. To avoid this overhead the docs recommend including a rake task to dump the schema.

When accessing new fields you will need to run the following task to update the schema and commit the output.

```
./bin/rails update_schema
```

This task can only be run against the `master` environment so make sure your `CONTENTFUL_ENVIRONMENT_ID` is set to match before running this task.

If a `LOAD_SCHEMA_DYNAMICALLY` envionrment variable is enabled the app fetches the schema dynamically. This can be useful for testing out new schemas in a temporary environment without needing to update the schema file. Deployed environments all point to the master space.
