FROM nvcr.io/nvidia/openmm:8.1.1

# system updates
RUN apt update \
    && apt upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python3-pip \
    vim-tiny  \
    && apt autoremove -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# install scipy
RUN pip install scipy
