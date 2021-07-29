# continue download
wget -c URL

# background
wget -b URL

# remote delete after copy
rsync -avz --remove-source-files --exclude 'tmp' --exclude 'test*' -e ssh admin@dss:/data.zip /mnt/
