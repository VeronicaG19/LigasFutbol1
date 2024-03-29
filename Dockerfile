#Stage 1 - Install dependencies and build the app
FROM debian:latest AS build-env

# Install flutter dependencies
ENV TZ=America/Mexico_City
RUN ln -snf /usr/share/zoneinfo/$TZ /etc/localtime && echo $TZ > /etc/timezone
RUN apt-get update 
RUN apt-get install -y curl git wget unzip libgconf-2-4 gdb libstdc++6 libglu1-mesa fonts-droid-fallback lib32stdc++6 python3
RUN apt-get clean

# Clone the flutter repo
RUN git clone https://github.com/flutter/flutter.git /usr/local/flutter

# Set flutter path
# RUN /usr/local/flutter/bin/flutter doctor -v
ENV PATH="/usr/local/flutter/bin:/usr/local/flutter/bin/cache/dart-sdk/bin:${PATH}"

# Run flutter doctor
RUN flutter doctor -v
# Enable flutter web
RUN flutter channel master
RUN flutter upgrade
RUN flutter config --enable-web

# Get App Dependencies
# RUN flutter pub get

# Copy files to container and build
RUN mkdir /app/
COPY . /app/
WORKDIR /app/
RUN dart pub upgrade
RUN flutter pub get
RUN flutter pub run build_runner build --delete-conflicting-outputs
RUN flutter pub cache repair
RUN flutter build web -t lib/ligas_futbol_dev.dart

#EXPOSE 8000

# Stage 2 - Create the run-time image
FROM nginx:1.21.1-alpine
COPY --from=build-env /app/build/web /usr/share/nginx/html

# RUN ["chmod", "+x", "/app/server/server.sh"]

# ENTRYPOINT ["/app/server/server.sh"]