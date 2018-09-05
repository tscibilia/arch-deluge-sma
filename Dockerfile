FROM binhex/arch-delugevpn
MAINTAINER tscibilia

# copied from https://hub.docker.com/r/sabrsorensen/arch-delugevpn-mp4/~/dockerfile/
# get python3 and git, and install python libraries
RUN \
  pacman -Syu --needed --noconfirm git wget python2 python2-setuptools python2-pip && \
  pacman -Scc --noconfirm
# install pip, venv, and set up a virtual self contained python environment
RUN \
  python2 -m pip install --user --upgrade pip && \
  python2 -m pip install --user virtualenv && \
  mkdir /usr/local/bin/sma && \
  python2 -m virtualenv /usr/local/bin/sma/env && \
  /usr/local/bin/sma/env/bin/pip install setuptools \
    requests \
    requests[security] \
    requests-cache \
    babelfish \
    'guessit<2' \
    'subliminal<2' \
    'stevedore==1.19.1' \
    python-dateutil \
    qtfaststart \
    deluge-client \
    gevent && \
  pip2 install --no-cache-dir requests && \
  pip2 install --no-cache-dir requests[security] && \
  pip2 install --no-cache-dir requests-cache && \
  pip2 install --no-cache-dir babelfish && \
  pip2 install --no-cache-dir 'guessit<2' && \
  pip2 install --no-cache-dir 'subliminal<2' && \
  pip2 install --no-cache-dir 'stevedore==1.19.1' && \
  pip2 install --no-cache-dir python-dateutil && \
  pip2 install --no-cache-dir qtfaststart && \
  pip2 install --no-cache-dir deluge-client && \
  pip2 install --no-cache-dir gevent && \
# download repo
  git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git /usr/local/bin/sma/sickbeard_mp4_automator && \
# create logging directory
  mkdir /var/log/sickbeard_mp4_automator && \
  touch /var/log/sickbeard_mp4_automator/index.log && \
  chgrp -R users /var/log/sickbeard_mp4_automator && \
  chmod -R g+w /var/log/sickbeard_mp4_automator && \
# ffmpeg
  wget https://johnvansickle.com/ffmpeg/builds/ffmpeg-git-64bit-static.tar.xz -O /tmp/ffmpeg.tar.xz && \
  mkdir /usr/local/bin/ffmpeg && \
  tar -xJf /tmp/ffmpeg.tar.xz -C /usr/local/bin/ffmpeg --strip-components 1 && \
  chgrp -R users /usr/local/bin/ffmpeg && \
  chmod g+x /usr/local/bin/ffmpeg/ffmpeg && \
  chmod g+x /usr/local/bin/ffmpeg/ffprobe && \
# cleanup
  sed -i -e 's/#!\/usr\/bin\/env python/#!\/usr\/bin\/env python2/' /usr/local/bin/sma/sickbeard_mp4_automator/*.py && \
  ln -s /data /downloads && \
  rm -rf \
    /tmp/* \
    /var/tmp/*

