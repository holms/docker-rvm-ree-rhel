FROM centos:7
MAINTAINER Roman Gorodeckij <it@swingcats.lt>

RUN mkdir -p /usr/local/rvm/bin
ENV PATH /usr/local/rvm/bin:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin

RUN yum update -y \
        && yum groupinstall -y 'Development Tools' \
        && yum install -y which git libyaml-devel readline-devel zlib-devel libffi-devel openssl-devel sqlite-devel \
        && echo 'export rvm_prefix="$HOME"' > /root/.rvmrc \
        && echo 'export rvm_path="$HOME/.rvm"' >> /root/.rvmc \
        && gpg2 --keyserver hkp://keys.gnupg.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 \
        && curl -sSL https://get.rvm.io | bash -s stable \
        && /bin/bash -l -c "source /etc/profile.d/rvm.sh" \
        && /bin/bash -l -c "rvm install ruby-1.8.7-head -n rg142 --verbose" \
        && /bin/bash -l -c "rvm --default use ruby-1.8.7-head-rg142" \
        && yum groupremove -y "Development Tools" \
        && yum remove -y libyaml-devel readline-devel zlib-devel  openssl-devel sqlite-devel


