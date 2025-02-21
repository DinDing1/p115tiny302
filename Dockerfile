# 使用Python 3.12 slim镜像
FROM python:3.12-slim

# 安装项目依赖
RUN pip install --no-cache-dir p115tiny302

# 配置工作目录
WORKDIR /app

# 挂载一个目录用来存储 cookie 文件
VOLUME ["/app/115-cookie.txt"]

# 暴露端口 8091
EXPOSE 8091

# 启动命令
CMD ["p115tiny302"]
