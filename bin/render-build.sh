set -o errexit

bundle install
bundle exec rake assets:precompile
bundle exec rake assets:clean
bundle exec rake db:migrate

set RAILS_MASTER_KEY=0d0d3c2974bd615e2da8b77be98f4bb6

chmod a+x bin/render-build.sh

