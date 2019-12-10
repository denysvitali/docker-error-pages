FROM alpine
RUN apk --no-cache add nginx git
RUN git clone https://github.com/denysvitali/nginx-error-pages /srv/http/default
RUN mkdir -p /etc/nginx/snippets && \
      mkdir -p /run/nginx && \
      cp /srv/http/default/snippets/error_pages.conf /etc/nginx/snippets/ && \
      touch /etc/nginx/snippets/error_pages_content.conf && \
      sed -i -E 's/internal;//g' /etc/nginx/snippets/error_pages.conf && \
      echo $'server { listen 80 default_server; include /etc/nginx/snippets/error_pages.conf; }\n' > /etc/nginx/conf.d/default.conf
CMD ["/usr/sbin/nginx", "-g", "daemon off;"]
