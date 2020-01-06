# Builder phase - this will create a temporary container
FROM node:alpine as builder
WORKDIR '/app'
COPY package.json .
RUN npm install
COPY . .
RUN npm run build

# Run Phase
# switch to nginx container to serve the built in the Build phase in Production
FROM nginx 
# COPY files from the build phase. we are only intersted in the built files so we will only COPY the files from the /app/build directory
COPY --from=builder /app/build  /usr/share/nginx/html