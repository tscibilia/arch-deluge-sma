FROM binhex/arch-delugevpn
MAINTAINER tscibilia

# copied from https://hub.docker.com/r/sabrsorensen/arch-delugevpn-mp4/~/docker$
# get python3 and git, and install python libraries
RUN \
  pacman -Syu --needed --noconfirm git wget python3 python-setuptools python-pi$
  pacman -Scc --noconfirm
# install pip, venv, and set up a virtual self contained python environment
RUN \
  python3 -m pip install --user --upgrade pip && \
  python3 -m pip install --user virtualenv && \
  mkdir /usr/local/bin/sma && \
  python3 -m virtualenv /usr/local/bin/sma/env && \
  /usr/local/bin/sma/env/bin/pip install requests \
    requests[security] \
    requests-cache \
    babelfish \
    'guessit<2' \
    'subliminal<2' \
    'stevedore==1.19.1' \
    python-dateutil \
    qtfaststart && \
# download repo
  git clone https://github.com/mdhiggins/sickbeard_mp4_automator.git /usr/local$
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
  ln -s /downloads /data && \
  rm -rf \
    /tmp/* \
    /var/lib/apt/lists/* \
    /var/tmp/*
