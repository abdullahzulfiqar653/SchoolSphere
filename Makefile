.PHONY: install
install:
	poetry install

.PHONY: migrate
migrate:
	poetry run python -m src.manage migrate

.PHONY: migrations
migrations:
	poetry run python -m src.manage makemigrations

.PHONY: superuser
superuser:
	poetry run python -m src.manage createsuperuser

.PHONY: shell
shell:
	poetry run python -m src.manage shell

.PHONY: runserver
runserver:
	poetry run python -m src.manage runserver

.PHONY: precommit
pre-commit:
	poetry run pre-commit run --all-files

.PHONY: install-pre-commit
install-pre-commit:
	poetry run pre-commit uninstall; poetry run pre-commit install

.PHONY: update
update: install migrate install-pre-commit;

.PHONY: services
services:
	test -f .env || touch .env
	docker-compose -f docker-compose.dev.yml up --build
