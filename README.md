# OpenResty-ubuntu
 OpenResty ubuntu container
 OpenResty基于ubuntu的容器
# How to use
 绑定目录，绑定端口进行使用
 将工作目录绑定至容器中的/usr/src/app 将开放端口绑定至容器的80端口
 
 如：docker run --rm -t -i --volume="$(pwd):/usr/src/app" -p 3015:80 hbthlw/openresty-ubuntu
 
 示例与参考：https://openresty.org/cn/getting-started.html
# More
```
docker run \
  -d \
  --rm \
  -e "RESTY_ENV=production" \
  -e "DEBUG=server" \
  -u "node" \
  -m "300M" \
  --memory-swap "1G" \
  -p "5002:80" \
  --cpuset-cpus "0-3" \
  --restart "always" \
  -w "/usr/src/app" \
  --volume "$(pwd):/usr/src/app" \
  --name "webapp" \
  hbthlw/openresty-ubuntu
```
# swap大小如何确定

根据centos官网介绍可以得出如下公式：

M = Amount of RAM in GB, and S = Amount of swap in GB, then If M < 2, S = M *2 Else S = M + 2

而且其最小不应该小于32M(never less than 32 MB.)

