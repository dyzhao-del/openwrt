#!/bin/bash
# 友华K1200JS自定义脚本

echo "开始自定义配置..."

# 进入源码目录
cd openwrt-source

# 1. 修改默认IP地址（从192.168.1.1改为192.168.10.1）
sed -i 's/192.168.1.1/192.168.10.1/g' package/base-files/files/bin/config_generate

# 2. 修改默认主题为argon（如果安装了）
if [ -f feeds/luci/collections/luci/Makefile ]; then
  sed -i 's/luci-theme-bootstrap/luci-theme-argon/g' feeds/luci/collections/luci/Makefile
fi

# 3. 修改默认时区为上海
sed -i "s/'UTC'/'CST-8'/g" package/base-files/files/bin/config_generate
sed -i '/timezone=/a\		set system.@system[-1].zonename='"'"'Asia/Shanghai'"'" package/base-files/files/bin/config_generate

# 4. 修改默认主机名
sed -i 's/OpenWrt/Youhua-K1200JS/g' package/base-files/files/bin/config_generate

# 5. 添加自定义文件（如果需要）
mkdir -p files/etc
echo "欢迎使用友华K1200JS OpenWrt固件" > files/etc/banner

# 6. 确保V2ray配置正确
if [ -f feeds/passwall/v2ray-core/Makefile ]; then
  echo "V2ray-core包存在"
fi

echo "自定义配置完成"
