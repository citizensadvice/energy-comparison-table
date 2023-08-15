# 4. Use a static site generator

Date: 2023-08-08

## Status

Rejected

## Context

The energy supplier comparison table is currently hosted in episerver and needs to be rebuilt. This involves:

- parsing and storing data provided by the energy policy team
- rendering the comparison table and associated supplier detail pages

## Decision

Use a static site generator like Bridgetown to create the markup required using the existing CSV.

Optional: use a lambda function to handle publishing events from Contentful so the site is regenerated when a new CSV is uploaded to Contentful. This is optional because the energy team would be happy with the content platform team performing the CSV update as a developer task. This would happen once a quarter so could easily be covered by the spanner rota.

## Consequences

### Positive

- lower infrastructure maintenance outlay and a simpler architecture
- Bridgetown is well suited to consuming CSV data and creating the required markup from structured data
- there is precedent for using Bridgetown in the organisation but not the content platform team (the design system documentation site is powered by Bridgetown)

### Negative

- Determining authentication state and rendering an appropriate website header is complicated in a statically generated site using cloudfront or lambda@edge could potentially solve this
- little to no experience of either static site generation or lambda functions on the content platform team means debugging, maintaining and developing this solution has a high staffing cost / learning curve
- there are a few reasons we can’t be completely confident that a statically generated site will be sufficient:
  - the current designs for the app are not finalised and functionality of the table and supplier detail pages might change
  - the site needs to be progressively enhanced with javascript and the designs for white-labelled suppliers will make this clunky to implement and potentially a poor user experience if we use a statically generated site (specifically the white-labelled supplier form will ideally be a post form enhanced with js)
