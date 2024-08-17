FROM node:22.6.0-alpine3.19

ARG APP_USERNAME
ARG APP_USER_ID
ARG APP_NAME
ARG APP_PORT

RUN apk update && apk upgrade \
  ; apk add --no-cache bash git jq openssh-client starship \
  ; rm -rf /var/cache/apk/* \
  ; USERNAME=$(getent passwd $APP_USER_ID | cut -d: -f1) || true \
  ; if [ -n "$USERNAME" ]; then deluser --remove-home $USERNAME || true; delgroup $USERNAME || true; fi \
  ; addgroup -g $APP_USER_ID $APP_USERNAME \
  ; adduser -D -G $APP_USERNAME -u $APP_USER_ID -s /bin/bash $APP_USERNAME \
  && echo 'eval "$(starship init bash)"' >> /home/$APP_USERNAME/.bashrc

USER $APP_USERNAME

WORKDIR /home/$APP_USERNAME/$APP_NAME

EXPOSE $APP_PORT
