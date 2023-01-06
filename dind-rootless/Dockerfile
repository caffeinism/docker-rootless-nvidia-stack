FROM caffeinism/docker-dind:ubuntu

RUN apt install -y iproute2 fuse-overlayfs

RUN mkdir /run/user && chmod 1777 /run/user

RUN set -eux; \
	adduser --home /home/rootless -u 100000 rootless; \
	echo 'rootless:165536:65536' >> /etc/subuid; \
	echo 'rootless:165536:65536' >> /etc/subgid

RUN set -eux; \
	\
	arch="$(uname -m)"; \
	case "$arch" in \
		'x86_64') \
			url='https://download.docker.com/linux/static/stable/x86_64/docker-rootless-extras-20.10.22.tgz'; \
			;; \
		'aarch64') \
			url='https://download.docker.com/linux/static/stable/aarch64/docker-rootless-extras-20.10.22.tgz'; \
			;; \
		*) echo >&2 "error: unsupported 'rootless.tgz' architecture ($arch)"; exit 1 ;; \
	esac; \
	\
	wget -O 'rootless.tgz' "$url"; \
	\
	tar --extract \
		--file rootless.tgz \
		--strip-components 1 \
		--directory /usr/local/bin/ \
		'docker-rootless-extras/rootlesskit' \
		'docker-rootless-extras/rootlesskit-docker-proxy' \
		'docker-rootless-extras/dockerd-rootless.sh' \
		'docker-rootless-extras/vpnkit' \
	; \
	rm rootless.tgz; \
	wget -O slirp4netns https://github.com/rootless-containers/slirp4netns/releases/download/v1.2.0/slirp4netns-$(uname -m); \
	chmod +x slirp4netns; \
	mv slirp4netns /usr/local/bin/slirp4netns; \
	\
	rootlesskit --version; \
	slirp4netns --version

RUN set -eux; \
	mkdir -p /home/rootless/.local/share/docker; \
	chown -R rootless:rootless /home/rootless/.local/share/docker
VOLUME /home/rootless/.local/share/docker

COPY dockerd-entrypoint.sh /usr/local/bin/
USER rootless
