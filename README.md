<h1> Create Your own webpage in docker </h1>
<center><h2>For IT Students at upper secondary school: tutorial github/docker project</h2></center>

<h2> How to get started </h3><br>
1. Make an Github Account<br>
2. <a href="https://github.com/Samoht89/Website1#software-to-use">Download Software</a><br>
3. <a href="https://github.com/Samoht89/Website1#make-github-respitory-docker">Make an respitory</a><br>
4. <a href="https://github.com/Samoht89/Website1/blob/main/README.md#create-a-workflow-to-generate-respitory-to-docker">Create a Workflow</a><br>
5. <a href="https://github.com/Samoht89/Website1/blob/main/README.md#make-docker-composeyml-file">Make docker-compose.yml file</a><br>
6. <a href="https://github.com/Samoht89/Website1/blob/main/README.md#-make-an-indexhtml-">Make index.html file</a><br>
7. <a href="https://github.com/Samoht89/Website1/blob/main/README.md#run-the-workflow">Run the workflow</a><br>
8. Send respitory link to your teatcher<br>
9. <a href="https://github.com/Samoht89/Website1/blob/main/README.md#-update-your-page-">Update Image after editing</a><br>








<center><h3>Software to use</h3></center>
<b>Github Desktop Application</b> to sync the respitory from desktop to gihub and the other way: https://desktop.github.com/
<br><br>
<b>VisualStudio</b> to edit the files: https://code.visualstudio.com/Download
<br><br>
both software is compatible with mac, windows and linux

<h3> Use this respitory as template </h3>
You can also use this respitory as template, but remember to edit docker-compose.yml file in step 5. 

<br>
<center><h3>Make github respitory and make your first page</h3></center>

1. when creating respitory give it a name and add readme. Remember it has to be a public respitory
2. create respitory
3. add file
4. give the file you created this name: Dockerfile
5. insert required data example:
```
   FROM php:apache 
   COPY . /var/www/html/
```
<h3>Create a workflow to generate respitory to docker</h3>
1. go to your github image select action --> create new workflow
(make your own workflow non template)

2. Copy and paste this in the file:
```
 name: Manual Docker Image CI

 permissions:
   contents: read
   packages: write
   id-token: write

 on:
   workflow_dispatch:

 jobs:

   build:

    runs-on: ubuntu-latest

    steps:
    - uses: actions/checkout@v3
    
    - name: Docker Login
      # You may pin to the exact commit or the version.
      # uses: docker/login-action@49ed152c8eca782a232dede0303416e8f356c37b
      uses: docker/login-action@v2.0.0
      with:
        registry: ghcr.io
        username: ${{ github.actor }}
        password: ${{ secrets.GITHUB_TOKEN }}       

    - name: Set up Docker Buildx
      uses: docker/setup-buildx-action@v1

    - name: Cache Docker layers
      uses: actions/cache@v2
      with:
        path: /tmp/.buildx-cache
        key: ${{ runner.os }}-buildx-${{ github.sha }}
        restore-keys: |
          ${{ runner.os }}-buildx-

    - name: Docker Metadata action
      id: docker_meta
      # You may pin to the exact commit or the version.
      # uses: docker/metadata-action@69f6fc9d46f2f8bf0d5491e4aabe0bb8c6a4678a
      uses: docker/metadata-action@v4.0.1
      with:
        # List of Docker images to use as base name for tags
        images: ghcr.io/${{ github.repository }}
        # List of tags as key-value pair attributes
        tags: |
            type=ref,event=branch,suffix=-{{sha}}
            type=ref,event=pr,suffix=-{{sha}}
            type=semver,pattern={{version}}
            type=semver,pattern={{major}}.{{minor}}
            type=sha
        flavor: |
            latest=true

    - name: Build and push Docker images
      # You may pin to the exact commit or the version.
      # uses: docker/build-push-action@e551b19e49efd4e98792db7592c17c09b89db8d8
      uses: docker/build-push-action@v3.0.0
      with:
        push: true
        tags: ${{ steps.docker_meta.outputs.tags }}
        labels: ${{ steps.docker_meta.outputs.labels }}
        cache-from: type=local,src=/tmp/.buildx-cache
        cache-to: type=local,dest=/tmp/.buildx-cache

```
<br>
3. Save File
<br>
<h3>Make docker-compose.yml file</h3>
<br>
remember to change whats neccecary in the file on the image and container_name fields
<br>

```docker-compose.yml

version: '2.0'

services:
    Website1:
        image: ghcr.io/samoht89/website1:latest #change samoht89 to your username and website1 to your respitory name
        deploy:
        labels: [com.centurylinklabs.watchtower.enable=true]
        container_name: website1 #Your firstname-"usernameAtSchool"
        restart: always
        ports:
            - "80:80" #Change first port if using nginx
```
<br>
Remember to save the file!
<br>

<h3> Make an index.html </h3>
Make your index.html file in the root of your respitory. <br>
index.html standard start is:

```
<html>
   <title>Your Title</title>
      <body>
      This is my website
      </body>
</html>
```
<br>
Remember to save the file <br>
<br>

<h3>Run the Workflow</h3>
<br>
1. Go to Action tab in github <br>
2. select Manual Docker Image CI <br>
3. select run workflow (dropdown menu)<br>
4. select run workflow<br>

<br>

<h3> Update your page </h3>
Each time you edit your site and you want to publish it to your page, run the workflow you created in step 4. this will pack the github project to an docker and the server will see its been updatet and update the docker file on the server. Updates every 2 minutes.
<br><br>

<h2> Other languages than html </2>
<h3> Perl </h3>
<br>

```
FROM php:apache 
COPY . /var/www/html/

#Install
RUN apt update && apt install -y libapache2-mod-perl2 libapache2-mod-perl2-dev libcgi-pm-perl liblocal-lib-perl
RUN a2enmod cgid

#Edit apache
RUN echo "<Directory /var/www/html/>" >> /etc/apache2/apache2.conf
RUN echo "Options ExecCGI Includes Indexes FollowSymlinks" >> /etc/apache2/apache2.conf
RUN echo "DirectoryIndex index.pl index.html index.htm index.php" >> /etc/apache2/apache2.conf
RUN echo "AddHandler cgi-script .cgi .pl" >> /etc/apache2/apache2.conf
RUN echo "</Directory>" >> /etc/apache2/apache2.conf

#sets the execute permission
RUN chmod +x /var/www/html/index.pl

```
