
cd ~/ && mkdir workdir
mkdir source && cd source
git clone ssh://dave@fusion-arc.uk@source.developers.google.com:2022/p/cloudshare-space/r/django-ecom ./repo --bare
cd repo && git init
cd ~/
git --work-tree=/home/$USER/workdir --git-dir=/home/$USER/source/repo checkout -f
echo
echo "Create Git Hook (Post-receive)"
echo
cat <<EOT >>/home/$USER/source/repo/hooks/post-receive
git --work-tree=/home/$USER/workdir --git-dir=/home/$USER/source/repo checkout -f
echo
source /home/$USER/workdir/venv/bin/activate 
/home/$USER/workdir/venv/bin/pip install -r /home/$USER/workdir/$PROJECTSLUG/requirements.txt
echo
supervisorctl reread
echo
supervisorctl update
EOT
echo
chmod +x /home/$USER/$PROJECTSLUG/repo/hooks/post-receive
echo