FROM debian:9-slim
LABEL maintainer "avpnusr"

RUN apt-get update && apt-get install -y \
	curl gnupg ca-certificates apt-transport-https \
        --no-install-recommends \
	&& echo "deb https://updates.signal.org/desktop/apt xenial main" >> /etc/apt/sources.list.d/signal.list \
	&& curl -s https://updates.signal.org/desktop/apt/keys.asc | apt-key add - \
	&& apt-get update && apt-get -y install signal-desktop libgtk-3-0 --no-install-recommends \
        && apt-get purge --auto-remove -y curl gnupg apt-transport-https \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* ~/.gnupg \
        && useradd -r -m -u 1000 -G audio,video signal 

COPY asound.conf /etc/asound.conf

# Run Signal as non privileged user
USER signal

# Autorun Signal
ENTRYPOINT [ "signal-desktop" ]
