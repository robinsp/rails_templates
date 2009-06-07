
run "rm README doc/README_FOR_APP"
run "rm public/index.html public/images/rails.png"

# Should be moved to rspec template
run "rm -rf test "

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
