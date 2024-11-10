FROM alpine:3.18

# Install essential tools and dependencies in one step
RUN apk update && \
    apk add --no-cache \
        git \
        python3 \
        py3-pip \
        build-base \
        python3-dev \
        py3-setuptools \
        libffi-dev \
        openssl-dev \
        ca-certificates && \
    update-ca-certificates && \
    # Upgrade pip and setuptools
    pip3 install --no-cache-dir --upgrade pip setuptools && \
    # Install websockify
    pip3 install --no-cache-dir websockify

# Clone the specified version of noVNC and clean up .git directory
RUN git clone -b v1.5.0 https://github.com/novnc/noVNC.git /app && \
    rm -rf /app/.git

WORKDIR /app

# Define environment variables with corrected format
ENV PORT=6080
ENV VNC=10.1.2.3:5015

# Expose the port for the web server
EXPOSE 6080

# Set the command to start websockify
CMD ["sh", "-c", "websockify --web /app ${PORT} ${VNC}"]
