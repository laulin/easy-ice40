if [[ "$EUID" -ne 0 ]]; then
  echo "You need to be root."
  exit 1
fi

add xhost +local:docker
docker run --rm -it \
  -e HOST_UID=$SUDO_UID \
  -e HOST_GID=$SUDO_GID \
  -e HOST_USER=$SUDO_USER \
  --name icestorm \
  -e HOME=/home/user \
  -v "$PWD:/work" \
  --privileged -v /dev:/dev \
  -e DISPLAY=$DISPLAY \
  -v /tmp/.X11-unix:/tmp/.X11-unix \
  icestorm