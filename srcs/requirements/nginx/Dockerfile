FROM alpine:3.21

COPY install.sh .
COPY nginx.conf /etc/nginx/nginx.conf
RUN chmod +x install.sh
RUN ./install.sh

CMD ["nginx", "-g", "daemon off;"]
