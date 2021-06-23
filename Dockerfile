FROM alpine:3.14.0
LABEL maintainer="Pace Engineers <docker-maint@pace.engineering>"

COPY entrypoint.sh /entrypoint.sh
RUN chmod +x entrypoint.sh

RUN apk --update --no-cache add rsync=3.2.3-r2 \
					   			openssh-client-default=8.6_p1-r2

ENTRYPOINT ["/entrypoint.sh"]
