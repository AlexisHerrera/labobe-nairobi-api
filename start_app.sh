#!/bin/sh
bundle exec rake db:migrate db:seed
bundle exec padrino start -p $PORT -h 0.0.0.0
