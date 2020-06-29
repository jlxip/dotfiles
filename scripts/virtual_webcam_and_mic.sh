#!/usr/bin/env zsh

echo $SHELL | grep zsh &> /dev/null
if [ $? -ne 0 ]; then
	echo 'This script needs zsh. For some reason.'
	exit -1
fi

# VIRTUAL WEBCAM
lsmod | grep v4l2loopback &> /dev/null
if [ $? -ne 0 ]; then
	echo 'Initializing v4l2loopback... Will require sudo.'
	sudo modprobe v4l2loopback
else
	echo 'v4l2loopback was already running. Nothing to do here.'
fi

systemctl status docker | grep 'inactive (dead)'
if [ $? -eq 0 ]; then
	echo 'Starting docker... Will require sudo.'
	sudo systemctl start docker
else
	echo 'Docker was already running.'
fi

containers=$(docker ps -a)
echo $containers | grep streaming-server &> /dev/null
if [ $? -ne 0 ]; then
	# TODO: make this automatic
	echo "Looks like you don't have a working \"codeworksio/streaming-server\" docker installed. Please, prepare it."
	exit -2
fi

ss=$(echo $containers | grep streaming-server)
cid=$(echo $ss | cut -d' ' -f1)
echo $ss | grep Exited &> /dev/null
if [ $? -eq 0 ]; then
	echo "Starting container $cid..."
	docker start $cid
else
	echo "Container $cid is already running."
fi

# VIRTUAL MICROPHONE
MIC_FIFO='/tmp/virtmic'
echo 'Starting virtual microphone...'
pactl load-module module-pipe-source source_name=virtmic file=$MIC_FIFO format=s16le rate=16000 channels=1 &> /dev/null
if [ $? -ne 0 ]; then
	echo 'Failed! :('
	exit -3
fi

echo 'Setting virtual microphone as default...'
pactl set-default-source virtmic &> /dev/null
if [ $? -ne 0 ]; then
	echo 'Failed! :('
	exit -4
fi

# Everything started.
STREAM_URI='rtmp://localhost/live/test'

echo -e "\n\nRun in another terminal (couldn't get this working):"
echo "ffmpeg -re -i $STREAM_URI -f v4l2 /dev/video0"

echo -e "\nRun as well:"
echo "ffmpeg -re -i $STREAM_URI -f s16le -ar 16000 -ac 1  - > $MIC_FIFO"

echo -e "\n\nThen, and only then, start streaming to $STREAM_URI"
echo 'Hit enter when finished for cleanup.'
read

echo 'Cleaning up...'
pactl unload-module module-pipe-source
