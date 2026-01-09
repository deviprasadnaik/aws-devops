FROM --platform=linux/amd64 ubuntu:22.04

ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools
RUN apt-get update && apt-get install -y \
    curl wget git unzip python3 python3-pip build-essential ca-certificates gnupg software-properties-common \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# Add Amazon Corretto 17 repository and install x64 JDK
RUN wget -O- https://apt.corretto.aws/corretto.key | gpg --dearmor | tee /usr/share/keyrings/corretto-keyring.gpg \
    && echo "deb [signed-by=/usr/share/keyrings/corretto-keyring.gpg] https://apt.corretto.aws stable main" | tee /etc/apt/sources.list.d/corretto.list \
    && apt-get update \
    && apt-get install -y java-17-amazon-corretto-jdk \
    && apt-get clean

WORKDIR /workspace
CMD ["/bin/bash"]
