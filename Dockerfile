FROM yfix/baseimage

MAINTAINER Yuri Vysotskiy (yfix) <yfix.dev@gmail.com>

RUN cd /tmp \
  && pkg="zabbix-release_3.0-1+trusty_all.deb" \
  && wget -q http://repo.zabbix.com/zabbix/3.0/ubuntu/pool/main/z/zabbix-release/$pkg \
  && dpkg -i $pkg \
  \
  && apt-get update \
  && apt-get install -y --no-install-recommends \
    zabbix-agent \
  \
  && apt-get purge -y --auto-remove \
    mysql-client \
    apache2-bin \
    autoconf \
    automake \
    autotools-dev \
    binutils \
    cpp \
    gcc \
  \
  && apt-get clean -y \
  && rm -rf /var/lib/apt/lists/* \
  && rm -rf /tmp/* \
  && rm -rf /usr/{{lib,share}/share/{man,doc,info,gnome/help,cracklib},{lib,lib64}/gconv} \
  \
  && echo "==== Done ==="

COPY docker /

VOLUME ["/etc/zabbix/"]

EXPOSE 10050

ENTRYPOINT ["/usr/sbin/zabbix_agentd"]
