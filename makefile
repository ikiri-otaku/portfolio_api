RUN_BACK = docker compose run --rm back

build:
	docker compose build

up:
	docker compose up -d

down:
	docker compose down

rubocop:
	${RUN_BACK} bundle exec rubocop

rubocop-a:
	${RUN_BACK} rubocop -a

rspec:
	${RUN_BACK}  rspec ${FILE}

g-model:
	${RUN_BACK} rails g model ${MODEL_NAME} 

g-migration:
	${RUN_BACK} rails g migration ${FILE_NAME} 

migrate:
	${RUN_BACK} rails db:migrate

rollback:
	${RUN_BACK} rails db:rollback STEP=1

seed:
	${RUN_BACK} rails db:seed

bundle-install:
	${RUN_BACK} bundle install