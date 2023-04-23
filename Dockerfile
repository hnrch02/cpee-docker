FROM phusion/baseimage:jammy-1.0.1

RUN apt-get update && apt-get install -y \
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
									libicu-dev \
									redis \
									vim \
									curl \
									nginx
RUN gem install cpee \
				cpee-logging-xes-yaml \
				cpee-instantiation
RUN cd /run && cpee new flow
RUN cd /run && cpee-instantiation start
RUN cd /run && cpee-logging-xes-yaml new cpee-log
RUN cd /run && cpee cpui cpee-ui

COPY config/cpee.rb /run/flow/cpee-opts.rb
RUN cd /run/flow && sed -i '/use CPEE::implementation(opts)/e cat cpee-opts.rb' cpee
RUN rm -f /run/flow/cpee-opts.rb
RUN cd /run/flow && ln -s /run/redis.sock redis.sock

RUN cd /var/www && ln -s /run/cpee-log/logs
RUN cd /var/www && ln -s /run/cpee-ui flow
RUN cd /var/www && ln -s /run/cpee-ui/js_libs js_libs
COPY index.html /var/www/index.html
COPY config.json /var/www/flow/config.json
COPY config/nginx-localhost.conf /etc/nginx/sites-available/default
COPY config/redis.conf /etc/redis/redis.conf

COPY runit /runit
RUN cd /runit; \
	for service in *; do \
		mkdir /etc/service/$service; \
		cp $service /etc/service/$service/run; \
		chmod +x /etc/service/$service/run; \
	done
RUN rm -rf /runit

RUN apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

CMD ["/sbin/my_init"]
EXPOSE 80