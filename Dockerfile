################## Base Image ##########
ARG PYTHON_VERSION="3.8.0"
FROM --platform=linux/amd64 python:${PYTHON_VERSION}-slim

################## ARGUMENTS/Environments ##########
ARG BUILD_DATE
ARG BUILD_VERSION
ARG LICENSE="Apache-2.0"
ARG BEDTOOLS2_VERSION="2.30.0"
ARG ATHENA_VERSION
ARG VCS_REF

################## METADATA ########################
LABEL org.opencontainers.image.vendor="MSKCC"
LABEL org.opencontainers.image.authors="Carmelina Charalambous (charalk@mskcc.org), Eric Buehler (buehlere@mskcc.org)"

LABEL org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.version=${BUILD_VERSION} \
    org.opencontainers.image.licenses=${LICENSE} \
    org.opencontainers.image.version.athena=${ATHENA_VERSION} \
    org.opencontainers.image.version.bedtools2=${BEDTOOLS2_VERSION} \
    org.opencontainers.image.vcs-url="https://github.com/msk-access/athena.git" \
    org.opencontainers.image.vcs-ref=${VCS_REF}

LABEL org.opencontainers.image.description="This container uses python3.9.7 as the base image to build \
    msk-access version of athena ${ATHENA_VERSION}"

################## INSTALL ##########################
RUN apt-get -y update \
    && apt-get install -y build-essential wget libz-dev
# install athena dependencies 
RUN cd /usr/bin \ 
    && wget https://github.com/arq5x/bedtools2/releases/download/v2.30.0/bedtools.static.binary \
    && chmod +x bedtools.static.binary \ 
    && ln -s ./bedtools.static.binary bedtools 

# Set work directory
WORKDIR /app

# Install dependencies
COPY requirements.txt /app/
RUN pip install --upgrade pip \
    && pip install -r requirements.txt

# Copy project
ADD . /app
CMD ["bash"]
