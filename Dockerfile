#Targets the node server
FROM node:latest

#SET the working directory on the Node server
WORKDIR /home/app

#copy package.json from local dir to node working dir
COPY package*.json ./

#Run dependencies
RUN npm install

#Copy the rest of the code over: 
COPY . .

#Install NODEMON globally for dev practice
RUN npm install -g nodemon

# Expose 8080: i think this is done in compose, 
EXPOSE 8080

#Run the default start command. Change to "start" once in prod
CMD ["npm", "run", "dev"]