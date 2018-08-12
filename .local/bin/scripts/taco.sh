#! /bin/sh
#
# taco.sh
#
# TODO implement custom date option
#
# TODO implement duplex command line option

scanimage\
    -d imagescan:esci:usb:/sys/devices/pci0000:00/0000:00:1d.0/usb2/2-1/2-1.2/2-1.2:1.0\
    --resolution 300\
    --scan-area Letter/Portrait\
    --mode Monochrome\
    --threshold 150\
    --batch=$(date +%Y%m%d_%H%M%S)_p%04d.tiff\

convert *.tiff $(date +%Y-%m-%d).pdf

rm *.tiff

mv --backup=t $(date +%Y-%m-%d).pdf $HOME/raw 

mupdf $HOME/raw/$(date +%Y-%m-%d).pdf &
