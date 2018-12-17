FROM alpine:3.8

LABEL description="samba based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="201812172010"

EXPOSE 137 138 139 445

RUN apk add -U \
            samba \
            samba-common-tools \
            acl \
            bc \
            s6

COPY rootfs /
RUN chmod +x /usr/local/bin/startup   

CMD ["/usr/local/bin/startup"]        
