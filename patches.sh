#!/bin/sh

notfound=""
for i in wget tar quilt gunzip
do
  if ! which $i >/dev/null 2>&1
  then
    notfound="$notfound $i"
  fi
done
if test "$notfound"
then
  if which yum >/dev/null 2>&1
  then
    /bin/echo -en 1>&2 "Please run\n  yum install"
  elif which apt-get >/dev/null 2>&1
  then
    /bin/echo -en 1>&2 "Please run\n  apt-get install"
  else
    /bin/echo -en 1>&2 "Please install\n "
  fi
  echo 1>&2 "$notfound"
  echo 1>&2 before executing this script.
  exit 1
fi

#wget http://www.kernel.org/pub/linux/kernel/v6.x/linux-6.6.7.tar.xz
#tar -Jxvf linux-6.6.7.tar.xz
#mv linux-6.6.7 linux-6.6.7-rt18
#cd linux-6.6.7-rt18
mkdir patches
cd patches
wget https://www.osadl.org/monitoring/patches/rfs0/series
for i in `cat series`
do
  wget https://www.osadl.org/monitoring/patches/rfs0/$i
done
cd ..

quilt push -a

wget https://www.osadl.org/monitoring/configs/rfs0.config.gz
gunzip rfs0.config.gz
mv rfs0.config .config


echo The kernel linux-6.6.7-rt18 is now ready to be compiled for x86 Intel Xeon E5-2650 @2000 MHz.

