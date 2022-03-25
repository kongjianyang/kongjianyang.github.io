#!bin/bash

git add .
update_time ="updating site on $(date)" 
read -p  "请输入commit信息：" -t 30 commit_msg #等待30秒
echo $commit_msg
msg="$update_time; $commit_msg" 
git commit -m "$msg"
git push origin master