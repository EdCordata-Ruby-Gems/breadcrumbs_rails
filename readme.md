## Breadcrumbs Rails

![Ruby Version](badges/ruby.svg)
![Ruby Version](badges/rails.svg)
[![License](badges/license.svg)](https://creativecommons.org/licenses/by/4.0/)


<br/>


#### Installation

As usual, add to Gemfile:
```ruby
gem 'breadcrumbs_rails'
```

Generate config:
```bash
rails g breadcrumbs:config
```


<br/>


#### Usage:

In controllers
```ruby
class ApplicationController < ActionController::Base
  include BreadcrumbsRails
  
  # non-required attributes:
  # * path        - if not specified, item will be text, instead of link. Possible STRING values: '/', 'root_path'
  # * scope       - views scope, in case you want different breadcrumbs for different namespaces, like 'admin'
  # * views_title - only for inspinia template. This is title above breadcrumbs.
  # * template    - template of views to use: 'html', 'bootstrap', 'inspinia' (only if not using custom views).
  #                 Note that, if this argument is passed, gems views will be used.
  add_breadcrumb 'views.home', path: 'root_path', title: 'Home', scope: 'views.admin', localize: true
end

class UsersController < ApplicationController
  add_breadcrumb 'Users', path: 'users_path', title: 'Users'
  
  def edit
    add_breadcrumb('User')
  end
end
```

To use `title` functionality:
```haml
%title= render_breadcrumbs_title
```

Using gem's views
```haml
= render_breadcrumbs

# or with specific template
= render_breadcrumbs(template: 'bootstrap') # default: 'html'; available: 'html', 'bootstrap', 'inspinia'
```

Or creating custom:
```haml
- render_breadcrumbs do |breadcrumbs|
  - breadcrumbs.breadcrumbs.each do |breadcrumb|
    %li= link_to_if breadcrumb.path, breadcrumb.name, breadcrumb.path
```

Available methods:
```haml
- render_breadcrumbs do |breadcrumbs|

  - breadcrumbs.scope    # current scope
  - breadcrumbs.format   # current format
  
    breadcrumb.localize # boolean if should localize title
    breadcrumb.locale   # current locale
    
  - breadcrumbs.title_string # string, provided in admin panel
  - breadcrumbs.title        # string or translation of title, provided in admin panel
  
  - breadcrumbs.breadcrumbs.each do |breadcrumb|
    
    breadcrumb.localize # boolean if should localize name
    breadcrumb.locale   # current locale
    
    breadcrumb.name_string # string, provided in admin panel
    breadcrumb.name        # string or translation of string, provided in admin panel
    
    breadcrumb.path_path # path string, provided in admin panel
    breadcrumb.path      # path string or url, provided in admin
```


<br/>



#### Generate views

You can also specify only one format (`haml`, `erb.html`), by adding `--format` parameter:
```bash
rails g breadcrumbs:views haml --format haml
rails g breadcrumbs:views haml --format erb

rails g breadcrumbs:views inspinia --format haml
rails g breadcrumbs:views inspinia --format erb

rails g breadcrumbs:views bootstrap --format haml
rails g breadcrumbs:views bootstrap --format erb
```
