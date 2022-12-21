FROM caffeinism/docker-cli:ubuntu

RUN set -eux; \
	apt install -y \
		btrfs-progs \
		e2fsprogs \
		iptables \
		openssl \
		uidmap \
		xfsprogs \
		pigz 

RUN set -eux; \
	addgroup --system dockremap; \
        adduser --system dockremap --ingroup dockremap; \
	echo 'dockremap:165536:65536' >> /etc/subuid; \
	echo 'dockremap:165536:65536' >> /etc/subgid

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
		--exclude 'docker/docker' \
	; \
	rm docker.tgz; \
	\
	dockerd --version; \
	containerd --version; \
	ctr --version; \
	runc --version

ENV DIND_COMMIT 1f32e3c95d72a29b3eaacba156ed675dba976cb5

RUN set -eux; \
	wget -O /usr/local/bin/dind "https://raw.githubusercontent.com/docker/docker/${DIND_COMMIT}/hack/dind"; \
	chmod +x /usr/local/bin/dind

COPY dockerd-entrypoint.sh /usr/local/bin/

VOLUME /var/lib/docker
EXPOSE 2375 2376

ENTRYPOINT ["dockerd-entrypoint.sh"]
CMD []
