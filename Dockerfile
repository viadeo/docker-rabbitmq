FROM dockerfile/java

RUN apt-get install -y erlang erlang-nox

RUN wget http://www.rabbitmq.com/releases/rabbitmq-server/v3.3.4/rabbitmq-server_3.3.4-1_all.deb -O /tmp/rabbitmq-server_3.3.4-1_all.deb
RUN dpkg -i /tmp/rabbitmq-server_3.3.4-1_all.deb
RUN /usr/sbin/rabbitmq-plugins enable rabbitmq_management
RUN echo "[{rabbit, [{loopback_users, []}]}]." > /etc/rabbitmq/rabbitmq.config

EXPOSE 5672 15672 25672 4369
CMD ["/usr/sbin/rabbitmq-server"]