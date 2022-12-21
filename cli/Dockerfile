FROM ubuntu:22.04

RUN apt update && apt install -y \
		ca-certificates \
		openssh-client \
		wget

ENV DOCKER_VERSION 20.10.22

RUN set -eux; \
	\
	arch="$(uname -m)"; \
	case "$arch" in \
		'x86_64') \
			url='https://download.docker.com/linux/static/stable/x86_64/docker-20.10.22.tgz'; \
			;; \
		'armhf') \
			url='https://download.docker.com/linux/static/stable/armel/docker-20.10.22.tgz'; \
			;; \
		'armv7') \
			url='https://download.docker.com/linux/static/stable/armhf/docker-20.10.22.tgz'; \
			;; \
		'aarch64') \
			url='https://download.docker.com/linux/static/stable/aarch64/docker-20.10.22.tgz'; \
			;; \
		*) echo >&2 "error: unsupported 'docker.tgz' architecture ($arch)"; exit 1 ;; \
	esac; \
	\
	wget -O 'docker.tgz' "$url"; \
	\
	tar --extract \
		--file docker.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
		--no-same-owner \
		'docker/docker' \
	; \
	rm docker.tgz; \
	\
	docker --version

ENV DOCKER_BUILDX_VERSION 0.9.1
RUN set -eux; \
	\
	arch="$(uname -m)"; \
	case "$arch" in \
		'x86_64') \
			url='https://github.com/docker/buildx/releases/download/v0.9.1/buildx-v0.9.1.linux-amd64'; \
			sha256='a7fb95177792ca8ffc7243fad7bf2f33738b8b999a184b6201f002a63c43d136'; \
			;; \
		'armhf') \
			url='https://github.com/docker/buildx/releases/download/v0.9.1/buildx-v0.9.1.linux-arm-v6'; \
			sha256='159925b4e679eb66e7f0312c7d57a97e68a418c1fa602a00dd8b29b6406768f0'; \
			;; \
		'armv7') \
			url='https://github.com/docker/buildx/releases/download/v0.9.1/buildx-v0.9.1.linux-arm-v7'; \
			sha256='ba8e5359ce9ba24fec6da07f73591c1b20ac0797a2248b0ef8088f57ae3340fc'; \
			;; \
		'aarch64') \
			url='https://github.com/docker/buildx/releases/download/v0.9.1/buildx-v0.9.1.linux-arm64'; \
			sha256='bbf6a76bf9aef9c5759ff225b97ce23a24fc11e4fa3cdcae36e5dcf1de2cffc5'; \
			;; \
		'ppc64le') \
			url='https://github.com/docker/buildx/releases/download/v0.9.1/buildx-v0.9.1.linux-ppc64le'; \
			sha256='1b2441886e556c720c1bf12f18f240113cc45f9eb404c0f162166ca1c96c1b60'; \
			;; \
		'riscv64') \
			url='https://github.com/docker/buildx/releases/download/v0.9.1/buildx-v0.9.1.linux-riscv64'; \
			sha256='c32372dad653fc70eb756b2cffd026e74425e807c01accaeed4559da881ff57c'; \
			;; \
		's390x') \
			url='https://github.com/docker/buildx/releases/download/v0.9.1/buildx-v0.9.1.linux-s390x'; \
			sha256='90b0ecf315d741888920dddeac9fe2e141123c4fe79465b7b10fe23521c9c366'; \
			;; \
		*) echo >&2 "warning: unsupported 'docker-buildx' architecture ($arch); skipping"; exit 0 ;; \
	esac; \
	\
	wget -O 'docker-buildx' "$url"; \
	echo "$sha256 *"'docker-buildx' | sha256sum -c -; \
	\
	plugin='/usr/libexec/docker/cli-plugins/docker-buildx'; \
	mkdir -p "$(dirname "$plugin")"; \
	mv -vT 'docker-buildx' "$plugin"; \
	chmod +x "$plugin"; \
	\
	docker buildx version

ENV DOCKER_COMPOSE_VERSION 2.14.2
RUN set -eux; \
	\
	arch="$(uname -m)"; \
	case "$arch" in \
		'x86_64') \
			url='https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-x86_64'; \
			sha256='d056a8330a01f22c249b9fa03ad0d5be889b79b648cad43c8549eb4c3f8ff0ba'; \
			;; \
		'armhf') \
			url='https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-armv6'; \
			sha256='164b04d5970f340eb6cb4da171b2dc0d12c345a6092c8ac2409b5fb4fc8af5e6'; \
			;; \
		'armv7') \
			url='https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-armv7'; \
			sha256='6e01028d97bc48bfd3894d9161586e74c0f37cf7d67a67ab7eafb351c2003cb3'; \
			;; \
		'aarch64') \
			url='https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-aarch64'; \
			sha256='48ef22ecea70b4b197def1c1bfd2e797f7117db5257f6e505e64f03fdc329a7e'; \
			;; \
		'ppc64le') \
			url='https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-ppc64le'; \
			sha256='8cbceb45fc656ec9f9e24b8e61fda54d233ecc8f46cee8ef5ae5acfdcc7940d4'; \
			;; \
		'riscv64') \
			url='https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-riscv64'; \
			sha256='e9d612ff8d198911f93706f4eec2bb58abb24c0f869cff7d69f6a8e24ce05420'; \
			;; \
		's390x') \
			url='https://github.com/docker/compose/releases/download/v2.14.2/docker-compose-linux-s390x'; \
			sha256='9fec4a8628729766f4600ec0f8fb5aa760b6a20673e1abfb3d78f3b2eb02696a'; \
			;; \
		*) echo >&2 "warning: unsupported 'docker-compose' architecture ($arch); skipping"; exit 0 ;; \
	esac; \
	\
	wget -O 'docker-compose' "$url"; \
	echo "$sha256 *"'docker-compose' | sha256sum -c -; \
	\
	plugin='/usr/libexec/docker/cli-plugins/docker-compose'; \
	mkdir -p "$(dirname "$plugin")"; \
	mv -vT 'docker-compose' "$plugin"; \
	chmod +x "$plugin"; \
	\
	ln -sv "$plugin" /usr/local/bin/; \
	docker-compose --version; \
	docker compose version

COPY modprobe.sh /usr/local/bin/modprobe
COPY docker-entrypoint.sh /usr/local/bin/

ENV DOCKER_TLS_CERTDIR=/certs
RUN mkdir /certs /certs/client && chmod 1777 /certs /certs/client

ENTRYPOINT ["docker-entrypoint.sh"]
CMD ["sh"]
