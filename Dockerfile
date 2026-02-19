FROM nginx:alpine
COPY ["joyeux anniversaire Juliana.html", "/usr/share/nginx/html/index.html"]
RUN cp "/usr/share/nginx/html/joyeux anniversaire Juliana.html" /usr/share/nginx/html/index.html
