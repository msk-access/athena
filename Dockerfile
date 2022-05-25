FROM python:3.8.0

LABEL maintainer="Carmelina Charalambous (charalk@mskcc.org)" \
      version.image="1.0.0" \
      version.athena="1.4.1" \
      source.athena="https://github.com/msk-access/athena/releases/tag/1.4.1"

ENV ATHENA_VERSION 1.4.1

RUN apt-get update \
      # for wget
            && apt-get install -y ca-certificates \
      # download, unzip, install
            && cd /tmp && wget https://github.com/msk-access/athena/archive/refs/tags/${ATHENA_VERSION}.zip \
            && unzip ${ATHENA_VERSION}.zip \
            && cd /tmp/athena-${ATHENA_VERSION} \
            && pip install -r requirements.txt \
      # copy to /usr/bin and make scripts executable
            && cp /tmp/athena-${ATHENA_VERSION}/bin/annotate_bed.py /usr/bin/ \
            && chmod +x /usr/bin/annotate_bed.py \
            && cp /tmp/athena-${ATHENA_VERSION}/bin/coverage_stats_single.py /usr/bin/ \
            && chmod +x /usr/bin/coverage_stats_single.py \
            && cp /tmp/athena-${ATHENA_VERSION}/bin/coverage_report_single.py /usr/bin/ \
            && chmod +x /usr/bin/coverage_report_single.py \
            && cp /tmp/athena-${ATHENA_VERSION}/bin/load_data.py /usr/bin/ \
            && chmod +x /usr/bin/load_data.py \
            && cp -r /tmp/athena-${ATHENA_VERSION}/data /usr/bin/ 
CMD ["bash"]
