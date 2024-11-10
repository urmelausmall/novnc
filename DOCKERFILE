FROM alpine:latest

RUN apk add git py3-pip py3-numpy && pip3 install websockify \
    && git clone -b v1.5.0 https://github.com/novnc/noVNC.git /app \
    && cd /app && rm -rf .git

# This port exposes the webserver
ENV PORT 6080
# This is the IP address NoVNC connects to
ENV VNC 10.1.2.3:5015

CMD ["/bin/sh", "-c", "websockify --web /app ${PORT} ${VNC}"]
# Expose the default port
EXPOSE 6080
