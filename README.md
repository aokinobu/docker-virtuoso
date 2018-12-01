# docker-virtuoso
virtuoso on docker

builds from opensource virtuoso.

### notes:

moved to [gitlab](https://gitlab.com/aokinobu/docker-virtuoso).

this uses environment variables for the mounted data folder
${HOME}/${SITE_CODE}/virtuoso/data:/virtuoso

recommended to confirm the following:
HOME=home folder of executing user
SITE_CODE=code name of your site

so the virtuoso db data folder is expected to be in:
/home/username/project_codename/virtuoso/data/

if the db folder (specifically the virtuoso.ini file in the db folder) does not exist, then the default ini file and db folder will be copied from the source code.

have fun!
