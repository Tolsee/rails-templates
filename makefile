create:
	rails new $(APP_NAME) -m ./template.rb -T ${OPTIONS}

build:
	cd $(APP_NAME); \
	docker-compose -f docker-compose.test.yml build

run:
	cd $(APP_NAME); \
	docker-compose -f docker-compose.test.yml run test

unit-test:
	cd .template; \
		bundle install; \
		bundle exec rspec spec/docker_image_spec.rb; \
		bundle exec rspec spec/base; \
	if [ $(VARIANT) = web ]; then bundle exec rspec spec/variants/web; fi;
	if [ $(VARIANT) = api ]; then bundle exec rspec spec/variants/api; fi;

cleanup:
	rm -rf $(APP_NAME)

.PHONY: create build run cleanup
