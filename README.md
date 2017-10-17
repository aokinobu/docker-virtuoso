# docker-virtuoso
virtuoso on docker

builds from opensource virtuoso, recommended to pull from docker.io

### notes:

this uses environment variables for the mounted data folder
${HOME}/${SITE_CODE}/virtuoso/data:/virtuoso

recommended to confirm the following:
HOME=home folder of executing user
SITE_CODE=code name of your site

so the virtuoso db data folder is expected to be in:
/home/username/project_codename/virtuoso/data/

have fun!
