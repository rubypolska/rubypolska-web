install:
	gem install bundler
	bundle lock --add-platform x86_64-linux ruby x86-mingw32 x86-mswin32 x64-mingw32 java
	bundle install

build:
	docker-compose build

build-nocache:
	docker-compose build --no-cache

up:
	docker-compose up

console:
	docker exec -it rubyposce-web rails c

attach:
	docker exec -it rubypolsce-web-1 bash

generate-erd:
	docker exec rubypolsce-web-1 erd .

start:
	docker exec -it rubypolsce-web-1 RAILS_ENV=development bash rails server -p 3000

clean:
	sudo chwon -R ${USER}:${USER} .
	rm -rf ./coverage ./tmp/* ./log/*

down:
	docker-compose down

dbrenew:
	bundle exec rails db:renew

dbreset:
	rails db:drop db:create db:migrate db:seed db:test:prepare

create-env-file:
	cp .env.sample .env

scss-lint:
	bundle exec scss-lint app/assets/stylesheets/

fasterer:
	fasterer .

best-practices:
	rails_best_practices .

rubocop:
	rubocop .

rubycritic:
	rubycritic .

flog:
	flog .

foreman:
	foreman .

run-tests:
	bundle exec rspec spec

overcommit:
	overcommit -i
	overcommit --sign pre-commit
	overcommit -r

gems-renew:
	gem uninstall -aIx
	sudo apt autoremove
	make install

define cp-file
	cp -vf config/$(1) $(2)/;
endef