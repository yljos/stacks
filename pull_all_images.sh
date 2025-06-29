#!/bin/bash

# 设置目标根目录
root_dir="/mnt/user/data/appdata/stacks"

# 遍历目录及子目录
find "$root_dir" -name "compose.yaml" | while read compose_file; do
  echo "更新并重启容器: $compose_file"
  
  # 进入目录并执行更新操作
  dir_name=$(dirname "$compose_file")
  (
    cd "$dir_name"
    
    # 停止并移除容器
    podman-compose down
    
    # 拉取最新镜像
    podman-compose pull
    
    # 启动容器
    podman-compose up -d
  )
done

# 清理无用镜像
echo "清理无用镜像..."
podman image prune -f

echo "所有容器已更新并重启完成！无用镜像已清理！"

