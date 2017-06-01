FROM node:7-alpine

EXPOSE 80

RUN apk add \
      --no-cache \
      xvfb \
      # Additionnal dependencies for better rendering
      ttf-freefont \
      fontconfig \
      dbus \
      # install bash, because node-wkhtmltopdf spawns it
      bash \

    # Install wkhtmltopdf from `testing` repository
    && apk add \
      --no-cache \
      --repository https://dl-3.alpinelinux.org/alpine/edge/testing/ \
      qt5-qtbase-dev \
      wkhtmltopdf \

    # Wrapper for xvfb
    && mv /usr/bin/wkhtmltopdf /usr/bin/wkhtmltopdf-origin \
    && echo $'#!/usr/bin/env sh\n\
Xvfb :0 -screen 0 1024x768x24 -ac +extension GLX +render -noreset & \n\
DISPLAY=:0.0 wkhtmltopdf-origin $@ \n\
killall Xvfb\
' > /usr/bin/wkhtmltopdf \
    && chmod +x /usr/bin/wkhtmltopdf

ENV PORT=80

WORKDIR /app
COPY . /app

RUN npm install --production

CMD [ "npm","run","start" ]
