# Working with ViewComponents

We use [ViewComponent](https://viewcomponent.org/) to manage the majority of the templating logic in our application.

See the [ViewComponent docs](https://viewcomponent.org/) for an overview of what ViewComponent is and how it works.

## The two types of ViewComponents we write

We build our views using ViewComponents that tend to fall into two categories: Design System components and app-specific components.

### Design System components

The core set of components that make up our application come from our internal `citizens_advice_components` gem.

See the [Design System guide](./design-system.md) for more information on how the Design System works.

These can be used directly within views or composed within other ViewComponents. For example:

```haml
= render CitizensAdviceComponents::Callout.new(type: :standard)) do
  %h3 Callout title
  %p Some example text
```

### App-specific ViewComponents

For anything that doesn't come from the design system we also write app-specific ViewComponents under `app/components`.

These can do small things like wrap Design System components to customise them, such as [this footer component](../app/components/footer_component.rb), up to providing whole page layouts.

By using the same framework for both our Design System components and our app-specific components it makes it much simpler to upstream components to the Design System if we need to.

## Structuring your components

### Avoid inheritance

In our experience, having one ViewComponent inherit from another leads to confusion, especially when each component has its own template. Instead, we recommend [using composition](https://thoughtbot.com/blog/reusable-oo-composition-vs-inheritance) to wrap one component with another.

### When to use a ViewComponent for an entire layout

ViewComponents have less value in single-use cases like replacing a `show` view. However, it can make sense to render an entire layout with a ViewComponent when unit testing is valuable, such as for views with many permutations.

When migrating an entire layout to use ViewComponents, we've had our best luck doing so from the bottom up, extracting portions of the page into ViewComponents first.

### Prefer ViewComponents over partials

Use ViewComponents in place of partials, as ViewComponents allow us to test reused view code directly (via unit tests) instead of through each place a partial is reused.

### Prefer ViewComponents over HTML-generating helpers

Use ViewComponents in place of helpers that return HTML.

### Avoid global state

The more a ViewComponent is dependent on global state (such as request parameters or the current URL), the less likely it's to be reusable. Avoid implicit coupling to global state, instead passing it into the component explicitly. Thorough unit testing is a good way to ensure decoupling from global state.

```ruby
# good
class MyComponent < ViewComponent::Base
  def initialize(name:)
    @name = name
  end
end

# not our preference
class MyComponent < ViewComponent::Base
  def initialize
    @name = params[:name]
  end
end
```

### Avoid inline Ruby in ViewComponent templates

Avoid writing inline Ruby in ViewComponent templates. Try using an instance method on the ViewComponent instead:

```ruby
# good
class MyComponent < ViewComponent::Base
  private

  def message
    "Hello, #{@name}!"
  end
end
```

```haml
-# not our preference
- message = "Hello, #{@name}"
```

### Pass an object instead of 3+ object attributes

ViewComponents should be passed individual object attributes unless three or more attributes are needed from the object, in which case the entire object should be passed:

```ruby
# good
class MyComponent < ViewComponent::Base
  def initialize(page:); end
end

# not our preference
class MyComponent < ViewComponent::Base
  def initialize(page_title:, page_body:, page_last_reviewed:); end
end
```

### Use inline templates for smaller components

If you are writing a small component prefer inlining the template into the `call` method rather than using a single line template file.

```ruby
# good
class MyComponent < ViewComponent::Base
  def initialize(date:)
    @date = date
  end

  def call
    tag.div(formatted_date, class: "my-component")
  end

  private

  def formatted_date
    I18n.l(@date, format: "%d %B %Y")
  end
end
```

```ruby
# not our preference
class MyComponent < ViewComponent::Base
  def initialize(date:)
    @date = date
  end

  private

  def formatted_date
    I18n.l(@date, format: "%d %B %Y")
  end
end
```

```haml
-# my_component.html.haml
.my-component= formatted_date
```

## Testing components

The [ViewComponent guide on testing](https://viewcomponent.org/guide/testing.html) is a good starting point for understanding how to test components. However the official guides mostly use Minitest so there are a few extra considerations when using RSpec.

### Prefer capybara matchers when testing components

ViewComponent provides capybara support for tests with the `:component` type as long as you follow a particular set up. This also makes it easier to use simple one-line expectations.

```ruby
# good
RSpec.describe MyComponent, type: :component do
  before do
    # Calling render_inline with a before block will
    # automatically assign the `page` variable which
    # is a capybara node
    render_inline described_class.new(message: "Hello")
  end

  it { is_expected.to have_selector ".my-component", text: "Hello" }
end
```

```ruby
# not our preference
RSpec.describe MyComponent, type: :component do
  subject(:component) do
    # Assigning the result of render_inline to
    # a subject directly will return a plain
    # Nokogiri which is harder to work with
    render_inline described_class.new(message: "Hello")
  end

  it "renders message"
    expect(component.at(".my-component").text.strip).to include("Hello")
  end
end
```

### Prefer testing against rendered content, not instance methods

ViewComponent tests should use `render_inline` and assert against the rendered output. While it can appear useful to test specific component instance methods directly, it is our strong preference to write assertions against what we show to the end user:

```ruby
# good
render_inline MyComponent.new
expect(page).to have_content "Hello, World!"

# not our preference
expect(MyComponent.new.message).to eq "Hello, World!"
```

## Credits

This guide was [written by David Rapson and Peyton Sterling](https://github.com/citizensadvice/referrals/commit/77142cb15fd60881eb1c51b555695a179c16dff8) for the referrals project.
