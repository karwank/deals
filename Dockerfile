# docker build -f Dockerfile . -t karwank/deals-ruby
# docker push karwank/deals-ruby
FROM ubuntu:18.04 AS deals-ruby
RUN apt-get update && apt-get install -y openssh-server openssh-client git imagemagick libmagickcore-dev libmagickwand-dev libmagick++-dev libxml2-dev libxslt1-dev sudo curl patch bzip2 gawk g++ gcc make patch automake libyaml-dev libsqlite3-dev sqlite3 libgdbm-dev libncurses5-dev bison libffi-dev libgmp-dev libreadline6-dev libssl-dev libpq-dev openssl nano libjemalloc-dev python-pip
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y tzdata
RUN curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add - && echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list
RUN apt-get update && apt-get install --no-install-recommends yarn
RUN curl -sL https://deb.nodesource.com/setup_10.x | sudo -E bash -
RUN sudo apt-get install -y nodejs
RUN useradd -ms /bin/bash deploy && echo deploy:passworddeploy | chpasswd –crypt-method=SHA512 && adduser deploy sudo
USER deploy
WORKDIR /home/deploy
RUN export PATH=~/.local/bin:$PATH
ENV APP_PATH /home/deploy/rails-app
RUN mkdir -p /home/deploy/rails-app
RUN mkdir ~/.gnupg
RUN echo "disable-ipv6" >> ~/.gnupg/dirmngr.conf
RUN gpg --keyserver hkp://pool.sks-keyservers.net --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
RUN \curl -sSL https://get.rvm.io | bash
RUN echo "source $HOME/.rvm/scripts/rvm" >> ~/.bash_profile && echo "export PATH=\"$PATH:$HOME/.rvm/bin\"" >> .bashrc
RUN  $HOME/.rvm/bin/rvm install 2.7.0 -C --with-jemalloc --disable-binary --autolibs=read-only
ENV PATH  = "$HOME/.rvm/bin:$HOME/.rvm/rubies/ruby-2.7.0:${PATH}"
WORKDIR $APP_PATH
# RUN rvm use --default 2.7.0 && rvm ruby-2.7.0 do rvm gemset create rails-app && rvm use 2.7.0@rails-app && gem install bundler