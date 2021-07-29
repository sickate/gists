git reset --hard origin/master

git filter-branch --force --index-filter 'git rm --cached --ignore-unmatch zhangyan' --prune-empty --tag-name-filter cat -- --all

