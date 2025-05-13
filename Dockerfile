# Stage 1: Build the React application
# Use an official Node.js LTS Alpine image as the base
FROM node:18-alpine AS builder

# Set the working directory inside the container
WORKDIR /app

# Copy package.json and package-lock.json (or yarn.lock)
# Copying these first leverages Docker layer caching
COPY package*.json ./

# Install project dependencies based on the lock file for reproducibility
RUN npm install --frozen-lockfile

# Copy the rest of the application source code
COPY . .

# Build the React application for production
# This creates an optimized build in the /app/build directory
RUN npm run build

# ---

# Stage 2: Serve the application using Nginx
# Use a lightweight stable Nginx Alpine image
FROM nginx:stable-alpine

# Copy the optimized build output from the 'builder' stage
# into Nginx's default web server directory
COPY --from=builder /app/build /usr/share/nginx/html

# Copy the custom Nginx configuration file to handle SPA routing
# This file should be present in the build context (your project root)
COPY nginx.conf /etc/nginx/conf.d/default.conf

# Expose port 80 (the default port Nginx listens on)
EXPOSE 80

# Command to run Nginx in the foreground when the container starts
# The '-g "daemon off;"' directive is crucial for Docker containers
CMD ["nginx", "-g", "daemon off;"]
