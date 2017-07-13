FROM ubuntu:latest

# copy everything locally to the build directory
# this will end up getting deleted, don't refer to it outside of this build process
COPY . /base_build

ARG DEBIAN_FRONTEND=noninteractive
RUN /base_build/build_scripts/prepare.sh && \
    /base_build/build_scripts/setup-hpcaas.sh && \
    /base_build/build_scripts/cleanup.sh

ENV DEBIAN_FRONTEND="teletype" \
    LANG="en_US.UTF-8" \
    LANGUAGE="en_US:en" \
    LC_ALL="en_US.UTF-8"

ENV TINI_VERSION v0.15.0
ADD https://github.com/krallin/tini/releases/download/${TINI_VERSION}/tini /tini
RUN chmod +x /tini

ENTRYPOINT ["/tini", "--"]

CMD ["/start-runit.sh"]
