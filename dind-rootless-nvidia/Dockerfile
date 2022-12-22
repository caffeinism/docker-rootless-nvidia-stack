FROM caffeinism/docker-dind-rootless:ubuntu

USER root

RUN apt install curl gpg -y

RUN distribution=$(. /etc/os-release;echo $ID$VERSION_ID) \
      && curl -fsSL https://nvidia.github.io/libnvidia-container/gpgkey | gpg --dearmor -o /usr/share/keyrings/nvidia-container-toolkit-keyring.gpg \
      && curl -s -L https://nvidia.github.io/libnvidia-container/$distribution/libnvidia-container.list | \
            sed 's#deb https://#deb [signed-by=/usr/share/keyrings/nvidia-container-toolkit-keyring.gpg] https://#g' | \
            tee /etc/apt/sources.list.d/nvidia-container-toolkit.list

RUN apt update && apt install nvidia-container-toolkit -y

RUN sed -i 's/^#root/root/' /etc/nvidia-container-runtime/config.toml
RUN sed -i 's/^#no-cgroups = false/no-cgroups = true/' /etc/nvidia-container-runtime/config.toml

RUN sed -i '2 i sleep 180' /usr/local/bin/dockerd-entrypoint.sh # TODO: waiting for nvidia-dirver container up
USER rootless
