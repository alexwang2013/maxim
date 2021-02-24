FROM openjdk:8u151-jdk-alpine3.7

ENV GATLING_VERSION 3.5.1
ENV KUBECTL_VERSION v1.20.0

RUN mkdir /workdir && cd /workdir
WORKDIR /workdir



# install awscli
RUN apk add --no-cache \
        python3 \
        py3-pip \
    && pip3 install --upgrade pip \
    && pip3 install \
        awscli \
    && rm -rf /var/cache/apk/*

# install kubectl
RUN wget -O kubectl https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl && \
    chmod a+x ./kubectl  &&  \
    mv ./kubectl /usr/local/bin/kubectl

# install gatling
RUN set -o errexit -o nounset && \
    echo "Installing build dependencies" && \
	apk add --no-cache unzip && \
	echo "Downloading Gatling" && \
	wget -O gatling.zip "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip" && \
	echo "Installing gatling" && \
	unzip gatling.zip && \
	rm gatling.zip && \
	apk del unzip
ENV GATLING_HOME=/workdir/gatling-charts-highcharts-bundle-$GATLING_VERSION
RUN ln -s /workdir/gatling-charts-highcharts-bundle-$GATLING_VERSION/bin/gatling.sh /usr/local/bin/gatling && chmod a+x /usr/local/bin/gatling