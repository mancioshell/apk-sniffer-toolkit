# Apk Sniffer Toolkit

This is a Docker image which enable developer to patch an Android Apk, injectiong frida server and to sniff traffic from an Android App patched with objection tool.

## Prerequisites

### Install a WSL Distribution (Windows Only)

```
wsl --install -d Ubuntu-20.04
wsl --setdefault Ubuntu-20.04
wsl --set-version Ubuntu-20.04 2
```

After that you have to install additional pacakges to your wsl distribution.

```
sudo apt-get update && apt get install linux-tools-virtual hwdata
sudo update-alternatives --install /usr/local/bin/usbip usbip `ls /usr/lib/linux-tools/*/usbip | tail -n1` 20ex
```

For more details to Windows Support to WSL Setup, please refer to: https://github.com/dorssel/usbipd-win/wiki/WSL-support#wsl-setup

### Enable USB Debug
- Enable USB Debug for your smartphone. Every smartphone have a particular procedure to enable it. Please refer to your own smartphone guide.
- Attach the Smartphone to your PC USB

### Attach the smartphone USB port

You have to looking for the id of your smartphone USB port.

```
usbipd wsl list
```

This is an output example:

```

C:\Users\myuser>usbipd wsl list
BUSID  VID:PID    DEVICE                                                        STATE
2-7    1b1c:1b39  Dispositivo di input USB                                      Not attached
2-11   046d:c53a  Dispositivo di input USB                                      Not attached
2-13   18d1:4ee7  My Smartphone                                                 Not attached
2-14   0a12:0001  Generic Bluetooth Radio                                       Not attached
```

After identified it, you have to attach the related BusID to your WSL distribution.

```
usbipd wsl attach --busid 2-13 # replace 2-13 with your ID
```

## Build & Run

### Build Docker Image

Build your docker image with the following command:

```
docker build -t mancioshell/mobile-app-sniffing-tools .
```

You could modify the name of your image as you whish.

### Patch APK

You have to patch your installed app. Please replace YOUR_PACKAGE with the app package. i.e. **it.quadronica.leghe** .
```
docker run -t -i --name apk-sniffer-toolkit --rm --privileged -v /dev/bus/usb:/dev/bus/usb mancioshell/mobile-app-sniffing-tools patch-apk YOUR_PACKAGE 
# replace YOUR_PACKAGE with the package of your app
```

### Proxy Redirect

Set Http Proxy in the settings of your Device wifi. For example if you are planning to use **mitmproxy** in your PC to sniff the traffic of you app, set it to *PC_IP:8080*, where PC_IP is the ip address of your PC.

Start you MITM Proxy, in your PC.

### Launch the app and sniff it

Launch the patched APP in your mobile device.
Tha app will hang at the splash screen. Then launch this command to disable SSL Pinning, and start to navigate the app to sniff the HTTP traffic.

```
docker run -t -i --name apk-sniffer-toolkit --rm --privileged -v /dev/bus/usb:/dev/bus/usb mancioshell/mobile-app-sniffing-tools sslpinning
```