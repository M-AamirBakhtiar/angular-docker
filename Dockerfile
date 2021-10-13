# Specify a Base Image for our Build Phase / Build Stage / Build Step
FROM node:alpine as builder

# Specify a Working Directory
WORKDIR /app

# Copy over package.json
COPY package.json .

# Install all the dependencies
RUN npm install

# Copy the rest of the code needed to run the application
COPY . .

# Build our application for Production
RUN npm run build


# Specify a Base Image for our Run Phase / Run Stage / Run Step
FROM nginx

# Copy over the build directory from our builder phase
COPY --from=builder /app/dist/frontend /usr/share/nginx/html 

# Expose the Default port of Nginx
EXPOSE 80