# Author: LeonXu
# https://github.com/goodnighthsu/perfectdocker
# Install swift:3.0.2 perfect mysql

FROM swift:3.0.2
RUN apt-get update -q
RUN apt-get install openssl libssl-dev uuid-dev -q -y
RUN apt-get install libmysqlclient-dev -q -y
