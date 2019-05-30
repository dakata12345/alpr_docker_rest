FROM ubuntu:14.04
MAINTAINER Ionescu Valentin-Alexandru "ionescuvalentin38@yahoo.com"

# Instaleaza bibliotecile necesare
RUN apt-get update && apt-get install -y \
    build-essential \
    cmake \
    curl \
    git \
    libcurl3-dev \
    libleptonica-dev \
    liblog4cplus-dev \
    libopencv-dev \
    libtesseract-dev \
    wget \
    git \
    python-dev \
    python-pip

RUN pip install Werkzeug==0.14.1 flask flask-restful 

WORKDIR /home
RUN wget -O - http://deb.openalpr.com/openalpr.gpg.key | sudo apt-key add -
RUN echo "deb http://deb.openalpr.com/master/ openalpr main" | sudo tee /etc/apt/sources.list.d/openalpr.list
RUN apt-get update
RUN apt-get install -y -f openalpr openalpr-daemon openalpr-utils libopenalpr-dev

WORKDIR /home
RUN git clone https://github.com/dakata12345/alpr_docker_rest.git
WORKDIR /home/alpr_docker_rest/alpr

EXPOSE 5000
CMD ["python", "restful-alpr.py"]
