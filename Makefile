all: build push 
push: push_cli push_dind push_rootless push_nvidia
build: build_cli build_dind build_rootless build_nvidia	
push_cli: build_cli
	docker push caffeinism/docker-cli:ubuntu
push_dind: build_dind
	docker push caffeinism/docker-dind:ubuntu
push_rootless: build_rootless
	docker push caffeinism/docker-dind-rootless:ubuntu
push_nvidia: build_nvidia
	docker push caffeinism/docker-dind-rootless-nvidia:ubuntu
build_cli:
	docker build ./cli --tag=caffeinism/docker-cli:ubuntu
build_dind:
	docker build ./dind --tag=caffeinism/docker-dind:ubuntu
build_rootless:
	docker build ./dind-rootless --tag=caffeinism/docker-dind-rootless:ubuntu
build_nvidia:
	docker build ./dind-rootless-nvidia --tag=caffeinism/docker-dind-rootless-nvidia:ubuntu
