FROM ruby:2.5

# Installing Oracle instant client
WORKDIR    /opt/oracle
RUN        apt-get update && apt-get install -y gcc g++ make libaio1 wget unzip \
            && wget https://download.oracle.com/otn_software/linux/instantclient/195000/instantclient-basic-linux.x64-19.5.0.0.0dbru.zip \
            && unzip instantclient-basic-linux.x64-19.5.0.0.0dbru.zip \
            && rm -f instantclient-basic-linux.x64-19.5.0.0.0dbru.zip \
            && wget https://download.oracle.com/otn_software/linux/instantclient/195000/instantclient-sqlplus-linux.x64-19.5.0.0.0dbru.zip \
            && unzip instantclient-sqlplus-linux.x64-19.5.0.0.0dbru.zip \
            && rm -f instantclient-sqlplus-linux.x64-19.5.0.0.0dbru.zip \
            && wget https://download.oracle.com/otn_software/linux/instantclient/195000/instantclient-sdk-linux.x64-19.5.0.0.0dbru.zip \
            && unzip instantclient-sdk-linux.x64-19.5.0.0.0dbru.zip \
            && rm -f instantclient-sdk-linux.x64-19.5.0.0.0dbru.zip \
            && cd /opt/oracle/instantclient* \
            && rm -f *jdbc* *occi* *mysql* *README *jar uidrvci genezi adrci \
            && echo /opt/oracle/instantclient* > /etc/ld.so.conf.d/oracle-instantclient.conf \
            && ldconfig

ENV LD_LIBRARY_PATH=/opt/oracle/instantclient_19_5

# Install NodeJS and Yarn
RUN apt-get update
RUN apt-get -y install curl
RUN apt-get install -my gnupg
RUN curl -sL https://deb.nodesource.com/setup_12.x | bash -
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | apt-key add -
RUN echo "deb https://dl.yarnpkg.com/debian/ stable main" | tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get -qqyy install nodejs yarn && rm -rf /var/lib/apt/lists/*

