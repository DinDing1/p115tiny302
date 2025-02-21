# 使用 Alpine 镜像作为基础
FROM python:3.13.2-alpine

# 安装运行时依赖 和 构建依赖（构建后删除）
RUN apk update && apk add --no-cache \
    lz4-libs \
    openssl \
    zlib \
    libuv \
    # 声明构建依赖虚拟组（安装后删除）
    && apk add --no-cache --virtual .build-deps \
    build-base \
    python3-dev \
    libffi-dev \
    openssl-dev \
    zlib-dev \
    libuv-dev

# 升级 pip 并安装 Python 依赖（同时清理缓存）
RUN pip install --no-cache-dir --upgrade pip \
    && pip install --no-cache-dir p115tiny302 \
    # 删除构建依赖和清理 APK 缓存
    && apk del .build-deps \
    && rm -rf /var/cache/apk/*

# 配置工作目录
WORKDIR /app

# 挂载一个目录用来存储 cookie 文件
VOLUME ["/app/115-cookie.txt"]

# 暴露端口 8091
EXPOSE 8091

# 启动命令
CMD ["p115tiny302"]
