# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2026-present Team CoreELEC (https://coreelec.org)

PKG_NAME="vfs.stream.fast"
PKG_VERSION="1.4.0"
PKG_SHA256=""
PKG_REV="1"
PKG_ARCH="any"
PKG_LICENSE="GPLv2"
PKG_SITE="https://github.com/forbxy/vfs.stream.fast"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain kodi-platform curl libnfs"
PKG_SECTION=""
PKG_SHORTDESC="vfs.stream.fast"
PKG_LONGDESC="High-performance VFS with LRU cache for HTTP/WebDAV/NFS/SMB protocols."

PKG_IS_ADDON="yes"
PKG_ADDON_TYPE="kodi.vfs"

PKG_CMAKE_OPTS_TARGET="-DKODI_SOURCE_DIR=/home/mephis/Project/CoreELEC/kodi-xbmc"

# 使用本地源码
unpack() {
  unpack_local /home/mephis/Project/CoreELEC/vfs.stream.fast
}
