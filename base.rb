

# Gems (all environments)
gem "robinsp-robins_html_helpers",
       :lib    => "robins_html_helpers",
       :version => '>= 0.2.1',
       :source => "http://gems.github.com"

rake "gems:install"

# Gems (test environments)
with_options :env => 'test' do |test_env| 
  test_env.gem "thoughtbot-factory_girl",
                 :lib    => "factory_girl",
                 :source => "http://gems.github.com"
  
  test_env.rake "gems:install"
end 


# RSpec
if yes?("Use RSpec?")
  if yes?("RSpec as gems (answer no for plugins)?")
    with_options :env => 'test' do |test_env|
      test_env.gem "rspec"
      test_env.gem "rspec-rails"
      test_env.rake "gems:install"
    end

  else
    plugin "rspec", :git => "git://github.com/dchelimsky/rspec.git"
    plugin "rspec-rails", :git => "git://github.com/dchelimsky/rspec-rails.git"
  end
  
  run "rm -rf test "
  generate :rspec
  
end


# Remove deafault files
run "rm README doc/README_FOR_APP"
run "rm public/index.html public/images/rails.png"

# Default layout
generate :robins_layout

# Default controller/action 
file "app/controllers/static_controller.rb", <<-END
class StaticController < ApplicationController
  def index
  end
end
END

file "app/views/static/index.html.erb", <<-END 
<h1>Root</h1>
<p>Find me in app/views/static/index.html.erb</p>
END

route "map.root :controller => 'static'"

# Database configs
run "cp config/database.yml config/example_database.yml"

# Git
file ".gitignore", <<-END
log/*.log
tmp/**/*
config/database.yml
db/*.sqlite3
.project
.loadpath
coverage/**/*
END

git :init
git :add => "."

