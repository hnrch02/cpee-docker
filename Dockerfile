FROM ubuntu:jammy AS build

RUN apt-get update && apt-get install --no-install-recommends -y \
									ruby \
									shared-mime-info \
									build-essential \
									ruby-dev \
									libxml2-dev \
									libxslt-dev \
									libz-dev \
									libssl-dev \
									librasqal-dev \
									libraptor2-dev \
									libicu-dev
RUN gem install --no-document \
				cpee \
				cpee-logging-xes-yaml \
				cpee-instantiation

FROM phusion/baseimage:jammy-1.0.1

COPY --from=build /var/lib/gems /var/lib/gems
COPY --from=build /usr/local/bin/ /usr/local/bin

RUN apt-get update && \
	apt-get install --no-install-recommends -y ruby redis nginx && \
	apt-get clean && \
	rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

COPY . /build
RUN /build/install.sh

CMD ["/sbin/my_init"]
EXPOSE 80