#!/bin/bash
#
# Copyright (c) 2019-2020 P3TERX <https://p3terx.com>
#
# This is free software, licensed under the MIT License.
# See /LICENSE for more information.
#
# https://github.com/P3TERX/Actions-OpenWrt
# File name: diy-part2.sh
# Description: OpenWrt DIY script part 2 (After Update feeds)
#

# 自定义定制选项
ZZZ="package/lean/default-settings/files/zzz-default-settings"
#
sed -i "/uci commit fstab/a\uci commit network" $ZZZ
sed -i "/uci commit network/i\uci set network.lan.ipaddr='192.168.31.3'" $ZZZ                      # IPv4 地址(openwrt后台地址)
sed -i "/uci commit network/i\uci set network.lan.netmask='255.255.255.0'" $ZZZ                    # IPv4 子网掩码
sed -i "/uci commit network/i\uci set network.lan.gateway='192.168.31.1'" $ZZZ                     # IPv4 网关
sed -i "/uci commit network/i\uci set network.lan.broadcast='192.168.31.255'" $ZZZ                 # IPv4 广播
sed -i "/uci commit network/i\uci set network.lan.dns='192.168.31.1'" $ZZZ                         # DNS(多个DNS要用空格分开)
sed -i "/uci commit network/i\uci set network.lan.delegate='0'" $ZZZ                               # 去掉LAN口使用内置的 IPv6 管理
echo "close_dhcp" > package/base-files/files/etc/closedhcp                                         # 关闭DHCP服务

sed -i 's/luci-theme-bootstrap/luci-theme-infinityfreedom/g' feeds/luci/collections/luci/Makefile  # 选择infinityfreedom为默认主题
sed -i "s/OpenWrt /Standard Edition Compiled in $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" $ZZZ    # 增加个性名字Standard Edition
sed -i "/uci commit system/i\uci set system.@system[0].hostname='OpenWrt-GT'" $ZZZ                 # 修改主机名称为OpenWrt-GT
sed -i '/CYXluq4wUazHjmCDBCqXF/d' $ZZZ                                                             # 设置密码为空
sed -i 's/PATCHVER:=5.4/PATCHVER:=5.10/g' target/linux/x86/Makefile                                # x86机型,默认内核5.4，修改内核为5.10
