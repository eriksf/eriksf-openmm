FROM nvidia/cuda:12.9.1-cudnn-runtime-ubuntu24.04
LABEL maintainer="Erik Ferlanti <eferlanti@tacc.utexas.edu>"

# system updates
RUN apt update \
    && apt upgrade -y \
    && DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ca-certificates \
    cuda-command-line-tools-12-9 \
    bzip2 \
    vim-tiny  \
    wget \
    && apt autoremove -y \
    && apt clean \
    && rm -rf /var/lib/apt/lists/*

# install miniforge
ENV CONDA_DIR=/opt/conda
ENV PATH=${CONDA_DIR}/bin:${PATH}
RUN wget -q -P /tmp https://github.com/conda-forge/miniforge/releases/download/25.3.1-0/Miniforge3-25.3.1-0-Linux-aarch64.sh \
    && bash /tmp/Miniforge3-25.3.1-0-Linux-aarch64.sh -b -p $CONDA_DIR \
    && rm /tmp/Miniforge3-25.3.1-0-Linux-aarch64.sh \
    && conda config --system --set auto_update_conda false \
    && conda config --system --set show_channel_urls true \
    && conda config --system --set default_threads 4 \
    && conda install --yes --no-update-deps python=3.12 \
    && ln -s /opt/conda/etc/profile.d/conda.sh /etc/profile.d/conda.sh \
    && conda clean -ay

# install openmm
RUN conda install --yes --no-update-deps \
    openmm \
    cuda-version=12 \
    && conda clean -ay

