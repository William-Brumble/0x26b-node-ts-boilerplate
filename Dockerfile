# build stage one
FROM node:20-alpine AS appbuild
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm install
COPY . .
RUN npm run build

# build stage two
FROM node:20-alpine
WORKDIR /usr/src/app
COPY package*.json ./
RUN npm ci
COPY --from=appbuild /usr/src/app/dist ./dist
CMD npm run prod
