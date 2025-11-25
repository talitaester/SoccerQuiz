FROM node:18-alpine
WORKDIR /app
COPY package*.json ./
RUN npm install
RUN apk add --no-cache python3 make g++ 
COPY . .
CMD ["node", "index.js"]