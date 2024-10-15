# 8. Appliance Calculator Code Location

Date: 2024-10-15

## Status

Draft, Proposed

## Context

The energy team's appliance calculator is currently served be EpiServer at https://www.citizensadvice.org.uk/consumer/energy/energy-supply/save-energy-at-home/check-how-much-your-electrical-appliances-cost-to-use/.  

The Digital Energy Team is rebuilding this app as a progressively enhanced Rails app and we need to decide where the code for that app should live.  

The energy team currently have three code repos for their apps in production:
- [citizensadvice/energy-prototypes](https://www.github.com/citizensadvice/energy-prototypes) (current appliance calculator, will be archived on completion of this work)
- [citizensadvice/smart-meter-tool](https://github.com/citizensadvice/smart-meter-tool) (has specific contractual deployment and hosting isolation requirements)
- [citizensadvice/energy-comparison-table](https://github.com/citizensadvice/energy-comparison-table) (single rails app handling requests for the customer service rating comparison table)

The appliance calculator itself will be rendered into an iframe on an advice collection page by the public website, which involves creating a [new content type](https://app.contentful.com/spaces/vms0u05139aw/environments/qa/content_types/interactiveTool/fields) to represent the calculator, making content-api understand that new content type and creating a new renderer in the public website codebase.  Rough implementation spikes have proved that this will work:
- https://github.com/citizensadvice/content-api/tree/exp/interactive-tool-spike
- https://github.com/citizensadvice/public-website/tree/exp/interactive-tool-spike

## Decision

1. Generalise from `energy-comparison-table` to `energy-apps`, by:
   1. recreating the current app infrastructure with the more generic `energy-apps` name
   2. switching to the the new sub-domain in production in the CloudFront config
   3. renaming the `energy-comparison-table` app and namespacing the comparison table app appropriately
2. Build the appliance calculator in the newly renamed `energy-apps` rails app

## Consequences

### Positive

- all energy apps (excluding the smart meter tool) are contained in the same place
- we will only need to solve certain problems once for all energy apps (eg monitoring, authentication, header and footer, country route handling, Contentful GraphQL queries)
- little to no additional maintenance burden
- can leverage the existing build and deployment workflows (which are robust and fast)
- increased exposure to CDK and infrastructure configration for the energy team developer (the current infrastructure code was developed by the SRE team)


### Negative

- the additional work in re-creating and switching is significant, but this is ameliorated by the following factors:
  - there is time to do this work now whilst the energy team wait for decisions about upcoming work (changes to the comparison table and the smart meter tool)
  - it is easier to do now before more complexity is added to the single energy app
- additional work in namespacing and organising the existing energy comparison table code

## Discounted alternatives

### Building the appliance calculator in public website

The appliance calculator could also be built inside the public website codebase.

#### Positives

- problems like monitoring, authentication, header and footer, country route handling are all aready solved here
- potentially easier / quicker for non-energy team devs to debug and support the appliance calculator code if required
- little to no maintenance burdern

#### Negatives

- energy developers will need to understand the public website and content-api apps
- long build times
- poorer domain seperation - does this code really belong in the public website codebase?

### Building the appliance calculator in a new, separate application and repository

The appliance calculator is built completely seperately to everything else

#### Positives

- increased exposure to CDK and infrastructure configration for the energy team developer
- best domain seperation

#### Negatives

- significantly increased code maintenace burden
- increased content maintenance burden (header and footer updates)
- ?increased hosting costs
- code duplication in solving shared problems again (monitoring, authentication, header and footer, country route handling etc)
- additional work to set up another new rails application