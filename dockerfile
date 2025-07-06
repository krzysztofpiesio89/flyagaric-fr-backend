# Use Node LTS base image
FROM node:18

# Create app directory
WORKDIR /app

# Copy dependencies
COPY package.json package-lock.json ./

# Install dependencies
RUN npm install

# Copy rest of the app
COPY . .

# Build project
RUN npm run build

# Start the Medusa backend
CMD ["npm", "start"]
