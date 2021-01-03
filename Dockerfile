#FROM node:8-stretch
FROM nikolaik/python-nodejs:latest

# Change working directory
WORKDIR /app

# Update packages and install dependency packages for services
RUN apt-get update \
 && apt-get dist-upgrade -y \
 && apt-get clean \
 && echo 'Finished installing dependencies' \
 && ls

# Install npm production packages
COPY package.json /app/
COPY . /app
RUN cd /app; npm install --production


RUN pip install -r requirements.txt \
 && echo 'Finished installing requirements'

ENV NODE_ENV production
ENV PORT 3000

EXPOSE 3000

CMD ["python", "app.py"]
#CMD ["npm", "start"]
