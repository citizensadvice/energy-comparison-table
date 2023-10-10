# 6. Routing and URLs

Date: 2023-09-12

## Status

Accepted

## Context

This app is separate from the public website app, but needs to appear as if it is a page in the site hierarchy. At the time of development, the episerver version of the app lives on `/consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service1/`.

## Decision

Route requests to this app using the existing instance of CloudFront that is configured in [`public-website-config`](https://github.com/citizensadvice/public-website-config).

Requests should be forwarded to the app in their original form and not manipulated by CloudFront to change the path.

A redirect will be created in nginx to remove the `1` at the end of the current url, ie:

```
/consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service1/ /consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service/
```

## Consequences

The app will need to respond to GET requests on

- `/consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service/`
- `/consumer/your-energy/get-a-better-energy-deal/compare-domestic-energy-suppliers-customer-service/<energy-supplier-slug>`

We'll use a base path variable in the rails app to configure these paths.

# Positive

- configuring the base path in the rails app is more familiar to content platform devs, so will be easier to maintain and edit as required
- it does not introduce additional complexity to the CloudFront configuration

# Negative

- changing where the app 'sits' in the site hierarchy will also need a code change, which means content designers can't move it around in Contentful

  This is a big problem, but it's hard to avoid. It wouldn't be an issue if we had built the table in public-website, but we think the [benefits of having a separate Rails app](./0003-single-rails-app.md) still outweigh this downside.

  The other solution is to make the routing dynamic (e.g. calling Contentful from the CloudFront Lambda@Edge functions), but we think that would add latency and be complex to build.
