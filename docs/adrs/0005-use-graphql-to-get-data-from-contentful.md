# 5. Use GraphQL to get data from Contentful

Date: 2023-07-27

## Status

Accepted

## Context

The energy supplier comparison table is currently hosted in episerver and needs to be rebuilt. This involves:

- parsing and storing data provided by the energy policy team
- rendering the comparison table and associated supplier detail pages

Previously the content platform team has used the Contentful CDA and CMA gems to interact with Contentful.

## Decision
Use GraphQL API to retrieve supplier data from the public advice space of Contentful, instead of using the existing content API or the Contentful CDA gem.

## Consequences

### Positive

- calling Contentful directly means there is no need to synchronise an additional data source (eg a database) with Contentful, which reduces infrastructure requirements around queuing tasks
- there is no dependency between the energy supplier table and content api
- GraphQL is more performant that the Contentful gem, which allows us to try developing the solution without a redis cache
- The intranet is a good example of GraphQL integration in a rails app

### Negative

- Lack of familiarity with GraphQL(?)
