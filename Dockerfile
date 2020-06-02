FROM debian:stretch-slim

RUN apt-get update; \
  apt-get install -y git make wget ca-certificates sudo build-essential libreadline-dev zlib1g-dev procps; \
  wget -q https://ftp.postgresql.org/pub/snapshot/dev/postgresql-snapshot.tar.bz2;  

RUN tar xvfj postgresql-snapshot.tar.bz2; \
  cd postgresql-13beta1; \
  ./configure; \
  make; \
  make install; 

RUN adduser --disabled-password --gecos "" postgres;\ 
  mkdir /usr/local/pgsql/data; \
  chown postgres /usr/local/pgsql/data; 

USER postgres
  
RUN /usr/local/pgsql/bin/initdb --auth=trust --auth-host=trust -D /usr/local/pgsql/data;\ 
  sed -ri "s!^#?(listen_addresses)\s*=\s*\S+.*!\1 = '*'!" /usr/local/pgsql/data/postgresql.conf;\
  echo "port = 5433" >> /usr/local/pgsql/data/postgresql.conf;\
  echo "host all  all    0.0.0.0/0 trust" >> /usr/local/pgsql/data/pg_hba.conf;\
  /usr/local/pgsql/bin/pg_ctl -D /usr/local/pgsql/data  start;

EXPOSE 5433

CMD ["/usr/local/pgsql/bin/postgres", "-D", "/usr/local/pgsql/data", "-c", "config_file=/usr/local/pgsql/data/postgresql.conf"]
