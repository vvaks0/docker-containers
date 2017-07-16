FROM vvaks/hbase-nozk:1.2.6

WORKDIR /opt

ADD install-phoenix.sh /opt/install-phoenix.sh
RUN ./install-phoenix.sh

WORKDIR /opt/hbase/bin

CMD /opt/hbase/bin/start-pseudo-distributed.sh