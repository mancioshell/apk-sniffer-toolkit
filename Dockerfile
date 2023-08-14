FROM python:3.10.5-slim-buster

WORKDIR /usr/src/app

RUN mkdir bin

RUN apt-get update && apt-get install -y curl android-tools-adb apksigner aapt zipalign usbutils unzip git openjdk-11-jdk
RUN curl -fsSL https://github.com/iBotPeaches/Apktool/releases/download/v2.8.1/apktool_2.8.1.jar -o /usr/src/app/bin/apktool.jar
RUN chmod a+x /usr/src/app/bin/apktool.jar

RUN pip install mitmproxy
RUN pip3 install frida-tools
RUN pip3 install objection

COPY data/apktool.sh /usr/local/bin/apktool
COPY data/apksigner.sh /usr/local/bin/apksigner

RUN git clone https://github.com/TheDauntless/patch-apk.git
RUN cd /usr/src/app/patch-apk && pip install -r requirements.txt

COPY scripts/patch-apk.sh /usr/local/bin/patch-apk
COPY scripts/sslpinning.sh /usr/local/bin/sslpinning