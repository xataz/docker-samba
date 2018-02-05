FROM xataz/alpine:3.7

LABEL description="samba based on alpine" \
      tags="latest" \
      maintainer="xataz <https://github.com/xataz>" \
      build_ver="2018020501"

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
