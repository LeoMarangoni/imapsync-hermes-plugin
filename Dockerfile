# Dockerfile for building a docker imapsync image
# CHANGED user NOBODY to ROOT, nobody can't write the logfiles in the container.
# removed .dockerenv file cause the dockerenv don't write the log

#----------------------------------------#
#-------IMAPSYNC PLUGIN FOR HERMES-------#
#----------------------------------------#

FROM ubuntu:16.04

MAINTAINER Leo Marangoni <leonardo.marangoni@inova.net>

RUN apt-get update \
&& apt-get install -y \
git \
wget \
libauthen-ntlm-perl    \
libclass-load-perl     \
libcrypt-ssleay-perl   \
libcrypt-openssl-random-perl \
libcrypt-openssl-rsa-perl \
libdata-uniqid-perl    \
libdigest-hmac-perl    \
libdist-checkconflicts-perl \
libfile-copy-recursive-perl \
libio-compress-perl     \
libio-socket-inet6-perl \
libio-socket-ssl-perl   \
libio-tee-perl          \
libmail-imapclient-perl \
libmodule-scandeps-perl \
libnet-ssleay-perl      \
libpar-packer-perl      \
libreadonly-perl        \
libsys-meminfo-perl     \
libterm-readkey-perl    \
libtest-fatal-perl      \
libtest-mock-guard-perl \
libtest-pod-perl        \
libtest-requires-perl   \
libtest-simple-perl     \
libssl-dev \
libunicode-string-perl  \
liburi-perl             \
make                    \
cpanminus

RUN cpanm Mail::IMAPClient && \
    cpanm JSON::WebToken && \
    cpanm Crypt::OpenSSL::RSA && \
    cpanm LWP && \
    cpanm Test::MockObject && \
    cpanm Term::ReadLine

RUN https://raw.githubusercontent.com/LeoMarangoni/imapsync-hermes-plugin/master/imapsync && \
    chmod +x imapsync && \
    cp imapsync /usr/bin/ && \

RUN imapsync --testslive

USER root

CMD imapsync

# End of Dockerfile
