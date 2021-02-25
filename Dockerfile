FROM openjdk:11.0.10-jre

ENV GATLING_VERSION 3.5.1
ENV KUBECTL_VERSION v1.20.0
ENV AWSCLI_VERSION 2.0.30

RUN mkdir /workdir && cd /workdir
WORKDIR /workdir


RUN apt-get update \
    && apt-get install -y unzip

# install awscli
RUN wget -O awscliv2.zip https://awscli.amazonaws.com/awscli-exe-linux-x86_64-$AWSCLI_VERSION.zip \
    && unzip awscliv2.zip \
    && ./aws/install \
    && rm -rf aws*

# install kubectl
RUN wget -O kubectl https://dl.k8s.io/release/$KUBECTL_VERSION/bin/linux/amd64/kubectl && \
    chmod a+x ./kubectl  &&  \
    mv ./kubectl /usr/local/bin/kubectl

# install gatling
RUN set -o errexit -o nounset && \
	echo "Downloading Gatling" && \
	wget -O gatling.zip "https://repo1.maven.org/maven2/io/gatling/highcharts/gatling-charts-highcharts-bundle/$GATLING_VERSION/gatling-charts-highcharts-bundle-$GATLING_VERSION-bundle.zip" && \
	echo "Installing gatling" && \
	unzip gatling.zip && \
	rm gatling.zip
ENV GATLING_HOME=/workdir/gatling-charts-highcharts-bundle-$GATLING_VERSION
RUN ln -s /workdir/gatling-charts-highcharts-bundle-$GATLING_VERSION/bin/gatling.sh /usr/local/bin/gatling && chmod a+x /usr/local/bin/gatling