ENV ?= dev

setup-env:
	# yarn
	echo "Start setup Environment"
	cp ./environments/$(ENV)/.env .env
	cp ./environments/$(ENV)/firebase.js ./web/firebase.js

deploy:
	make setup-env
	firebase use $(ENV)
	flutter build web --dart-define env=$$(echo $$(cat .env | tr '\n' '|'))
	firebase deploy

run:
	make setup-env
	firebase use $(E NV)
	flutter run --dart-define env=$$(echo $$(cat .env | tr '\n' '|')) -d chrome
	