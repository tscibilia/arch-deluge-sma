binhex/arch-delugevpn build with sickbeard_mp4_automator built in

/config/sma should contain the autoProcess.ini file with your settings

ffmpeg binaries will be auto downloaded and accessible at /usr/local/bin/ffmpeg/ffmpeg and /usr/local/bin/ffmpeg/ffprobe

Additionally the python environment that has all the dependencies is sandboxed in a virtual environment
When setting up your script in Radarr use the following options
Path: `/usr/local/bin/sma/env/bin/python3`
Arg: `/usr/local/bin/sma/sickbeard_mp4_automator/postRadarr.py`

Sample docker-compose entry:
```
  delugevpn-sma:
    image: tscibilia/arch-deluge-sma
    container_name: delugevpn-sma
    volumes:
      - /mnt/appdata/deluge:/config
      - /mnt/appdata/data:/data
      - /mnt/media:/mnt/media
      - /mnt/appdata/sma/autoProcess.ini:/usr/local/bin/sma/sickbeard_mp4_automator/autoProcess.ini:ro
      - /etc/localtime:/etc/localtime:ro
    ports:
      - 8112:8112
      - 8118:8118
      - 58846:58846
      - 58849:58849
    environment:
      - VPN_USER=${VPNUSER}
      - VPN_PASS=${VPNPASS}
      - VPN_PROV=${VPNPROV}
      - STRICT_PORT_FORWARD=yes
      - VPN_ENABLED=yes
      - ENABLE_PRIVOXY=yes
      - LAN_NETWORK=${LAN}
      - NAME_SERVERS=${DNS}
      - PUID=${PUID}
      - PGID=${PGID}
    restart:
      always
```
