FROM ncareol/centos:5.11-0

ENV PHP_VERSION 5.2.17

ENV PACKAGES_KEEP gtk+ libX11.i386 netcdf.i386 libgcc.i386 fonts-ISO8859-2
ENV PACKAGES gcc gcc-gfortran pkgconfig make glibc-utils glibc-devel ncurses-devel
ENV PACKAGES_i386 gtk+-devel.i386 glibc-devel.i386 glib-devel.i386 libXi-devel.i386 libXext-devel.i386 libX11-devel.i386  netcdf-devel.i386

RUN yum -y downgrade libselinux \
    && yum -y install $PACKAGES_KEEP $PACKAGES $PACKAGES_i386 

# Initial setup
RUN yum update -y
RUN yum groupinstall -y 'Development Tools'

# Apache installation
RUN yum install -y httpd httpd-devel
RUN yum install -y mysql mysql-server

# PHP 5.2 dependency installation
RUN yum install -y \
  libaio-devel \
  libmcrypt-devel \
  libjpeg-devel \
  libpng-devel \
  libxml2-devel \
  libxslt-devel \
  curl-devel \
  freetype-devel \
  gmp-devel \
  mysql-devel \
  openssl-devel \
  sqlite-devel
WORKDIR /usr/local/src

# PHP 5.2 installation
ADD http://museum.php.net/php5/php-${PHP_VERSION}.tar.bz2 /usr/local/src/
RUN tar xf ./php-${PHP_VERSION}.tar.bz2 -C ./
WORKDIR /usr/local/src/php-${PHP_VERSION}
RUN ./configure \
  --enable-gd-native-ttf \
  --enable-mbregex \
  --enable-mbstring \
  --enable-soap \
  --enable-zend-multibyte \
  --enable-zip \
  --with-apxs2 \
  --with-curl \
  --with-freetype-dir=/usr \
  --with-gd \
  --with-gettext \
  --with-gmp \
  --with-jpeg-dir=/usr \
  --with-mcrypt \
  --with-mysql-sock \
  --with-openssl \
  --with-pear \
  --with-pdo-mysql \
  --with-png-dir=/usr \
  --with-xsl \
  --with-zlib
RUN make && make test && make install

# Apache setup and launching
COPY ./httpd.conf /etc/httpd/conf/extra.conf
RUN echo 'Include /etc/httpd/conf/extra.conf' >> /etc/httpd/conf/httpd.conf
EXPOSE 80

VOLUME [ "/data", "/var/www/html" ]

CMD [ "/usr/sbin/httpd", "-D", "FOREGROUND" ]
