FROM centos/systemd

MAINTAINER "Your Name" <you@example.com>
#docker run --privileged -v /sys/fs/cgroup:/sys/fs/cgroup:ro -p 5901:5901 -d di
#docker build --rm --no-cache -t di .

RUN yum -y install cabextract bind-utils traceroute net-tools bash-completion tigervnc-server vim git wget epel-release
RUN yum -y install python2-pip

# pip install
RUN pip install --upgrade pip; pip install sshuttle

# install config vnc
RUN yum -y group install GNOME Desktop
RUN systemctl stop firewalld.service; systemctl disable firewalld.service

RUN cp /lib/systemd/system/vncserver@.service /etc/systemd/system/vncserver@:1.service
RUN sed -e 's|<USER>|root|' -e 's|/home||' -i /etc/systemd/system/vncserver@:1.service

RUN systemctl daemon-reload; systemctl enable vncserver@:1.service
RUN echo -e "111111\n111111\nn\n" | vncpasswd

# install wine
RUN yum -y groupinstall 'Development Tools'
RUN yum -y install libX11-devel freetype-devel alsa-lib-devel.i686 libsndfile-devel.i686 readline-devel.i686 glib2.i686 glibc-devel.i686 libgcc.i686 libstdc++-devel.i686 pulseaudio-libs-devel.i686 cmake  audiofile-devel.i686 freeglut-devel.i686  libieee1284-devel.i686 openldap-devel.i686 unixODBC-devel.i686 sane-backends-devel.i686 fontforge  isdn4k-utils-devel.i686 mesa-libGL-devel.i686 libXxf86dga-devel.i686 libXxf86vm-devel.i686 giflib-devel.i686 cups-devel.i686 gsm-devel.i686 libv4l-devel.i686 fontpackages-devel ImageMagick-devel.i686  libX11-devel.i686 docbook-utils-pdf libtextcat tex-cm-lgc alsa-lib-devel audiofile-devel.i686 audiofile-devel cups-devel.i686 cups-devel dbus-devel.i686 dbus-devel fontconfig-devel.i686 fontconfig-devel freetype.i686 freetype-devel.i686 freetype-devel giflib-devel.i686 giflib-devel  libICE-devel.i686 libICE-devel libjpeg-turbo-devel.i686 libjpeg-turbo-devel libpng-devel.i686 libpng-devel libSM-devel.i686 libSM-devel libusb-devel.i686 libusb-devel libX11-devel.i686 libX11-devel libXau-devel.i686 libXau-devel libXcomposite-devel.i686 libXcomposite-devel libXcursor-devel.i686 libXcursor-devel libXext-devel.i686 libXext-devel libXi-devel.i686 libXi-devel libXinerama-devel.i686 libXinerama-devel libxml2-devel libXrandr-devel.i686 libXrandr-devel libXrender-devel.i686 libXrender-devel libxslt-devel.i686 libxslt-devel libXt-devel.i686 libXt-devel libXv-devel.i686 libXv-devel libXxf86vm-devel.i686 libXxf86vm-devel mesa-libGL-devel.i686 mesa-libGL-devel  ncurses-devel.i686 ncurses-devel openldap-devel.i686 openldap-devel openssl-devel.i686 openssl-devel zlib-devel.i686 pkgconfig sane-backends-devel.i686 sane-backends-devel xorg-x11-proto-devel glibc-devel.i686 prelink fontforge flex bison libstdc++-devel.i686 pulseaudio-libs-devel.i686 gnutls-devel.i686  isdn4k-utils-devel.i686 gsm-devel.i686 samba-winbind libv4l-devel.i686 cups-devel.i686 libtiff-devel.i686 gstreamer-devel.i686 gstreamer-plugins-base-devel.i686 gettext-devel.i686 libgphoto2-devel.i686 libxml2-devel.i686

# RUN cd; wget http://dl.winehq.org/wine/source/2.x/wine-2.22.tar.xz; tar xJf wine-2.22.tar.xz; cd wine-2.22; ./configure --without-krb5; make -j60; make install

RUN yum clean all

CMD ["/usr/sbin/init"]
