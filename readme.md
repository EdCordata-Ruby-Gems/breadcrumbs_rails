# Breadcrumbs Rails

![Ruby Version](badges/ruby.svg)
[![License](badges/license.svg)](https://creativecommons.org/licenses/by/4.0/)

Breadcrumbs rails is easy way to create breadcrumbs from controllers and render them in view. This gem also
includes functionality to easily change title.

### Installation

As usual, add to Gemfile:
```ruby
gem 'breadcrumbs_rails'
```

and run:
```bash
$ bundle install
```


### Introduction

Syntax is `add_breadcrumb(name, options)`
Available options:
  * `html_safe` - (type: boolean, default: false) - specifies if title is html safe and shouldn't be escaped
  * `:path` - (type: string, default: nil) - link path as string. It must be a string, not symbol
  * `:params` - (type: hash, default: {}) - params to pass to `:path`
  * `:title`  - (type: string, default: nil) - title for `:render_breadcrumbs_title` method



### Usage

In controllers
```ruby
class ApplicationController < ActionController::Base
  add_breadcrumb 'Home',  path: 'root_path',  params: { locale: 'en' }
end

class UsersController < ApplicationController
  add_breadcrumb 'Users', path: 'users_path',  params: { locale: 'en' }, title: 'Users'
  
  def edit
    add_breadcrumb('User')
  end
end
```

If you want to use translations, do it like so:
```ruby
class ApplicationController < ActionController::Base
  add_breadcrumb 'links.home',  path: 'root_path',  params: { locale: 'en' }, title: '', localize: true # Only name is required
end

class UsersController < ApplicationController
  add_breadcrumb 'links.users', path: 'users_path',  params: { locale: 'en' }, title: 'Users'
  
  def edit
    add_breadcrumb('links.user')
  end
end
```

### Rendering breadcrumbs
Default format is `:html`. Available: `:html`, `:bootstrap`, `:inspinia`.
```haml
= render_breadcrumbs(format: :html)
```

Or by using block:
```haml
- render_breadcrumbs do |renderer|
  - renderer[:breadcrumbs].each do |breadcrumb|
    %li= link_to_if breadcrumb[:path], breadcrumb[:name], breadcrumb[:path]
```

### To use `title` functionality:
```haml
%html
  %title= render_breadcrumbs_title
```
