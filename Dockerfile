# Stage 1: Build stage
FROM node:14 AS build

# Set the working directory
WORKDIR /app

# Copy package.json and package-lock.json
COPY package.json ./

# Install dependencies
RUN npm install

# Copy the rest of the application code
COPY . .

# Build the application (if there are any build steps)
# RUN npm run build

# Stage 2: Production stage
FROM node:14-slim

# Set the working directory
WORKDIR /app

# Copy the built application from the previous stage
COPY --from=build /app /app

# Expose the port the app runs on
EXPOSE 80

# Command to run the application
CMD ["npm", "start"]
