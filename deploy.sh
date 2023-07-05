#!bin/bash

echo -e "\033[0;32mDeploying updates to GitHub...\033[0m"

# Build the project.
hugo # if using a theme, replace with `hugo -t <YOURTHEME>`

echo "Files more than 30M should be ignored"
find ./* -size +30M

# ignore large files
find ./* -size +30M | cat >> .gitignore

git add .
update_time="updating site on $(date)" # 不能有空格
read -p  "请输入commit信息：" -t 30 commit_msg #等待30秒
echo $commit_msg
msg="$update_time; $commit_msg" 
git commit -m "$msg"
git push origin master
