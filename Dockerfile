FROM debian:stable-slim
LABEL maintainer "avpnusr"

RUN apt-get update && apt-get install -y \
        curl gnupg ca-certificates apt-transport-https \
        --no-install-recommends \
        && echo 'deb [arch=amd64 signed-by=/usr/share/keyrings/signal-desktop-keyring.gpg] https://updates.signal.org/desktop/apt xenial main' > /etc/apt/sources.list.d/signal.list \
        && curl https://updates.signal.org/desktop/apt/keys.asc | gpg --dearmor > /usr/share/keyrings/signal-desktop-keyring.gpg \
        && apt-get update && apt-get -y install signal-desktop libgtk-3-0 libx11-xcb1 --no-install-recommends \
        && chmod 4755 /opt/Signal/chrome-sandbox \
        && update-mime-database /usr/share/mime \
        && apt-get purge --auto-remove -y curl gnupg apt-transport-https \
        && apt-get clean \
        && rm -rf /var/lib/apt/lists/* ~/.gnupg \
        && useradd -r -m -u 1000 -G audio,video signal

COPY asound.conf /etc/asound.conf

# Run Signal as non privileged user
USER signal

# Autorun Signal
ENTRYPOINT [ "signal-desktop", "--no-sandbox", "--in-process-gpu" ]
