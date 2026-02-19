FROM nginx:alpine
COPY ["joyeux anniversaire Juliana.html", "/usr/share/nginx/html/index.html"]
COPY . /usr/share/nginx/html/
