FROM ubuntu:latest

MAINTAINER David Parker <davparker@gmail.com>

# ###########################################################################
# R
# ###########################################################################


# Need this to add R repo
RUN apt-get update && apt-get install -y software-properties-common

# Add R apt repository
RUN add-apt-repository "deb http://cran.rstudio.com/bin/linux/ubuntu $(lsb_release -cs)/"
RUN apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E084DAB9

# Install basic stuff and R
RUN apt-get -y update && apt-get -y upgrade && apt-get -y install \
    vim-tiny \
    less \
    wget \
	gdebi-core \
	libapparmor1 \
	libssl-dev \
	libxml2-dev \
    r-base \
    r-base-dev \
    r-recommended

# ###########################################################################
# RStudio
# ###########################################################################

RUN wget https://s3.amazonaws.com/rstudio-server/current.ver -O "version.txt" && \
	VERSION=$(cat version.txt)  && \
	wget "http://download2.rstudio.org/rstudio-server-$VERSION-amd64.deb" -O rstudio.deb && \
	gdebi -n rstudio.deb && \
	rm -f version.txt rstudio.deb

RUN useradd -m -d /home/rstudio rstudio \
      && echo rstudio:rstudio | chpasswd
	
EXPOSE 8787

CMD ["/usr/lib/rstudio-server/bin/rserver", "--server-daemonize=0", "--server-app-armor-enabled=0"]
