# 使用 Alpine 镜像作为基础
FROM python:3.13.2-alpine

# 安装系统依赖（按需添加）
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl \
    && rm -rf /var/lib/apt/lists/*

# 安装Poetry
ENV POETRY_VERSION=1.8.2
RUN pip install --no-cache-dir "poetry==$POETRY_VERSION"

# 禁用虚拟环境（直接在系统Python中安装）
ENV POETRY_VIRTUALENVS_CREATE=false

# 复制项目文件
COPY pyproject.toml poetry.lock* ./

# 安装项目依赖（如果存在poetry.lock则使用）
RUN poetry install --no-root --no-interaction --no-ansi $(test -f poetry.lock && echo "--no-dev" || echo "" )

# 复制整个项目
COPY . .

# 安装项目本身
RUN poetry install --only-root --no-interaction --no-ansi

# 配置工作目录
WORKDIR /app

# 挂载一个目录用来存储 cookie 文件
VOLUME ["/app/115-cookie.txt"]

# 暴露端口 8091
EXPOSE 8091

# 启动命令
CMD ["p115tiny302"]
