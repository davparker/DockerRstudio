A Dockerfile to build a Docker Container running RStudio on Ubuntu Server 14.04 (latest)

I pieced this together from other Dockerfiles around the web for my particular needs.
A good starting point.

Basically includes R and RStudio on Ubuntu.

The only port exposed is tcp/8787, it maps to RStudio server's tcp/8787 port.

The default login is: 
  (username / password)
  rstudio / rstudio
