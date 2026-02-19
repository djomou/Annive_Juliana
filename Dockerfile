FROM nginx:alpine
COPY . /usr/share/nginx/html
COPY ["joyeux anniversaire Juliana.html", "/usr/share/nginx/html/index.html"]
