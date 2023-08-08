# 3. Single rails app

Date: 2023-27-07

## Status

Accepted

## Context

The energy supplier comparison table is currently hosted in episerver and needs to be rebuilt. This involves:

- parsing and storing data provided by the energy policy team
- rendering the comparison table and associated supplier detail pages

The app needs to:

- retrieve data from Contentful (see ADR 001)
- present a ranked table of energy suppliers to users on the comparison table page
- present scores, billing, contact and opening time information to users on a supplier detail page
- sort / filter supplier table rows based on current view
- present billing, contact and opening time information for suppliers that are not in the table

## Decision

Create a new rails app that communicates directly with Contentful using the Intranet model and the GraphQL API (see ADR 005). It will also act as the presentation layer and use view components and the design-system to render pages as per the designs.

We can do some performance / load testing to see if a caching solution is required.

Other ADRs will consider how to upload and create the data in Contentful.

Using a static site generator, an S3 bucket and a lambda function has also been considered.

# Consequences

### Positive

- release cycle is independent of public website and content-api apps
- we can use the CDK to create and deploy the app
- build / CI pipeline completion times will be fast
- advantages of a smaller and familiar code base
- easier to comprehend / reason about
- does not require knowledge of other products in content platform
- an opportunity to work in the open / open source
- we can explore alternative deployment process in the content platform team
- we can explore an alternative feature testing approach in the content platform team

### Negative

- an additional maintenance burden
- may require additional redis instance if caching is needed
- to replicate the header authentication functionality of public website, we’ll need to duplicate the authentication code or refactor it from public website so it is re-usable across products
