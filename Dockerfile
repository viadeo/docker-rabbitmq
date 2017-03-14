FROM google/debian:jessie

ADD rabbitmq-signing-key-public.asc /tmp/rabbitmq-signing-key-public.asc

RUN apt-key add /tmp/rabbitmq-signing-key-public.asc && \
  echo "deb http://www.rabbitmq.com/debian/ testing main" > /etc/apt/sources.list.d/rabbitmq.list && \
  apt-get -qq update > /dev/null && \
  apt-get install -y logrotate wget erlang erlang-nox && \
  wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.3.4/rabbitmq-server_3.3.4-1_all.deb -O /tmp/rabbitmq-server_3.3.4-1_all.deb && \
  dpkg -i /tmp/rabbitmq-server_3.3.4-1_all.deb && \
  apt-get clean && rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*
  
RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_management && \
  echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

EXPOSE 5672 15672 25672 4369

CMD ["/usr/sbin/rabbitmq-server"]
