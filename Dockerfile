FROM node:10-alpine
WORKDIR /home/root
COPY . .
RUN npm install
EXPOSE 3000
CMD [ "npm", "start"]
